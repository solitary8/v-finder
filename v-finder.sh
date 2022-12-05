#!/bin/bash
if [ -z "$*" ]; then
    echo "Usage: ./v-finder.sh [options] [IP]"
    echo "options:"
    echo "-sn: Ping Scan - disable port scan and thus,be faster!" | pv -qL 40
    echo "-Pn: Treat all hosts as online -- skip host discovery,this will be a slower ping but with more information" | pv -qL 40
    echo "-sS/sT/sA/sW/sM: TCP SYN/Connect()/ACK/Window/Maimon scans,this will make yourself super stealthy !No just kidding it won't,it will just make you look stealthy :)" | pv -qL 40
    echo "-p <port ranges>: This option will only scan the ports that you specify,practical for saving time !" | pv -qL 40
    echo "-F: Fast mode - Scan fewer ports than the default scan,this will make your scan less efficient but fast !" | pv -qL 40
    echo "-sV: Probe open ports to determine service/version info,if you wanna know server version and build,use this !" | pv -qL 40
    echo "-O: With this you will know the OS of the device you scanned" | pv -qL 40 
    echo "-6: enable IPv6 scanning !" | pv -qL 40
    echo "examples : " | pv -qL 40
    echo "./scanner.sh -sn 10.3.61.250" | pv -qL 40
    echo "./scanner.sh -Pn 10.3.61.250" | pv -qL 40
    echo "./scanner.sh -p 0-1000 10.3.61.250" | pv -qL 40
    echo "./scanner.sh -sS 10.3.61.250" | pv -qL 40
    echo "./scanner.sh -F 10.3.61.250" | pv -qL 40
    echo "./scanner.sh -sV 10.3.61.250" | pv -qL 40
    echo "./scanner.sh -O 10.3.61.250" | pv -qL 40
    echo "./scanner.sh -6 [IPv6 address]" | pv -qL 40
    echo "Example would be ./v-finder.sh 10.3.61.250" | pv -qL 40
fi
if [[ ! -z "$*" ]] ; then
    echo "Initiating the scan" | pv -qL 10
    echo "Scan has started" | pv -qL 10
    echo "Wait a minute I gotta find the open ports :)" | pv -qL 10
    sudo nmap "$@" 
fi

