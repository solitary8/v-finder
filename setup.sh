#!/bin/bash
if [[ "$OSTYPE" == "darwin" ]]; then
    echo "You must have paid a lot of money for that mac computer !"
    brew install nmap
    port install nmap
    brew install pv 
    brew install zenity
    port install pv
    port install zenity
    brew install figlet
    port install figlet
fi
distro=$(awk -F '=' 'NR==1 {print $2}' /etc/os-release)
echo "distro name is : $distro"

if [[ "$distro" == Fedora* ]]; then
sudo dnf install pv nmap zenity figlet
elif [[ "$distro" == Manjaro* ]]; then
sudo pacman -S pv nmap zenity figlet
fi
if [[ "$distro" == *"Ubuntu"* ]]; then 
sudo apt-get upgrade
sudo apt-get install pv nmap zenity figlet

else
echo "Distro not supported,file a proposition on github and I'll try to add it. :)"
fi
if [[ "$distro" == *"Kali GNU/Linux Rolling"* ]]; then
sudo apt-get upgrade
sudo apt-get install pv nmap figlet zenity
fi
chmod +x v-finder2.2.sh
echo 'The setup is finished,enjoy my scanner :)' | pv -qL 40 
echo "Don't do anything illegal with it though :(" | pv -qL 40 
./v-finder2.2.sh
