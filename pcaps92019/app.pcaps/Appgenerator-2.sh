#!/bin/bash
#
# Application generating script.
#
# Version 2-24-2020a
# Bill Claunch
# Palo Alto Networks, Inc.
#
# Official Use Only
#
#
######################################################################################################
# Get Key from Firewall-A and write to Akeyfile.txt
######################################################################################################
clear
echo "Get API key for Firewall-A"
echo ""
curl -k -X GET "https://192.168.1.254/api/?type=keygen&user=admin&password=Pal0Alt0!" >Akeyfile.txt
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
#                echo "Your key is below:"
#                echo ""
#                cat Akeyfile.txt
#                echo ""
#                echo ""
#                echo "The key is also stored in the current directory as " Akeyfile.txt
#                echo ""
#                echo -n "Press enter to proceed"
echo "Done."
######################################################################################################
# Read Akeyfile.txt into variable.
######################################################################################################
# read API key for FirewallA from Akeyfile.txt into variable
                tempkeyA=`cat Akeyfile.txt`
######################################################################################################

echo ""
echo ""
echo "Sending userID to firewall"
echo ""
echo ""
#
# The following uses the API uploads an xml file which contains user information. The user
# file is Ausers.xml and must be in the /home/paloalto42/userid/ directory.
# The script also uploads group information.
#
echo ""
sudo curl -k -F key=$tempkeyA --form file=@/home/paloalto42/userID/Ausers.xml "https://192.168.1.254/api/?type=user-id" > /home/paloalto42/empty.txt
sudo curl -k -F key=$tempkeyA --form file=@/home/paloalto42/userID/groups.xml "https://192.168.1.254/api/?type=user-id" > /home/paloalto42/empty2.txt
rm /home/paloalto42/empty.txt
rm /home/paloalto42/empty2.txt
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
starttime=$SECONDS
elapsedtime=$starttime-$endtime
clear
echo "==============================================================="
echo "This script runs packet captures to simulate live traffic."
echo ""
echo "This simulated traffic does not leave the lab environment since"
echo "it is generated only within a limited vWire deployment."
echo ""
echo "The simulated traffic should match a variety of AppIDs which you "
echo "can see in the Traffic Log and in Custom Reports."
echo ""
echo "The script will take about 10 minutes."
echo ""
echo "==============================================================="
echo ""
# read -p "Press Enter to Continue..."

# echo "Application script started at "$(date) >> /home/paloalto42/Script.Ran.txt
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.a.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.b.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.c.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.d.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.e.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.f.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.g.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.h.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.i.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.j.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.k.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.l.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.m.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.n.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.o.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.p.pcapng
sudo tcpreplay --intf1=ens224 --pps=350 pcap9-5.q.pcapng
endtime=$SECONDS
elapsedtime=$(( endtime - starttime ))
echo ""
clear
echo ""
echo "Elapsed time for this script was "$elapsedtime" seconds."
echo ""
echo ""
echo "#########################"
echo "#                       #"
echo "#   Process Complete !  #"
echo "#                       #"
echo "#########################"
# echo "Application script completed at "$(date) >> /home/paloalto42/Script.Ran.txt
rm A-keyfile.txt
