#!/bin/sh
# Menu-driven script for API tasks
# Bill Claunch
# version.08.12.2017a
# For official use only. Do not distribute.
################
# Display Menu
################
clear
# start menu loop
while true
do
echo ""
echo "API Script Menu"
echo ""
echo "If you have not dones so already, choose option 1 to generate"
echo "an API key for your firewall that will be used for other options"
echo "in this script. The API is stored in the current directory as"
echo "keyfile.txt"
echo ""
echo "1. Get the API key for your firewall"
echo "2. Get configuration file from firewall and store on this host"
echo "3. Send commit to firewall"
echo "4. Display security policy rules"
echo "11. Display predefined report"
echo "12. Show list of predefined reports"
echo ""
echo "q. Quit"
echo ""
echo -n "Please choose an option > " ; read answer
# read user choice
# read answer
case $answer in
#########################################################################
########################################################################
# This section generates an API key for the firewall and stores it as keyfile.txt
# The keyfile.txt is used in other sections of the script for API queries
#
	1)    echo You chose 1. Get the API key for your firewall
		echo ""

		echo "Get API from firewall and store as file"
		echo "File name will be IPAddress.keyfile.txt"
		echo ""
		echo -n "Enter the IP of your firewall interface for API request > " ; read IP
		# get IP address input from user and store as variable $IP
		echo ""
		echo "You entered >" $IP
		touch $IP.mgtmntip.txt
		echo $IP > $IP.mgtmntip.txt
		echo ""
		echo -n "Enter the administrator username > "
		# get admin account name from user and store as variable $admin
		read admin
		echo ""
		echo "You entered >"$admin
		echo ""
		echo -n "Enter the administrator password > "
		# get password from user and store as variable $password
		read password
		echo ""
		echo "You entered > "$password
		echo ""
		# show what the api call will look like
		echo "The structure of the API call is: "
		echo ""
		echo "curl -k -X GET https://"$IP"/api/?type=keygen&user="$admin"&password="$password
		echo ""
		echo -n "Press Enter to continue..." ; read key
		# make api call for Key and pipe to keyfile.txt
		curl -k -X GET "https://$IP/api/?type=keygen&user=$admin&password=$password" >$IP.keyfile.txt
		clear
		# display keyfile.txt
		cat $IP.keyfile.txt
		# clean up extraneous characters in API response to leave only key
		# Remove > characters 
		sed --in-place "s/>/ /g" $IP.keyfile.txt
		# Remove < characters
		sed --in-place "s/</ /g" $IP.keyfile.txt
		# Remove single quotes
		sed --in-place "s/'/ /g" $IP.keyfile.txt
		# Remove extraneous text before key
		sed --in-place 's/ response status =  success   result  key //g' $IP.keyfile.txt
		# Remove slashes
		sed --in-place 's/\///g' $IP.keyfile.txt
		# Remove extraneous text after key
		sed --in-place 's/ key  result  response //g' $IP.keyfile.txt
		clear
		echo "Your key is below:"
		echo ""
		cat $IP.keyfile.txt
		echo ""
		echo ""
		echo "The key is also stored in the current directory as " $IP.keyfile.txt
		echo ""
		echo -n "Press enter to proceed"
		read anykey
                clear;;
	2)    echo You chose 2. Get the configuration from your firewall
		# set date variable
		now=$(date +"%m_%d_%Y")
		echo "Script to pull configuration file and store in Date.MgtIP.running-config.xml"
		echo ""
		echo -n "Enter the management IP of your firewall > "
		# read management IP variable from user input
		read mgtIP
		echo ""
		echo "You entered " $mgtIP
		echo ""
                # read API key from keyfile.txt
                tempkey=`cat $mgtIP.keyfile.txt`
		echo "The structure of this API call is:"
		echo ""
		echo "curl -KG https://$mgtIP/api/?type=export&category=configuration&key=$tempkey"
		echo ""
echo -n "Press Enter to continue..." ; read anykey

#		echo $tempkey
#		cat $tempkey
		# start API call and pipe to running-config.xml
		curl -kG "https://$mgtIP/api/?type=export&category=configuration&key=$tempkey" > running-config.xml
		read -p "Press Enter to see the config file."
		cat running-config.xml
		echo -n "asdfsad"
		read -p anykey
		# rename running-config.xml to Date-IP.running-config.xml
		mv running-config.xml $now-$mgtIP.xml
		# return to menu
echo -n "Press Enter to continue..." ; read key
                clear;;

	3)    echo You chose 3. Send commit to the firewall
		echo ""
		echo ""
		echo -n "Enter the management IP of your firewall > "
		# read management IP variable from user input
		read mgtIP
		echo ""
		echo "You entered " $mgtIP
		echo ""
		echo "The structure of this API call is:"
		echo ""
		echo curl -k "https://$mgtIP/api/?type=commit&cmd=<commit></commit>&key=$tempkey"
		echo ""
		echo "Note - You need to make a change to the configuration first in order for this"
		echo "command to work."
		echo ""
echo -n "Press Enter to continue..." ; read key
		# read API key from keyfile.txt
		tempkey=`cat keyfile.txt`
		# start API call for commit
		echo ""
		curl -k "https://$mgtIP/api/?type=commit&cmd=<commit></commit>&key=$tempkey"
		echo ""
		# return to menu
		echo ""
echo -n "Press Enter to continue..." ; read key
                clear;;

	4)    echo You chose 10. Display security policy rules
		echo ""
		echo ""
		echo -n "Enter the management IP of your firewall > "
		# read management IP variable from user input
		read mgtIP
		echo ""
		echo "You entered " $mgtIP
		echo ""
                # read API key from keyfile.txt
                tempkey=`cat keyfile.txt`
		echo "The structure of this API call is:"
		echo ""
		echo curl -k "https://$mgtIP/api/?type=config&action=show&key=$tempkey&xpath&xpath=/config/devices/entry/vsys/entry/rulebase/security&key=$tempkey"
		echo ""
echo -n "Press Enter to continue..." ; read key
		# start API call for config file
		echo ""
		curl -k "https://$mgtIP/api/?type=config&action=show&key=$tempkey&xpath&xpath=/config/devices/entry/vsys/entry/rulebase/security"  > config.txt
		cat config.txt| grep "entry name"
		echo ""
		# return to menu
		echo ""
echo -n "Press Enter to continue..." ; read key
                clear;;	
	11)    echo You chose 11. Display a predefined report.
		echo ""
		echo ""
		echo -n "Enter the management IP of your firewall > "
		# read management IP variable from user input
		read mgtIP
		echo ""
		echo "You entered " $mgtIP
		echo ""
		# read report name from user input
		echo -n "Enter the name of the report > "
		read predefreport
		echo ""
		echo "You entered " $predefreport
		echo ""
		echo ""
                # read API key from keyfile.txt
                tempkey=`cat keyfile.txt`
		echo "The structure of this API call is:"
		echo ""
		echo "curl -k https://$mgtIP//api/?type=report&async=yes&reporttype=predefined&reportname=$predefreport&key=$tempkey"
		echo ""
		echo ""
		read -p "Press Enter to proceed."
		# start API call for commit
		echo ""
		curl -k "https://$mgtIP//api/?type=report&async=yes&reporttype=predefined&reportname=$predefreport&key=$tempkey"
		echo ""
		# return to menu
		echo ""
echo -n "Press Enter to continue..." ; read key
                clear;;
################################
# This section defines exit break

	q)    echo Exiting
		clear
		break;;
	*)    echo You did not chose a valid option
		echo ""
                read -p "Press enter to display menu"
                clear;;
esac
# stop menu loop
done
