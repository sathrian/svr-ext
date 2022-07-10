#!/bin/bash
#
# Script to populate firewall with user group membershipt
#
# Version 10.04.2019a
# Bill Claunch
# Palo Alto Networks
# For official use only
#
clear
echo ""
echo ""
echo "Sending groups to firewall"
echo ""
echo "Password is Pal0Alt0"
echo ""
#
# The following uses the API uploads an xml file which contains user information. The user
# file is groups.xml and must be in the /home/paloalto42/userid directory.
#
# The key value will vary based on the firewall you have deployed. Use the script
# getapikey.sh in this directory to obtain the correct key from your firewall. Paste it in
# after the key= in the command below. Leave all other values in the line unchanged.
#
# key=`cat keyfile.txt`
# echo $key
echo ""
# "https://192.168.50.1/api/?type=user-id" > /home/paloalto42/empty.txt
sudo curl -k -F key=LUFRPT1jUTRPTzYyKzFkOURNd2ZRTTlhdmk4am9tTGM9QXF3eWdmU3ZqUWkzN3IwUmlTTVI0bUwzQjFVSEZIcG5SNzRRWldUMzk1Z2dsSFFrNTBhOVVWZVRYZVVnc0dYdA== --form file=@/home/paloalto42/userID/Ausers.xml "https://192.168.50.1/api/?type=user-id" > /home/paloalto42/empty.txt
echo ""
echo "Process Complete."
echo ""
echo "Use the command show user ip-user-mapping all on the firewall to see"
echo "list of users."
echo ""
echo "Use the command clear user-cache all on the firewall to clear"
echo "the list of users."
echo ""
echo ""
rm /home/paloalto42/empty*
echo "Done."
