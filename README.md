# Symfony development docker images

Leverage the power of docker to make development initialization easy. The goal
is to have the members of your team ready to code very quickly :

1. Installing Docker
2. Installing Docker Compose
3. Running `docker-compose up`

For the moment there is :

- an nginx image
- a php-fpm image
- a php-console image
- a postgres image
- a memcached image
- a mailcatcher image
- an elasticsearch image

All images are based on the same docker image : `ubuntu:trusty`, so that disk
usage is not too high.

## Setup inside a Symfony2 application

The project contains a sample Symfony2 application. You can do the same thing
in your app.

1. Create a docker directory, in order to have a clean separation from the rest
of the project.
2. Create any configuration file needed by the containers you intend to use.
Configuration files could be part of the image rather than mounted on it, that is
true, but having them as part of your application is great, because it makes explicit
what will be needed when deploying the application.
3. Create a `docker-compose.yml` file and map the volume with paths on your host.

## The containers

### The nginx container

By default, defines a `monitoring.*` virtualhost. Try it, it displays nginx and
php-fpm status pages. There also is a `coverage.*` virtualhost, for phpunit users.
It will serve files from `/srv/build/coverage`.

### The php containers

There are three php images. The first one serves as a base for the two others
and you shouldn't use it. The two other are a php-fpm image, and a php-console
image. The php-console was named like this because there are other things than
the `php-cli` package on it : there also is nodejs, ruby-sass and other
development-related things, like composer or php-cs-fixer.

Both images come with XDebug remote debugging ready to use!
XDebug will try to reach your DBGP client on `172.17.42.1:9000`, please ensure
that your client is not only listening on `localhost`.
You will also need to configure remote path mappings in your debugging client
so that the remote `/srv` folder is mapped to where your application is on your
system.

If you are using vim with [vdebug](https://github.com/joonty/vdebug), the
configuration will look like this:

```viml
let g:vdebug_options= {
\    "server": '172.17.0.1',
\    "path_maps": {"/srv": "/home/username/path/to/code"}
\}
```

By default, XDebug is disabled on the console container for performance
reasons. It can be enabled by using php's `-d` flag, like this :

```shell
php -dzend_extension=xdebug.so <your_command_goes_here>
```

The recommended way to login to the console container is to exec the login
command on it, like this:

```shell
docker exec --user=$(whoami) --interactive --tty samplesymfonyapp_console_1 /bin/zsh
```

Of course, you may use `/bin/bash` if you prefer.

To run Composer, you might need to be able to authenticate against private
repositories. Dockerony assumes that you are using `ssh-agent`, and shares the
authentication socket with the console container, mounting it on
`/tmp/agent.sock`. In the environment of the container, `SSH_AUTH_SOCK` is set
to `/tmp/agent.sock`, so that the host ssh agent is used when authenticating
from the container.


### The mailcatcher container

Exposes an administration interface on port 80, and an SMTP service listening
on port 25.

## DNS

### Prerequisites

To use the DNS functionality, you have to run `bin/docker-init`. This script
will run a dns server and map it to your localhost. You might need to have a
look at the documentation of
[dnsdock](https://github.com/tonistiigi/dnsdock/blob/master/readme.md) if it
does not work.

```
bin/docker-init
```

### Configuration

In your docker-compose.yml file you can set `DNSDOCK_NAME` and `DNSDOCK_IMAGE`
for each image that you want to subscribe in DNS. Additionaly, you can set the
`DNSDOCK_ALIAS` to completely bypass the basic naming scheme.

```
webserver:
    image: greg0ire/nginx
    ports:
        - '80'
    environment:
        - DNSDOCK_IMAGE=web
        - DNSDOCK_NAME=my_project
        - DNSDOCK_ALIAS=my_app.dev
```

With that configuration you can access to your image with `my_project.web.docker`
*and* `my_app.dev`

No need to add any host in your hosts file.
