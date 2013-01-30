#!/bin/bash

VERSION="0.1"
source stub.sh

map() {
    local f=$1 ; shift
    for x in $@; do
        echo $($f $x); done
}

# main

if (( ${#args} == 0 )); then
    usage
    exit 1; fi

map ${args[@]}
