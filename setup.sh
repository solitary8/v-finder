#!/bin/bash
python -m venv vfinder
subprocess.Popen(['lxterminal', '-e', 'source', '.venv.sh'])
# Check the OS type
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "You must have paid a lot of money for that Mac computer!"
    # Install required packages for macOS
    brew install nmap pv zenity figlet lolcat xdotool
    port install nmap pv zenity figlet lolcat xdotool
    port install python3-customtkinter python3-virtualvenv
else
    # Parse the distribution name from /etc/os-release
    distro=$(awk -F '=' '/^NAME/{gsub(/"/,"",$2); print $2}' /etc/os-release)
    echo "Distribution name is: $distro"

    if [[ "$distro" == *"Fedora"* ]]; then
        sudo dnf install -y python3-customtkinter pv nmap zenity  xdotool python3-virtualvenv
        
    elif [[ "$distro" == *"Manjaro"* ]]; then
        sudo pacman -S --noconfirm python3-customtkinter pv nmap zenity xdotool python3-virtualvenv
    elif [[ "$distro" == *"Ubuntu"* || "$distro" == *"Debian"* || "$distro" == *"Kali GNU/Linux"* ]]; then
        sudo apt-get update
        sudo apt-get install -y python3-customtkinter pv nmap zenity figlet lolcat xdotool python3-virtualvenv
    else
        echo "Distribution not supported. File a proposition on GitHub and I'll try to add it :)"
    fi
fi

# Remaining part of your script
echo 'The setup is finished, enjoy my scanner :)' | pv -qL 40 
echo "Don't do anything illegal with it though :(" | pv -qL 40
python3 v-finder3.0.py

