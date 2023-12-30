#!/bin/bash


function bar() {
	python3 progress_bar.py
}


function result() {
    results=$(zenity --entry --title="Result config" --text="Do you want to save your results in a file ? Y|n")
    case $results in
        y|Y)
            if [[ $opt_menu == *"Ping scan"* ]]; then
		    sudo nmap -sn $ip -oN results.txt  & bar 
			xdotool search --onlyvisible --name "Scan Status" windowkill %1
		    echo "Your scan is finished and your results have been saved in a file named results.txt" | pv -qL 40
	    elif [[ $opt_menu == *"Vulnerability Scan"* ]]; then
		    sudo nmap -script vuln $ip -oN results.txt
		    echo "Your scan is finished and your results have been saved in a file named results.txt" | pv -qL 40
	    elif [[ $opt_menu == *"Port Scan"* ]]; then
		    sudo nmap -p $port_scan $ip -oN results.txt
	    
	    elif [[ $opt_menu == *"Regular Scan"* ]]; then
		    sudo nmap $ip -oN results.txt
	    
	    elif [[ $opt_menu == *"Stealth Scan"* ]]; then
		    sudo nmap -sS $ip -oN results.txt
	    
	    fi
            ;;
        n|N)
            if [[ $opt_menu == *"Ping scan"* ]]; then
		    sudo nmap -sn $ip
	    elif [[ $opt_menu == *"Vulnerability Scan"* ]]; then
		    sudo nmap -script vuln $ip
	    
	    elif [[ $opt_menu == *"Port Scan"* ]]; then
		    sudo nmap -p $port_scan $ip
	    elif [[ $opt_menu == *"Regular Scan"* ]]; then
		    sudo nmap $ip 
	    elif [[ $opt_menu == *"Stealth Scan"* ]]; then
		    sudo nmap -sS $ip
	    
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

