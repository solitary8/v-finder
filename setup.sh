#!/bin/bash
uname > /home/edouardw69/.os.txt
file="/home/edouardw69/.os.txt"
file2="/home/edouardw69/.osd.txt"
if cmp -b  "$file" "$file2"; then
sudo apt-get install nmap 
fi

if [[ "$OSTYPE" == "darwin" ]]; then
    echo "You must have paid a lot of money for that mac computer !"
    brew install nmap
    port install nmap
fi
echo 'The setup is finished,enjoy my scanner :)'
echo "Don't do anything illegal with it though :("

