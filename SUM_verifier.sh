#!/bin/bash


#Fonts colors
Reset='\e[0m'             #Use after Colors To not colorise the next lines 

#Font colors :

BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BWhite='\033[1;37m'       # White
BYellow='\033[1;33m'      # Yellow
BCyan='\033[1;36m'        # Cyan

#---End Fonts colors 

#check if md5sum installed 
if ! command -v md5sum &> /dev/null
then
    echo -e "${BRed}md5sum required for this script .${Reset}"
    echo "install it and retry ."
    exit 22
fi
#end check 

#No arrguments :
if [ "$#" -lt 3 ]; then
echo "Sum veriefer"
echo "Usage: $0 [checksumAlgo] {program} [md5Hash]"
echo "checksumAlgo :"
echo "md5          :"
echo "s1           :    sha1"
echo "s2           :    sha256"
echo -e "${BGreen}Exemples : ${Reset}"
echo "$0 $HOME/Dowloads/app.sh      6d18504f70aa38ae1e6e17b2b791d874"
echo "$0 ./app.sh                   6d18504f70aa38be1e6e17b2b791d874"
exit 2
else
checksumAlgo=$1
program=$2
program_checksum=$3
fi

# *) check if programme exist
if ! test -f "$program"; then
    echo -e "${BRed}The $program does not exist ,Recheck the Path ...${Reset}"
    exit 2
fi
# Calculate the actual checksum
#actual_checksum=$(md5sum "$program" | awk '{print $1}')

# Case statement to check the checksumAlgo
case $checksumAlgo in
    "md5")
        actual_checksum=$(md5sum "$program" | awk '{print $1}')
        ;;
    "s1")
        actual_checksum=$(sha1sum "$program" | awk '{print $1}')
        ;;
    "s2")
        actual_checksum=$(sha256sum "$program" | awk '{print $1}')
        ;;
    *)
        echo -e "${BRed}Invalid Checksum ${Reset}"
        exit 2
        ;;
esac

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