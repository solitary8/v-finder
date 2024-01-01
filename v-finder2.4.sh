#!/bin/bash


function bar() {
	python3 progress_bar.py
}
function close_bar() { 
	 #!/bin/bash

	distro=$(awk -F '=' '/^NAME/{gsub(/"/,"",$2); print $2}' /etc/os-release)
	echo "Distribution name is: $distro"

	if [[ "$distro" == *"Fedora"* || "$distro" == *"Kali"* ]]; then
    		gnome-terminal -- bash -c 'xdotool search --name "Scan Status" windowkill %1; exec bash'
	elif [[ "$distro" == *"Manjaro"* ]]; then
    		konsole --hold -e 'xdotool search --name "Scan Status" windowkill %1'
	elif [[ "$distro" == *"Ubuntu"* ]]; then
    		xterm -e 'xdotool search --name "Scan Status" windowkill %1'
	elif [[ "$distro" == *"Debian"* ]]; then 
    		lxterminal -e 'xdotool search --name "Scan Status" windowkill %1'
	else
    		echo "Distribution not supported. File a proposition on GitHub and I'll try to add it :)"
	fi

}

function ending_phrase_file() {
	echo "Your scan is finished and your results have been saved in a file named results.txt." | pv -qL 40
	echo "Don't hesitate to leave feedback on github at https://github.com/solitary8/v-finder :) ." | pv -qL 40
}

function ending_phrase() {
	echo "Your scan is finished and your results should have been outputed to you right now,if they don't open an issue on github and I will fix it." | pv -qL 40
	echo "Don't hesitate to leave feedback on github at https://github.com/soliary8/v-finder :) ." | pv -qL 40
}


function result() {
    results=$(zenity --entry --title="Result config" --text="Do you want to save your results in a file ? Y|n")
    case $results in
        y|Y)
            if [[ $opt_menu == *"Ping scan"* ]]; then
		    bar & 
		    sudo nmap -sn $ip -oN results.txt
		    close_bar
	    	    ending_phrase_file

	    elif [[ $opt_menu == *"Vulnerability Scan"* ]]; then
		    bar &
		    sudo nmap -script vuln $ip -oN results.txt
		    close_bar
	            ending_phrase_file

	    elif [[ $opt_menu == *"Port Scan"* ]]; then
		    bar &
		    sudo nmap -p $port_scan $ip -oN results.txt
	            close_bar
	            ending_phrase_file

	    elif [[ $opt_menu == *"Regular Scan"* ]]; then
		    bar &
		    sudo nmap $ip -oN results.txt
	            close_bar
	            ending_phrase_file

	    elif [[ $opt_menu == *"Stealth Scan"* ]]; then
		    bar &
		    sudo nmap -sS $ip -oN results.txt
	    	    close_bar
	            ending_phrase_file
	    fi
            ;;
        n|N)
            if [[ $opt_menu == *"Ping scan"* ]]; then
		    bar &
		    sudo nmap -sn $ip
		    close_bar
	            ending_phrase
	    elif [[ $opt_menu == *"Vulnerability Scan"* ]]; then
		    bar &
		    sudo nmap -script vuln $ip
		    close_bar
	            ending_phrase
	    
	    elif [[ $opt_menu == *"Port Scan"* ]]; then
		    bar &
		    sudo nmap -p $port_scan $ip
		    close_bar
                    ending_phrase

	    elif [[ $opt_menu == *"Regular Scan"* ]]; then
		    bar &
		    sudo nmap $ip
		    close_bar
                    ending_phrase

	    elif [[ $opt_menu == *"Stealth Scan"* ]]; then
		    bar &
		    sudo nmap -sS $ip
		    close_bar
	            ending_phrase
	    
	    fi
            ;;
        *)
            echo "Enter either y,Y or n,N" | pv -qL 40
            ;;
    esac
}

figlet -c -f big -t -W -k "V-Finder" | lolcat
echo "Hello and Welcome to v-finder !" | pv -qL 40
echo "Type ./v-finder2.4.sh -help to see all the nmap options available !" | pv -qL 40
ip=$(zenity --entry --text "Enter the IP to scan :")

options=("Regular Scan" "Ping scan" "Vulnerability Scan" "Port Scan" "Stealth Scan")

opt_menu=$(zenity --list --title="Option Menu" --column="Scan Options" "${options[@]}" --width=600 --height=800)

case $opt_menu in 
    "Regular Scan")
	    result
            ;;
    "Ping scan")
	    result
	    ;;
    "Vulnerability Scan")
	    result
	    ;;
    "Port Scan")
	    port_scan=$(zenity --entry --title="Port Scan config" --text="Enter the port you want to scan :")
            if [[ $port_scan -lt 65535 ]] && [[ $port_scan -ge 0 ]]; then
            	result  
            else
            	echo "You either entered a number under 0 or over 65535, the last port, please re-run the program and choose a number between 0 and 65535" | pv -qL 40
            fi
            ;;
    "Stealth Scan")
	    zenity --info --title="Warning" --text="WARNING ! Before you start remember that stealth scan doesn't make you invisible !" 
	    result
esac

