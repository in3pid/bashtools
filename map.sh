#!/bin/bash

IFS=\000

VERSION=0.1-SNAPSHOT

usage() {
    cat << EOF
$(basename $0) [--help] [--version] [-v|--verbose] [--logfile path] arg1 arg2 ...
--help) this message
-v|--verbose) enable logging
--version) version string
--logfile <path>) set logfile
EOF
}

version() {
    echo $(basename $0) $VERSION
}

# global state

verbose=0
logfile=/dev/stderr

# parse script arguments

while (( $# > 0 )); do
    case $1 in
        --help) usage ; exit ;;
        --version) version ; exit ;;
        --verbose|-v) verbose=1 ; shift ;;
        --logfile) logfile=$2 ; shift 2 ;;
        --) shift ; break ;;
        *) args=(${args[@]} $1) ; shift
    esac ; done

# append any remaining

args=(${args[@]} $@)

# our nifty utilities

log() {
    (( $verbose )) || return 0
    if [[ $1 =~ :$ ]]; then
        echo $@ >> $logfile ; else
        echo log: $@ >> $logfile ; fi
}

map() {
    local f=$1 ; shift
    for elt in $@; do
        log map: $elt -\> $($f $elt)
        echo $($f $elt); done
}

# main

map ${args[@]}
