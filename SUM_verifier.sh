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
#No arrguments :
if [ "$#" -lt 1 ]; then
echo -e "${BGreen}Easy MD5 ${Reset}"
# get the program path
echo "Enter the Programme location (in/outside this directory) :"
echo -e "In :  => ./[NAME]            ${BYellow}Example : ./harmless.py${Reset}"
echo -e "Outside  => [FULL_PATH]/[NAME] ${BWhite}Example :  /bin/gcc${Reset}"
read program
# get  checksum from user
echo "Enter md5 provided by the program's OWNER (Official : website,github ...)"
read program_checksum
else
program=$1
program_checksum=$2
fi

# *) check if programme exist
if ! test -f "$program"; then
    echo -e "${BRed}The $program does not exist ,Retry again ...${Reset}"
    exit 1
fi
# Calculate the actual checksum
actual_checksum=$(md5sum "$program" | awk '{print $1}')
#clear the screen for better focus & print result
clear
echo "The Programme             : $program"
echo "The checksum given By you : $program_checksum"
echo "The actual checksum       : $actual_checksum"
# Compare the checksums
if [[ "$actual_checksum" == "$program_checksum" ]]; then
    echo -e "${BGreen}Checksum is valid. The program is not modified.${Reset}"
else
    echo -e "${BRed}Checksum is invalid. The program may be modified or corrupted.${Reset}"
fi