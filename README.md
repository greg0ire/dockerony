# Symfony development docker images

Leverage the power of docker to make development initialization easy. The goal
is to have the members of your team ready to code very quickly :

1. Installing Docker
2. Installing Docker Compose
3. Cloning this repo
4. Create a symlink to the repo in their clone of the application.
5. Running `docker-compose up`

Step 1 through 3 will only be needed once in the life of their machine. Step 3.
and 4. can become optional if you have an image registry. This would leave
only… step 5. That's right, just one command.

For the moment there is :

- an nginx image
- a php image
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
2. Create a `Dockerfile`. It will contain the definition for
the data container of your application. It should consist only of `VOLUME`
statements, defining which files and directories will be shared with the containers.
Make sure to only use `VOLUMES` corresponding to containers you will be using.
3. Create any configuration file needed by the containers you intend to use.
Configuration files could be part of the image rather than mounted on it, that is
true, but having them as part of your application is great, because it makes explicit
what will be needed when deploying the application.
4. Create a symlink to the clone of this project, it will be used to tell
`docker-compose` where to look for images. It should not be under version control.
5. Create a `docker-compose.yml` file and map the volume with paths on your host.

## The containers

### The nginx container

By default, defines a `monitoring.*` virtualhost. Try it, it displays nginx and
php-fpm status pages. There also is a `coverage.*` virtualhost, for phpunit users.
It will serve files from `/srv/build/coverage`.

### The php container

It comes with XDebug remote debugging ready to use!
XDebug will try to reach your DBGP client on `172.17.42.1:9000`, please ensure
that your client is not only listening on `localhost`.
You will also need to configure remote path mappings in your debugging client
so that the remote `/srv` folder is mapped to where your application is on your
system.

If you are using vim with [vdebug](https://github.com/joonty/vdebug), the
configuration will look like this:

```viml
let g:vdebug_options= {
\    "server": '172.17.42.1',
\    "path_maps": {"/srv": "/home/username/path/to/code"}
\}
```

The recommended way to login to this container is to exec the login command on
it, like this:

```shell
docker exec --interactive --tty samplesymfonyapp_appserver_1 /bin/login -p -f $(whoami)
```

The `-p` flag tells login to preserve the environment, which contains
`SSH_AUTH_SOCK`, used when authenticating against remove service that provide
composer packages. The `-f` flag will allow us to bypass authentication.

### The mailcatcher container

Exposes an administration interface on port 80, and an SMTP service listening
on port 25.

## DNS

### Prerequisites

To use the DNS functionality, you have to run 'bin/docker-init' with root privileges

```
sudo bin/docker-init
```

### Configuration

In your docker-compose.yml file you can set `DNSDOCK_NAME` and `DNSDOCK_IMAGE`
for each image that you want to subscribe in DNS. Additionaly, you can set the
`DNSDOCK_ALIAS` to completely bypass the basic naming scheme

```
webserver:
    build: ./docker/docker-images/nginx
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
