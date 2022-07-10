######################################################################################################
# Get Key from Firewall-B and write to Bkeyfile.txt
######################################################################################################
echo "Get API key for Firewall-B"
echo ""
curl -k -X GET "https://192.168.1.253/api/?type=keygen&user=admin&password=Pal0Alt0!" >Bkeyfile.txt
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
#                echo "Your key is below:"
#                echo ""
#                cat Bkeyfile.txt
#                echo ""
#                echo ""
#                echo "The key is also stored in the current directory as " Bkeyfile.txt
#                echo ""
#                echo -n "Press enter to proceed"
######################################################################################################
# Read Bkeyfile.txt into variable.
######################################################################################################
# read API key for FirewallB from Bkeyfile.txt into variable
                tempkeyB=`cat Bkeyfile.txt`
######################################################################################################
# Test User ID logging.
######################################################################################################
# Upload Busers.xml file to Firewall-B
######################################################################################################
echo ""
echo "Uploading user-id information to firewalls."
echo ""
sudo curl -k -F key=$tempkeyB --form file=@/home/lab-user/Scripts/Busers.xml "https://192.168.1.25B/api/?type=user-id" > /home/lab-user/empty.txt
rm /home/lab-user/empty.txt
echo "User-ID information uploaded."
echo ""
echo ""
echo "Generating ping traffic to Internet Zone."
ping www.paloaltonetworks.com -c 3
#Test url logging
echo ""
echo "Generating URL traffic to Internet zone."
echo ""
curl -k https://www.paloaltonetworks.com
echo ""
echo "Generating simulated threat traffic to Internet zone."
#test threat logging
curl -k http://www.paloaltonetworks.com/threat123
curl -k http://www.paloaltonetworks.com/threat123
curl -k http://www.paloaltonetworks.com/threat123
curl -k http://www.paloaltonetworks.com/threat123
echo ""
echo ""
echo "###############################"
echo "Log entry generation complete."
echo "###############################"
echo ""
echo ""
