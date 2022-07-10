#!/bin/bash
#
# Syslog web page script
#
# Version 04.30.2020a
# Bill Claunch
# Palo Alto Networks
# For use in Palo Alto Network classes only.#
# Description
#
# This script copies portions of the /var/log/syslog file and makes them available
# through a web page on this server.
#
# This is a bit more student-friendly approach than using tail -f for syslog through a
# terminal connection to the server.
#
# Students can use a browser to view the file which is updated every few seconds.
#
# Script requires that Apache be configured with a site that Handles the name-based
# server on address 192.168.50.55.
# Address 192.168.50.55
# Port Any	Server Name Automatic
# Document Root /home/paloalto42/misc/syslog
#
# Script should be configured to run at startup as background job for root user or sudoer
# Currently - this is not in place.
#
# Script should be placed in the following directory:
# /home/paloalto42/misc/syslog/
#
while true
do
# Remove firewall.log file if it exists
rm /home/paloalto42/misc/syslog/firewall.log
# Create temporary holding file for unsorted contents of syslog entries
touch /home/paloalto42/misc/syslog/firewall1.log
# Search syslog file for instances of the word 'fw'
# append output to firewall1.log file and sort lines in reverse order
# with most recent at the top.
sort -r /var/log/syslog | grep Sydney>> /home/paloalto42/misc/syslog/firewall.log1
# Search syslog file for instances of the word 'panorama'
# append output to firewall1.log file and sort lines in reverse order
# with most recent at the top.
sort -r /var/log/syslog | grep panorama >> /home/paloalto42/misc/syslog/firewall.log1
# Search syslog file for instances of the word 'firewall'
# append output to firewall1.log file and sort lines in reverse order
# with most recent at the top.
sort -r /var/log/syslog | grep Firewall >> /home/paloalto42/misc/syslog/firewall.log1
# Insert blank line between each entry and write to new file called firewall.log
# firewall.log file is accessible through web browser using http://192.168.50.55/firewall.log
sed -e 'G;' /home/paloalto42/misc/syslog/firewall.log1 > /home/paloalto42/misc/syslog/firewall.log
# Remove holding file firewall.log1
rm /home/paloalto42/misc/syslog/firewall.log1
# Sleep for 3 seconds
sleep 3
done
