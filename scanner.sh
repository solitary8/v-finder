#!/bin/bash
#This is the part that displays all the options and usage examples
if [ -z "$@" ]; then
    echo "Usage: ./scanner.sh [options] [IP]"
    echo "options:"
echo "-sn: Ping Scan - disable port scan and thus,be faster!"
echo "-Pn: Treat all hosts as online -- skip host discovery,this will be a slower ping but with more information"
echo "-sS/sT/sA/sW/sM: TCP SYN/Connect()/ACK/Window/Maimon scans,this will make yourself super stealthy !No just kidding it won't :)"
echo "-p <port ranges>: This option will only scan the ports that you specify,practical for saving time !"
echo "-F: Fast mode - Scan fewer ports than the default scan,this will make your scan less efficient but fast !"
echo "-sV: Probe open ports to determine service/version info,if you wanna know server version and build,use this !"
echo "-O: With this you will know the OS of the device you scanned"
echo "-6: enable IPv6 scanning !"
echo "examples : "
echo "./scanner.sh -sn 10.3.61.250"
echo "./scanner.sh -Pn 10.3.61.250"
echo "./scanner.sh -sS 10.3.61.250"
echo "./scanner.sh -F 10.3.61.250"
echo "./scanner.sh -sV 10.3.61.250"
echo "./scanner.sh -O 10.3.61.250"
echo "./scanner.sh -6 [IPv6 address]"



    echo "Example would be ./scanner.sh 10.3.61.250"
fi
#This is the IP and no options part
if [[ ! -z "$@" ]] ; then
    echo "Initiating the scan"
    echo "Scan has started"
    echo "Wait a minute I gotta find the open ports :)"
    sudo nmap "$@"
fi
#This is the double scan part of the script
if [[ ! -z "$1" ]] 
then
    echo "Initiating double option scan"
    echo "Scan has started !"
    echo "Finding open ports"
    sudo nmap "$1" "$@"
fi
#projects : support the -p option,add more options
