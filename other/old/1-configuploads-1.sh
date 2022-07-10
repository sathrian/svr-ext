#!/bin/bash
# set -x
# Script to upload configuration files to Firewalls and Panorama through API
# Bill Claunch
# Palo Alto Networks
# December 5, 2019

# Script Requirements
#
# Firewall-A needs FW-A-9-1-enhanced configuration in place. This configuration allows the DMZ access
# to Firewall-A through ethernet1/3. The configuration also allows the DMZ server access to the
# management interfaces for Panorama and Firewall-B. Firewall-A uses NAT to hide the source address
# of the DMZ server when it makes API calls to management addresses on Panorama and Firewall-B.

# This script may need to be modified for your environment. It is not supported by Palo Alto Networks
# in any way or manner and is provided only for your possible benefit. Questions about or problems with
# this script will be ruthlessly ignored.

# This script assumes configuration files for firewalls are located in the following directories:
#
# Firewall-A
# /home/paloalto42/configs/firewall-a/
# Firewall-B
# /home/paloalto42/configs/firewall-b
# Panorama
# /home/paloalto42/configs/panorama
#
# You must first copy the appropriate configuration files for each device into the appropriate directory
# before you run this script.
#
# The script also assumes you have configured each device with admin/Pal0Alt0! as credentials.
#
# The script assumes the following IP addresses are in place on each device:
#
# Firewall-A --> 192.168.50.1 on ethernet1/3 with interface management profile allowing HTTPS.
#
# Firewall-B --> 192.168.1.253 on management interface
#
# Panorama ----> 192.168.1.252 on management interface
clear
echo ""
echo "This script uploads configuration files to Panorama, Firewall-A and Firewall-B"
echo ""
echo ""
echo "The process will overwrite files on the target devices if the filenames in place"
echo "on the target are the same as the files being uploaded."
echo ""
                echo -n "Press enter to proceed or use CTRL+C to quit"
                read anykey
#
# BEGIN SCRIPT
#
# Get API Keys for devices

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
echo "Get API Key for firewall-B"
curl -k -X GET "https://192.168.1.252/api/?type=keygen&user=admin&password=Pal0Alt0!" >Bkeyfile.txt
# Clean up key file
# clean up extraneous characters in API response to leave only key
                # Remove > characters
                sed --in-place "s/>/ /g" Bkeyfile.txt
                # Remove < characters
                sed --in-place "s/</ /g" Bkeyfile.txt
                # Remove single quotes
                sed --in-place "s/'/ /g" Bkeyfile.txt
                # Remove extraneous text before key
                sed --in-place 's/ response status =  success   result  key //g' Bkeyfile.txt
                # Remove slashes
                sed --in-place 's/\///g' Bkeyfile.txt
                # Remove extraneous text after key
                sed --in-place 's/ key  result  response //g' Bkeyfile.txt
                echo "Your key is below:"
                echo ""
                cat Bkeyfile.txt
                echo ""
                echo ""
                echo "The key is also stored in the current directory as " Bkeyfile.txt
                echo ""
                echo -n "Press enter to proceed"
                read anykey
echo "Get API Key for Panorama"
curl -k -X GET "https://192.168.1.253/api/?type=keygen&user=admin&password=Pal0Alt0!" >PANOkeyfile.txt
# Clean up key file
# clean up extraneous characters in API response to leave only key
                # Remove > characters
                sed --in-place "s/>/ /g" PANOkeyfile.txt
                # Remove < characters
                sed --in-place "s/</ /g" PANOkeyfile.txt
                # Remove single quotes
                sed --in-place "s/'/ /g" PANOkeyfile.txt
                # Remove extraneous text before key
                sed --in-place 's/ response status =  success   result  key //g' PANOkeyfile.txt
                # Remove slashes
                sed --in-place 's/\///g' PANOkeyfile.txt
                # Remove extraneous text after key
                sed --in-place 's/ key  result  response //g' PANOkeyfile.txt
                echo "Your key is below:"
                echo ""
                cat PANOkeyfile.txt
                echo ""
                echo ""
                echo "The key is also stored in the current directory as " PANOkeyfile.txt
                echo ""
                echo -n "Press enter to proceed"
                read anykey
# read API key for FirewallA from Akeyfile.txt into variable
                tempkeyA=`cat Akeyfile.txt`
# read API key for FirewallB from Bkeyfile.txt into variable
                tempkeyB=`cat Bkeyfile.txt`
# read API key for Panorama from PANOkeyfile.txt into variable
                tempkeyPANO=`cat PANOkeyfile.txt`
# Set variables for Firewall-A configuration files
AFILES=/home/paloalto42/configs/firewall-a/*
for f in $AFILES
# Begin Uploading files
do
  echo "Uploading $f to firewall-a"
echo ""
#
curl -k -F key=$tempkeyA --form file=@$f "https://192.168.50.1/api/?type=import&category=configuration" > /dev/null
#
echo ""
echo "Finished uploading $f to firewall-a"
#
# loop to Uploading files
 done
#
# Set variables for Firewall-B configuration files
#
BFILES=/home/paloalto42/configs/firewall-b/*
for f in $BFILES
# Begin Uploading files
do
  echo "Uploading $f to firewall-b"
echo ""
#
curl -k -F key=$tempkeyB --form file=@$f "https://192.168.1.253/api/?type=import&category=configuration" > /dev/null
#
echo ""
echo "Finished uploading $f to firewall-b"
#
# loop to Uploading files
 done
#
# Set variables for Panorama configuration files
#
PFILES=/home/paloalto42/configs/panorama/*
for f in $PFILES
# Begin Uploading files
do
  echo "Uploading $f to panorama"
echo ""
#
curl -k -F key=$tempkeyPANO --form file=@$f "https://192.168.1.252/api/?type=import&category=configuration" > /dev/null
#
echo ""
echo "Finished uploading $f to Panorama"
#
# loop to Uploading files
 done
#
echo "Process complete."
echo ""
echo "Connect to devices through SSH and use the following command to view configuration files:"
echo ""
echo "show config saved <TAB>"
