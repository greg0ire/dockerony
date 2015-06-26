#!/bin/bash
main() {
    readonly TEMPLATEDIR=$(readlink -m $0/../src)

    readonly DIR=$1
    readonly DOCKERONYDIR=$2

    # Copy files
    cp --recursive --no-clobber $TEMPLATEDIR/* $DIR

    # Build`'docker-images' symlink
    ln --symbolic $DOCKERONYDIR $DIR/docker/docker-images
}

main $@
