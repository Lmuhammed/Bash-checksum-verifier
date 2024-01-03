#!/bin/bash
#Fonts colors
Reset='\e[0m' #Use after Colors To not colorise the after lines 
#Fonts :
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BWhite='\033[1;37m'       # White
BYellow='\033[1;33m'      # Yellow
BCyan='\033[1;36m'        # Cyan
#---End Fonts colors 
echo -e "${BGreen}Easy MD5 ${Reset}"
# Specify the program path
echo "Enter the Programme location (in/outside this directory) :"
echo -e "In :  => ./[NAME]            ${BYellow}Example : ./harmless.py${Reset}"
echo -e "Outside  => [FULL_PATH]/[NAME] ${BWhite}Example :  /bin/gcc${Reset}"
read program
# check if programme exist
if test -f "$program"; then
echo "Enter md5 provided by the program's OWNER (Official : website,github ...)"
# get  checksum from user
read program_checksum

# Calculate the actual checksum
actual_checksum=$(md5sum "$program" | awk '{print $1}')
#echo the checksum
echo "The Programme             : $program"
echo "The checksum given By you : $program_checksum"
echo "The actual checksum       : $actual_checksum"
# Compare the checksums
if [[ "$actual_checksum" == "$program_checksum" ]]; then
    echo -e "${BGreen}Checksum is valid. The program is not modified.${Reset}"
else
    echo -e "${BRed}Checksum is invalid. The program may be modified or corrupted.${Reset}"
fi
#if not exist
else 
    echo -e "${BRed}Are you playing with me sir ? ,${BCyan}The $program does not exist -______-${Reset}"
fi

