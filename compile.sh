#!/bin/bash
source tools

VERSION=0.1-SNAPSHOT

version() {
    echo "$(basename $0)-$VERSION"
}

usage() {
    version
    cat <<EOF
--help) this message
--version) version string
--verbose|-v) enable logging
--logfile <path>) set logfile (default stderr)
--input <path>) set input (default stdin)
--output <path>) set output (default stdout)
EOF
}

# global state

input=/dev/stdin
output=/dev/stdout
logfile=/dev/stderr
verbose=0

# parse arguments

while (( $# > 0 )); do
    case $1 in
        --help)
            usage
            exit ;;
        --version)
            version
            exit ;;
        --verbose|-v)
            verbose=1
            shift ;;
        --logfile)
            logfile=$2
            shift 2 ;;
        --input)
            input=$2
            shift 2 ;;
        --output)
            output=$2
            shift 2 ;;
        --) shift
            args=("${args[@]}" "$@")
            break ;;
        *) args=("${args[@]}" "$1"); shift;
    esac; done

# main

mapfile -t lines < $input
for line in "${lines[@]}"; do
    tokens=($line)
    if [[ ${tokens[0]} == "source" ]]; then
        cat ${tokens[1]}; else
        echo "$line"; fi; done
