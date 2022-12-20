#!/bin/bash
if [[ "$OSTYPE" == "darwin" ]]; then
    echo "You must have paid a lot of money for that mac computer !"
    brew install nmap
    port install nmap
fi
distro=$(lsb_release -i | cut -f 2)
echo "distro name is : $distro"

if [[ "$distro" == Fedora* ]]; then
sudo dnf install pv nmap
elif [[ "$distro" == Manjaro* ]]; then
sudo pacman -S pv nmap
fi
chmod +x v-finder2.1.sh
echo 'The setup is finished,enjoy my scanner :)' | pv -qL 40 
echo "Don't do anything illegal with it though :(" | pv -qL 40 

