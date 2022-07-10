#!/bin/bash
#
# Script to populate firewall with userid entries
#
# Version 8.29.19.a
# Bill Claunch
# Palo Alto Networks
# For official use only
#
clear
echo ""
echo ""
echo "Sending userID to firewall"
echo ""
echo "Password is Pal0Alt0"
echo ""
#
# The following uses the API uploads an xml file which contains user information. The user
# file is bigusers.xml and must be in the /home/paloalto42/ directory.
#
# The key value will vary based on the firewall you have deployed. Use the script
# getapikey.sh in this directory to obtain the correct key from your firewall. Past it in
# after the key= in the command below. Leave all other values in the line unchanged.
#
# key=`cat keyfile.txt`
# echo $key
echo ""
# "https://192.168.50.1/api/?type=user-id" > /home/paloalto42/empty.txt
sudo curl -k -F key=LUFRPT14MW5xOEo1R09KVlBZNnpnemh0VHRBOWl6TGM9bXcwM3JHUGVhRlNiY0dCR0srNERUQT09 --form file=@/home/paloalto42/userID/groups.xml "https://192.168.50.1/api/?type=user-id" > /home/paloalto42/empty.txt
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
