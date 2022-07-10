#!/bin/bash
# Bill Claunch
# Palo Alto Networks
# December 5, 2019
#
# This script retrieves the API key for firewall-a and then uploads a configuation file to allo
# for easy uploading of configuration files to firewall-a, firewall-b and panorama.
#
# Get api key from firewall-a
echo "Get API Key for firewall-A"
curl -k -X GET "https://192.168.50.1/api/?type=keygen&user=admin&password=Pal0Alt0!" >Akeyfile.txt
# Clean up key file
# clean up extraneous characters in API response to leave only key
                # Remove > characters
                sed --in-place "s/>/ /g" Akeyfile.txt
                # Remove < characters
                sed --in-place "s/</ /g" Akeyfile.txt
                # Remove single quotes
                sed --in-place "s/'/ /g" Akeyfile.txt
                # Remove extraneous text before key
                sed --in-place 's/ response status =  success   result  key //g' Akeyfile.txt
                # Remove slashes
                sed --in-place 's/\///g' Akeyfile.txt
                # Remove extraneous text after key
                sed --in-place 's/ key  result  response //g' Akeyfile.txt
                echo "Your key is below:"
                echo ""
                cat Akeyfile.txt
                echo ""
                echo ""
                echo "The key is also stored in the current directory as " Akeyfile.txt
                echo ""
                echo -n "Press enter to proceed"
                read anykey
# read API key for FirewallA from Akeyfile.txt as variable tempkeyA
                tempkeyA=`cat Akeyfile.txt`
# Configuration files must be in following directory
# /home/paloalto42/configs/firewall-a/
# Import file to firewall-a
echo "Importing FW-A-9-1-enhanced to Firewall-a"
curl -k -F key=$tempkeyA --form file=@/home/paloalto42/configs/firewall-a/FW-A-9-1-enhanced "https://192.168.50.1/api/?type=import&category=configuration" > /dev/null
echo "Loading FW-A-9-1-enhanced to firewall-a"
curl -k -F key=$tempkeyA "https://192.168.50.1/api/?type=op&cmd=<load><config><from>FW-A-9-1-enhanced</from></config></load>"
echo "Commit changes to firewall-a"
# commit config FW-A-9-1-enhanced to firewall-a
curl -k -F key=$tempkeyA "https://192.168.50.1/api/?type=commit&cmd=<commit><force></force></commit>"
