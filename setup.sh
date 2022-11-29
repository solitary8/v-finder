#!/bin/bash
uname > .os.txt
file=".os.txt"
file2=".osd.txt"
if cmp -b  "$file" "$file2"; then
sudo apt-get install nmap 
fi

if [[ "$OSTYPE" == "darwin" ]]; then
    echo "You must have paid a lot of money for that mac computer !"
    brew install nmap
    port install nmap
fi
chmod +x scanner.sh
echo 'The setup is finished,enjoy my scanner :)'
echo "Don't do anything illegal with it though :("

