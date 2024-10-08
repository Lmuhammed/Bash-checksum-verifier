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

#check if hashing programmes installed 
 
help_menu() {
echo "Sum veriefer"
echo "Usage: $0 [checksumAlgo] {program} [md5Hash]"
echo "checksumAlgo :"
echo "md5          "
echo "s1           :    sha1"
echo "s2           :    sha256"
echo -e "${BGreen}Exemples : ${Reset}"
echo "______________________________________"

echo "$0 $HOME/app.sh     md5     6d18504f70aa38ae1e6e17b2b791d874"
echo "$0 ./app.sh               s2      3972dc9744f6499f0f9b2dbf76696f2ae7ad8af9b23dde66d6af86c9dfb36986"

echo "______________________________________"
}
 
#check if hashing programmes installed 
 
check_program_installed() {
    program_name=$1
    if ! command -v $program_name &> /dev/null
    then
        echo -e "${BRed}$program_name required for this script .${Reset}"
        echo "install it and retry ."
        exit 22
    fi
}

test_file_exist(){
    program=$1
    # *) check if programme exist
if ! test -f "$program"; then
    echo -e "${BRed}The $program does not exist ,Recheck the Path ...${Reset}"
    exit 2
fi

}
#check checksumAlgo

func_checksumAlgo() {
checksumAlgo=$1
 case $checksumAlgo in
    "md5")
        check_program_installed md5sum
        actual_checksum=$(md5sum "$program" | awk '{print $1}')
        ;;
    "s1")
        check_program_installed sha1sum
        actual_checksum=$(sha1sum "$program" | awk '{print $1}')
        ;;
    "s2")
        check_program_installed sha256sum
        actual_checksum=$(sha256sum "$program" | awk '{print $1}')
        ;;
    *)
        my_array=("md5" "sha1" "sha256")
        # Loop over the array elements and print them
        echo -e "${BRed}Invalid Checksum algorithms ${Reset},supported :"
        for AllowedAlgos in "${my_array[@]}"
        do
            echo -e "${BGreen}$AllowedAlgos${Reset}"
        done
        exit 2
        ;;
esac
}

result() {
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

}
#if no arrguments passed:
if [ "$#" -lt 3 ]; then
help_menu
exit 2
fi

#get vars
checksumAlgo=$1
program=$2
program_checksum=$3
#check if file exist
test_file_exist $program
# test checksum
func_checksumAlgo $checksumAlgo
#print result after calulate
result