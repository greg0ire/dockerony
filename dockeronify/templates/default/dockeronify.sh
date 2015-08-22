#!/bin/bash
main() {
    readonly TEMPLATEDIR=$(readlink -m $0/../src)

    readonly DIR=$1

    # Copy files
    cp --recursive --no-clobber $TEMPLATEDIR/* $DIR
}

main $@
