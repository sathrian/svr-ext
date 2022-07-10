#!/bin/bash
#
# Bill Claunch
# Palo Alto Networks EDU
# May 20, 2021
#
# This script runs every 2 minutes through a CRON job.
#
# The script adds a random string of characters to the wildfire-test-pe-file.exe file
# to alter the file's hash value.
#
# This process means that each the wildfire-test-pe-file.exe is downloaded as part of
# the wildfire lab, the file should have a unique hash value - as long as the downloads
# occur at least 2 minutes apart.
#
# Previous versions of the Wildfire lab in the 210 class used a public URL to obtain a
# unique test file for WF uploads. The link http://wildfire.paloaltonetworks.com/publicapi/test/pe
# is no longer available.
#
#
sudo
clear
# Change to html directory
#
cd /var/www/html/
#
# Delete current exe file
sudo rm wildfire-test-pe-file.exe
#
# Copy original file wildfire-test-pe-file.orig as wildfire-test-pe-file.exe
# This will keep the file from growing larger with each script run
sudo cp wildfire-test-pe-file.orig wildfire-test-pe-file.exe
#
# Generate hash of current exe file for comparison
echo "Starting Hash Value:"
sha256sum wildfire-test-pe-file.exe
#
# Create random value to add to file and assign this as RAND variable
RAND=$(date | sha256sum)
#
# Echo RAND variable for comparison
echo $RAND
#
# Change permissions of new exe file
sudo chmod 777 wildfire-test-pe-file.exe
#
# Copy value of RAND variable to the end of the wildfire-test-pe-file.exe file
sudo echo $RAND >> wildfire-test-pe-file.exe
#
# Generate hash of updated file to verify new value.
echo "New Hash Value:"
sha256sum wildfire-test-pe-file.exe
#
