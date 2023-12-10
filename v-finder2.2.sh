#!/bin/bash

function result() {
    results=$(zenity --entry --title="Result config" --text="Do you want to save your results in a file ? Y|n")
    case $results in
        y|Y)
            if [[ $opt_menu == *"Ping scan"* ]]; then
		    sudo nmap -sn $ip <<< results.txt
		    echo "Your scan is finished and your results have been saved in a file named results.txt" | pv -qL 40
	    elif [[ $opt_menu == *"Vulnerability Scan"* ]]; then
		    sudo nmap -script vuln $ip <<< results.txt
		    echo "Your scan is finished and your results have been saved in a file named results.txt" | pv -qL 40
	    else
		    sudo nmap $ip <<< results.txt
	    
	    fi
            ;;
        n|N)
            if [[ $opt_menu == *"Ping scan"* ]]; then
		    sudo nmap -sn $ip
	    elif [[ $opt_menu == *"Vulnerability Scan"* ]]; then
		    sudo nmap -script vuln $ip
	    else
		    sudo nmap $ip 
	    
	    fi
            ;;
        *)
            echo "Enter either y,Y or n,N" | pv -qL 40
            ;;
    esac
}

figlet -c -f big -t -W -k "V-Finder" | lolcat
echo "Hello and Welcome to v-finder !" | pv -qL 40
echo "Type ./v-finder2.2.sh -help to see all the nmap options available !" | pv -qL 40
ip=$(zenity --entry --text "Enter the IP to scan :")

options=("Regular Scan" "Ping scan" "Vulnerability Scan" "Port Scan")

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
            if [[ $port_scan < 65535 && $port_scan > 0 ]]; then
            	sudo nmap $ip -p $port_scan | tail | grep "scan" 
            else
            	echo "You either entered a number under 0 or over 65535, the last port, please re-run the program and choose a number between 0 and 65535" | pv -qL 40
            fi
            ;;
esac

