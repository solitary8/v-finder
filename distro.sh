function close_bar() { 

	distro=$(awk -F '=' '/^NAME/{gsub(/"/,"",$2); print $2}' /etc/os-release)
	echo "$distro"

	#if [[ "$distro" == *"Fedora"* || "$distro" == *"Kali"* ]]; then
    #		gnome-terminal -- bash -c 'xdotool search --name "Scan Status" windowkill %1; exec bash'
	#elif [[ "$distro" == *"Manjaro"* ]]; then
    #		konsole --hold -e 'xdotool search --name "Scan Status" windowkill %1'
	#elif [[ "$distro" == *"Ubuntu"* ]]; then
    #		xterm -e 'xdotool search --name "Scan Status" windowkill %1'
	#elif [[ "$distro" == *"Debian"* ]]; then 
    #		lxterminal -e 'xdotool search --name "Scan Status" windowkill %1'
	#else
    #		echo "Distribution not supported. File a proposition on GitHub and I'll try to add it :)"
	#fi

}
close_bar