#!/bin/bash
#####################
# BEGIN COLORS SECTION
#
# Set colors to use within script itself for printed output
##
RED='\033[1;31m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
NC='\033[0m'
#
# END COLORS SECTION
#####################
#
#####################
# BEGIN SECTION FOR LAB VARIABLES
#
# Set Lab number variable
#
# Change these variables to reflect the Lab Number and Lab Title
#
LABNUMBER=1
LABTITLE="Creating Security Rules"
#
#
# END SECTION FOR LAB VARIABLES
#####################
#
#####################
# BEGIN SECTION TO GET CONFIG FILE
#
# This section uses curl to pull configuration file from firewall using API
#
# Current version uses hard-coded IP address for firewall management IP
# and uses a predefined key.
#
# These need to be replaced with variables that are entered once per machine
#
# Remove configuration file from current directory
rm running-config.xml
FILENAME=LAB
# Pull configuration file from firewall
# 
#
clear
echo "Retrieving configuration file..."
echo ""
sleep 1
curl -kG "https://192.168.50.1/api/?type=export&category=configuration&key=LUFRPT1uak1lTVgzNVpvWHZGVTR6YUw0Sk85d3RQcWs9M0NCZkhWTFhSK3lmaTk4SEc3bXE0VXRzcHJSU3Y3QWdveEtFYm9IS0NBWT0=" > running-config.xml
# Copy running-config.xml to LabNumber_LabTitle_Config.xml format
cp running-config.xml Lab_"$LABNUMBER"_"$LABTITLE"_Config.xml
#
# Create myscores.txt file
# Use touch only in first lab grade script
# all others will append
# touch myscores.txt
#
# echo "" >> myscores.txt
# echo "Lab "$LABNUMBER >> myscores.txt
# echo $LABTITLE >> myscores.txt
# echo ------------------------ >> myscores.txt
# echo "" >> myscores.txt
#

echo ""
echo "Complete"
echo ""
# Pause for effect
sleep 1
clear
#
# END SECTION TO GET CONFIG FILE
#####################
#
#####################
# BEGIN SECTION TO READ CONFIGURATION FILE INTO VARIABLE
#
# Read in LabNumber_LabTitle_Config.xml file as ConfigFile variable
ConfigFile=`cat Lab_"$LABNUMBER"_"$LABTITLE"_Config.xml`
#
#END SECTION TO READ CONFIGURATION FILE INTO VARIABLE
#####################
#
#####################
#
# START RESULTS SECTION
#
# The script will look for these values within the ConfigFile
#
# Enter values to look for within ConfigFile
# Easiest way is to open running-config.xml in text editor
# and copying section to look for.
#
# Avoid using quoted values in variable for the time being
# such as a field with spaces.
#
# Result 1
# Description - Update this section to include what the variable actually is:
# Description -  Looks for a Security Rule from inside to outside zone
result1="<to><member>dmz</member></to><from><member>inside</member></from><source><member>any</member></source><destination><member>any</member></destination><source-user><member>any</member></source-user><category><member>any</member></category><application><member>any</member></application><service><member>application-default</member></service><hip-profiles><member>any</member></hip-profiles><action>allow</action>"
# Result 2
# Description - Update this section to include what the variable actually is:
# Description -
result2="this is a problem"
# Result 3
# Description - Update this section to include what the variable actually is:
# Description -
result3="poopo"
#result3="<ping>yes</ping><response-pages>yes</response-pages><snmp>yes</snmp></entry>"
# Result 4
# result4=""
# Description - Update this section to include what the variable actually is:
# Description -
#
# END RESULTS SECTION
#####################
#
#####################
# BEGIN SCRIPT
#
#####################
#
# Print Lab Number and Title
echo -e "Lab Number ${WHITE}$LABNUMBER${NC}"
echo -e "Lab Title  ${WHITE}$LABTITLE${NC}"
echo ""
# Print output
sleep 1
echo ""
echo "Comparing your file to expected results..."
sleep 2
echo ""
#
# Compare ConfigFile to result1
if [[ $ConfigFile == *"$result1"* ]]; then
# echo out PASS in green if config does contain result1
sleep 1
# Alignment guide
 	echo "-----------------------------------------------------"
	echo -e "Section 1 Rule Creation -----------------------> ${GREEN}PASS${NC}"
else
# echo out FAIL in red if config does not contain result1
sleep 1
	echo -e "Section 1 Rule Creation -----------------------> ${RED}FAIL${NC}"
fi
# Compare ConfigFile to result2
if [[ $ConfigFile == *"$result2"* ]]; then
sleep 1
	echo -e "Section 2 Correct Description -----------------> ${GREEN}PASS${NC}"
else
sleep 1
	echo -e "Section 2 Rule Destination Zone  --------------> ${RED}FAIL${NC}"
fi
# Compare ConfigFile to result3
if [[ $ConfigFile == *"$result3"* ]]; then
sleep 1
        echo -e "Section 3 Interface Management Profile --------> ${GREEN}PASS${NC}"
else
sleep 1
	echo -e "Section 3 Interface Management Profile --------> ${RED}FAIL${NC}"
fi
	echo "-----------------------------------------------------"
echo ""
####
####
# Use the following as a template to add more sections to the comparison
# Compare ConfigFile to resultX
#if [[ $ConfigFile == *"$resultX"* ]]; then
# sleep 1
#        echo -e "Section X Interface Management Profile --------> ${GREEN}PASS${NC}"
# sleep 1
#else
#        echo -e "Section X Interface Management Profile --------> ${RED}FAIL${NC}"
#fi
#        echo "-----------------------------------------------------"
#echo ""
sleep 1
echo "Complete"
###########
###########
# BEGIN CLEANUP SECTION
#
# Remove running-config.xml
rm running-config.xml
#
# Move LabConfiguration file to MyLabScores directory
mv *xml MyLabScores/
###########
# To Do
#
# Figure out case-insensitive searches
# Figure out how to output overall PASS or FAIL for entire lab
#	FAIL all if a single section is FAIL
# Hide script text to keep people from cheating - set execute permission but not read?
# Consider piping score text to grading file for all labs.
