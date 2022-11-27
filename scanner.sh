#!/bin/bash
if [ -z "$@" ]; then
    echo "Usage: ./scanner.sh [IP]"
    echo "Example would be ./scanner.sh 10.3.61.250"
fi

if [[ ! -z "$@" ]] ; then
    echo "Initiating the scan"
    echo "Scan has started"
    echo "Wait a minute I gotta find the open ports :)"
    nmap "$@"
fi
