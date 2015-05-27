# Symfony development docker images

Leverage the power of docker to make development initialization easy. The goal
is to have the members of your team ready to code in three steps:

1. Installing Docker
2. Installing Docker Compose
3. Cloning this repo
4. Create a symlink to the repo in their clone of the application.
5. Running `docker-compose up`

Step 1 through 3 will only be needed once in the life of their machine. Step 3.
and 4. can become facultative if you have an image registry. This would leave
only… step 5. That's right, just one command.

For the moment there is :

- an nginx image
- a php image
- a postgres image
- a memcached image
- an elastisearch image

All images are based on the same docker image : `ubuntu:trusty`.

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

By default, defines a monitoring.dev virtualhost. Try it, it displays nginx and
php-fpm status pages.
