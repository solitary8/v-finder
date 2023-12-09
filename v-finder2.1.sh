#!/bin/bash
echo "Welcome to my scanner ! " | pv -qL 40
tput setaf 123
echo "                _______  _______            ______    _______   ____  "
echo "\       /     |            |     |\    |  |      |  |         |     |"
echo " \     /______|_____       |     | \   |  |      |  |         |     |"
echo "  \   /       |            |     |  \  |  |      |  |-------  |_____|"
echo '   \ /        |            |     |   \ |  |      |  |         |      \'
echo '    /         |         ___|___  |    \|  |______   | _______ |       \'
echo 'type ./v-finder2.1.sh -h for more options ;)'
tput init
if [ "$*" == "-h" ]; then
sudo nmap -h
elif [[ ! "$*" ]]; then
  tput setaf 10  
  echo "Please Input the IP you want me to  scan : " | pv -qL 40
  read IP 
  echo "Input the options you want to associate with the IP :" | pv -qL 40
  read options
  read -p "Do you want to save your results in a file? Y/n :" choice
  case "$choice" in
          "y"|"Y")
                echo "Ok,I will  save the results in a file named results.txt"| pv -qL 40
                echo "Your scan is starting,don't do anything illegal with it :)"| pv -qL 40
                sudo nmap "$options" "$IP" >> results.txt
		 exit;;
         "n"|"N")
                echo "Ok,the results will be printed as the scan progresses" | pv -qL 40
                sudo nmap "$options" "$IP" | pv -qL 40
                 exit;;
         * ) echo "invalid response" | pv -qL 40
esac
fi
