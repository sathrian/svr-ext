#!/bin/bash
#
# Version 04.30.2020a
# Bill Claunch
# Palo Alto Networks
# For use in Palo Alto Network classes only.
#
# Script used to generate traffic.
# As of this date (4-30-2020), this script is used in Panorama 9.2 Lab 6 for Logs.
# The script generates traffic in the vWire by calling pcap scripts.
#
# Process requires rule on firewall-a that allows Extranet to Users_Net traffic so script can pull API key.
starttime=$SECONDS
#elapsedtime=$starttime-$endtime

clear
clear
echo "    ###################################################" | pv -qL 120
echo "    ##          Generate Traffic for Logging         ##" | pv -qL 120
echo "    ###################################################" | pv -qL 120
echo ""
echo "    This script generates application traffic through Firewall-A" | pv -qL 120
echo ""
echo -n "    Press ENTER to start or CTRL+C to quit." | pv -qL 120
                read anykey
echo ""
echo "Generating Simulated Traffic for Logging Lab."
echo ""
echo "Allow process to finish completely."
echo sleep 5
/home/paloalto42/pcaps92019/attack.pcaps/malwareattacks.sh
/home/paloalto42/pcaps92019/app.pcaps/Appgenerator.sh
/home/paloalto42/pcaps92019/url.pcaps/Webtrafficgenerator.sh
rm Akeyfile.txt
rm Script.Ran.txt

echo ""
echo "Process Complete"

endtime=$SECONDS
elapsedtime=$(( endtime - starttime ))

echo "Elapsed time for this script was "$elapsedtime" seconds."
