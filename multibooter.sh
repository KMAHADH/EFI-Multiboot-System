#!/bin/bash
default="/home/`whoami`/Downloads"
location=""
Supported="AcademiX 
Android-x86 
Arch 
BunsenLabs 
CentOS 
Disk 
Fedora 
LibreELEC 
OpenSuse 
Porteus 
Raspbian 
TAILS 
TinyCore 
TinyCore+
Ubuntu 
Windows-10"

function Spinner {

i=1
sps=" "
sp="/-\|"
while [ -d /proc/$PID ]
do
sleep 0.2
echo ""
echo ""
liner=`tput lines`
tput il $liner 
echo -ne "Extracting the ISO...    "
printf "\b${sp:i++%${#sp}:1}"
tput cuu1
tput cuu1
done


}

function Extraction {
echo ""
echo "Installing $single to the USB Device..."
echo ""
echo "Note: during install it is normal for the system to look like it's stalled, particularly for the large files, But please please allow it time to copy all the files to the drive"
echo ""
sleep 5
hellocol="`tput cols`"
helllin="`tput lines`"
bsdtar xfpv "$location/$single" --directory "$path1" &
tput cup $hellocol $hellin
PID=$!
Spinner
}

function NewInst {
echo ""
echo "This follwoing series of processes a new Linux Installation"
echo ""
echo "You need an available Ubuntu iso for it to work..."
echo ""
echo "This ISO will act as your primary Linux distro,"
echo ""
echo "You can then add other suported distro's including a secondary Ubuntu installation, If you wish..."
echo ""
while true; do
    read -p "Do you want to continue? (Yy/Nn)" yn
    case $yn in
        [Yy]* ) echo ""; break;;
        [Nn]* ) echo "You choose No, Exiting..."; echo ""; echo "Goodbye!"; exit;;
        * ) echo "Please answer Yes or No.";;
    esac
done

    read -p "Is the Ubuntu ISO located in $default? (Yy/Nn)" yn
    case $yn in
        [Yy]* ) echo ""; 
	location=`echo $default`
	avail=`ls $default | grep '.iso' | grep -i ubuntu | awk '{print $1}'`;
        enum=`ls $default | grep '.iso' | grep -i ubuntu | wc -l`;
	if [ -z "$avail" ]
then
     echo ""
      echo -e "\e[91mNo Ubuntu Distro ISO images, that exist in the USB device...\e[39m"
      echo ""
NewInst
      break
else
      echo ""
      echo "There are $enum Ubuntu Distro ISO image(s) that exist in the USB device..."
      echo ""
fi
	select single in "${avail[@]}"
do
 [[ -n $single ]] || { echo "Invalid choice. Please try again." >&2; continue; }
  break # valid choice was made; exit prompt.
done
Extraction
;;
        [Nn]* ) proceeds;;
        * ) echo "Please answer Yes or No.";;
    esac
}


function proceeds {

while true; do
    echo "Enter the path for the location of the ISO:"
    echo ""
    read location
    echo ""
    read -p "Is this location correct?  (Yy/Nn)" yn
    case $yn in
        [Yy]* ) echo ""; break;;
        [Nn]* ) echo "";;
    esac
done

	avail=`ls $location | grep '.iso' | grep -i ubuntu | awk '{print $1}'`
        enum=`ls $location | grep '.iso' | grep -i ubuntu | wc -l`

	if [ -z "$avail" ]
then
      echo ""
      echo -e "\e[91mNo Ubuntu Distro ISO images, that exist in the directory...\e[39m"
      echo ""
NewInst
else
      echo ""
      echo "There are $enum Ubuntu Distro ISO image(s) that exist in the directory..."
      echo ""
fi

while true; do
	select single in "${avail[@]}"
do
 [[ -n $single ]] || { echo "Invalid choice. Please try again." >&2; continue; }
done 
  Extraction
  break
done
}

function Install {
readarray -t lines < <(echo "$Supported")
 echo 'Please enter your choice: '
echo ""
COLUMNS=12
select choice in "${lines[@]}"
do
 [[ -n $choice ]] || { echo "Invalid choice. Please try again." >&2; continue; }
  break # valid choice was made; exit prompt.
done
echo ""
echo "You chose to Install: $choice"
echo ""

while true; do
    read -p "Is the ISO located in $default? (Yy/Nn)" yn
    case $yn in
        [Yy]* ) echo ""; 
	location=`echo $default`
	choice=`echo $choice | rev | cut -c 1- | rev`
	avail=`ls $default | grep '.iso' | grep -i $choice | awk '{print $1}'`;
        enum=`ls $default | grep '.iso' | grep -i $choice | wc -l`;
	if [ -z "$avail" ]
then
      echo ""
      echo -e "\e[91mNo $choice Distro ISO images, that exist in the USB device...\e[39m"
      echo ""
      break
else
      echo ""
      echo "There are $enum $choice Distro ISO image(s) exist in the USB device..."
      echo ""
fi
	select single in "${avail[@]}"
do
 [[ -n $single ]] || { echo "Invalid choice. Please try again." >&2; continue; }
  break # valid choice was made; exit prompt.
done
$choice
break;;
        [Nn]* ) while true; do
    echo "Enter the path for the location of the ISO:"
    echo ""
    read $location
    echo ""
    read -p "Is this location correct?  (Yy/Nn)" yn
    case $yn in
        [Yy]* ) echo ""; break;;
        [Nn]* ) echo "";;
    esac
done
;;
        * ) echo "Please answer Yes or No.";;
    esac
done
}

function Android-x86 {
echo ""
instdir="/filesystems/"
DIREC="$path1$instdir$choice"
if [ -d "$DIREC" ]; then
    echo -e "\e[91m $choice already exists! \e[39m"
    echo ""
    echo "Note:"
    echo ""
    echo "1) This script (as of now) supports only one instance of a Distro..."
    echo ""
    echo "2) If you're having trouble with a Distro, Try removing and readding it..."
    echo ""
    read -n 1 -s -r -p "Press any key to continue..."
    echo ""
else
 echo "$choice Doesnot exist..."
 existing="0"
 echo ""
 echo $DIREC
fi
echo  "extrating current ISO to $path1/filesystems..."
echo ""
##7z -x "$location/$single"
echo ""
}

function BunsenLabs {
echo ""
instdir="/filesystems/"
DIREC="$path1$instdir$choice"
if [ -d "$DIREC" ]; then
    echo -e "\e[91m $choice already exists! \e[39m"
    echo ""
    echo "Note:"
    echo ""
    echo "1) This script (as of now) supports only one instance of a Distro..."
    echo ""
    echo "2) If you're having trouble with a Distro, Try removing and readding it..."
    echo ""
    read -n 1 -s -r -p "Press any key to continue..."
    echo ""
else
 echo "$choice Doesnot exist..."
 existing="0"
 echo ""
 echo $DIREC
fi
echo  "extrating current ISO to $path1/filesystems..."
echo ""
##7z -x "$location/$single"
echo ""
} 

function CentOS {
echo ""
instdir="/filesystems/"
DIREC="$path1$instdir$choice"
if [ -d "$DIREC" ]; then
    echo -e "\e[91m $choice already exists! \e[39m"
    echo ""
    echo "Note:"
    echo ""
    echo "1) This script (as of now) supports only one instance of a Distro..."
    echo ""
    echo "2) If you're having trouble with a Distro, Try removing and readding it..."
    echo ""
    read -n 1 -s -r -p "Press any key to continue..."
    echo ""
else
 echo "$choice Doesnot exist..."
 existing="0"
 echo ""
 echo $DIREC
fi
echo  "extrating current ISO to $path1/filesystems..."
echo ""
##7z -x "$location/$single"
echo ""
} 

function Fedora {
echo ""
instdir="/filesystems/"
DIREC="$path1$instdir$choice"
if [ -d "$DIREC" ]; then
    echo -e "\e[91m $choice already exists! \e[39m"
    echo ""
    echo "Note:"
    echo ""
    echo "1) This script (as of now) supports only one instance of a Distro..."
    echo ""
    echo "2) If you're having trouble with a Distro, Try removing and readding it..."
    echo ""
    read -n 1 -s -r -p "Press any key to continue..."
    echo ""
else
 echo "$choice Doesnot exist..."
 existing="0"
 echo ""
 echo $DIREC
fi
echo  "extrating current ISO to $path1/filesystems..."
echo ""
##7z -x "$location/$single"
echo ""
} 

function LibreELEC {
echo ""
instdir="/filesystems/"
DIREC="$path1$instdir$choice"
if [ -d "$DIREC" ]; then
    echo -e "\e[91m $choice already exists! \e[39m"
    echo ""
    echo "Note:"
    echo ""
    echo "1) This script (as of now) supports only one instance of a Distro..."
    echo ""
    echo "2) If you're having trouble with a Distro, Try removing and readding it..."
    echo ""
    read -n 1 -s -r -p "Press any key to continue..."
    echo ""
else
 echo "$choice Doesnot exist..."
 existing="0"
 echo ""
 echo $DIREC
fi
echo  "extrating current ISO to $path1/filesystems..."
echo ""
##7z -x "$location/$single"
echo ""
} 

function OpenSuse {
echo ""
instdir="/filesystems/"
DIREC="$path1$instdir$choice"
if [ -d "$DIREC" ]; then
    echo -e "\e[91m $choice already exists! \e[39m"
    echo ""
    echo "Note:"
    echo ""
    echo "1) This script (as of now) supports only one instance of a Distro..."
    echo ""
    echo "2) If you're having trouble with a Distro, Try removing and readding it..."
    echo ""
    read -n 1 -s -r -p "Press any key to continue..."
    echo ""
else
 echo "$choice Doesnot exist..."
 existing="0"
 echo ""
 echo $DIREC
fi
echo  "extrating current ISO to $path1/filesystems..."
echo ""
##7z -x "$location/$single"
echo ""
} 

function Porteus {
echo ""
instdir="/filesystems/"
DIREC="$path1$instdir$choice"
if [ -d "$DIREC" ]; then
    echo -e "\e[91m $choice already exists! \e[39m"
    echo ""
    echo "Note:"
    echo ""
    echo "1) This script (as of now) supports only one instance of a Distro..."
    echo ""
    echo "2) If you're having trouble with a Distro, Try removing and readding it..."
    echo ""
    read -n 1 -s -r -p "Press any key to continue..."
    echo ""
else
 echo "$choice Doesnot exist..."
 existing="0"
 echo ""
 echo $DIREC
fi
echo  "extrating current ISO to $path1/filesystems..."
echo ""
##7z -x "$location/$single"
echo ""
} 

function Raspbian {
echo ""
instdir="/filesystems/"
DIREC="$path1$instdir$choice"
if [ -d "$DIREC" ]; then
    echo -e "\e[91m $choice already exists! \e[39m"
    echo ""
    echo "Note:"
    echo ""
    echo "1) This script (as of now) supports only one instance of a Distro..."
    echo ""
    echo "2) If you're having trouble with a Distro, Try removing and readding it..."
    echo ""
    read -n 1 -s -r -p "Press any key to continue..."
    echo ""
else
 echo "$choice Doesnot exist..."
 existing="0"
 echo ""
 echo $DIREC
fi
echo  "extrating current ISO to $path1/filesystems..."
echo ""
##7z -x "$location/$single"
echo ""
} 

function TAILS {
echo ""
instdir="/filesystems/"
DIREC="$path1$instdir$choice"
if [ -d "$DIREC" ]; then
    echo -e "\e[91m $choice already exists! \e[39m"
    echo ""
    echo "Note:"
    echo ""
    echo "1) This script (as of now) supports only one instance of a Distro..."
    echo ""
    echo "2) If you're having trouble with a Distro, Try removing and readding it..."
    echo ""
    read -n 1 -s -r -p "Press any key to continue..."
    echo ""
else
 echo "$choice Doesnot exist..."
 existing="0"
 echo ""
 echo $DIREC
fi
echo  "extrating current ISO to $path1/filesystems..."
echo ""
##7z -x "$location/$single"
echo ""
} 

function TinyCore {
echo ""
instdir="/filesystems/"
DIREC="$path1$instdir$choice"
if [ -d "$DIREC" ]; then
    echo -e "\e[91m $choice already exists! \e[39m"
    echo ""
    echo "Note:"
    echo ""
    echo "1) This script (as of now) supports only one instance of a Distro..."
    echo ""
    echo "2) If you're having trouble with a Distro, Try removing and readding it..."
    echo ""
    read -n 1 -s -r -p "Press any key to continue..."
    echo ""
else
 echo "$choice Doesnot exist..."
 existing="0"
 echo ""
 echo $DIREC
fi
echo  "extrating current ISO to $path1/filesystems..."
echo ""
##7z -x "$location/$single"
echo ""
} 

function TinyCore+ {
echo ""
instdir="/filesystems/"
DIREC="$path1$instdir$choice"
if [ -d "$DIREC" ]; then
    echo -e "\e[91m $choice already exists! \e[39m"
    echo ""
    echo "Note:"
    echo ""
    echo "1) This script (as of now) supports only one instance of a Distro..."
    echo ""
    echo "2) If you're having trouble with a Distro, Try removing and readding it..."
    echo ""
    read -n 1 -s -r -p "Press any key to continue..."
    echo ""
else
 echo "$choice Doesnot exist..."
 existing="0"
 echo ""
 echo $DIREC
fi
echo  "extrating current ISO to $path1/filesystems..."
echo ""
##7z -x "$location/$single"
echo ""
} 

function Ubuntu {
echo ""
instdir="/filesystems/"
DIREC="$path1$instdir$choice"
if [ -d "$DIREC" ]; then
    echo -e "\e[91m $choice already exists! \e[39m"
    echo ""
    echo "Note:"
    echo ""
    echo "1) This script (as of now) supports only one instance of a Distro..."
    echo ""
    echo "2) If you're having trouble with a Distro, Try removing and readding it..."
    echo ""
    read -n 1 -s -r -p "Press any key to continue..."
    echo ""
else
 echo "$choice Doesnot exist..."
 existing="0"
 echo ""
 echo $DIREC
fi
echo  "extrating current ISO to $path1/filesystems..."
echo ""
##7z -x "$location/$single"
echo ""
} 

##
###
##Start of the script!
###
##

echo ""
echo "Welcome to Linux Live MultiBooter!"
echo ""
echo -e "A Bash scripting system designed by  \e[1m\e[5m\e[7mKMAHADH\e[0m"
echo ""
echo "To allow you to easily install multiple Live Linux Distributions on a single USB!"
echo ""
echo ""
read -n 1 -s -r -p "Press any key to continue..."
echo ""
echo ""
echo "Checking prerequisites for the script..."
echo ""
echo ""
checkall=""
tarcheck=`command -v bsdtar`
tarexist=""
boolall=""
echo "+-----------------------------------------------+"
if [ -z "$tarcheck" ]
then
      tarexist="\e[91mFail\e[39m"
      det1="\e[91mbsdtar doesnot exist on the system!\e[39m"
      detall1="Please install bsdtar on the system.     |"
      boolall="fail"
else
      tarexist="\e[92mPass\e[39m"
      det1="| \e[92mbsdtar is installed on the system! \e[0m    |      |"
      boolall="pass"
      detall1="\e[39m                                               |"
fi

echo -e "| Checking for bsdtar...                 | $tarexist |"
echo "|                                        |      |"
echo -e "$det1"
echo "|                                        |      |"

USBcheck=`readlink -f /dev/disk/by-id/usb* | grep 1`


if [ -z "$USBcheck" ]
then
      USBexist="\e[91mFail\e[39m"
      det2="| \e[91mNo USB device detected on the system!\e[39m  |      |"
      detall2="Please connect a USB device.\033[19C\e[0m|"
      boolall="fail"
else
      USBexist="\e[92mPass\e[39m"
      det2="| \e[92mUSB device detected on the system!  \e[0m   |      |"
      boolall="pass"
fi
echo -e "| Checking for USB device...             | $USBexist |"
echo "|                                        |      |"
echo -e "$det2"
echo "|                                        |      |"

device1=`readlink -f /dev/disk/by-id/usb* | grep 1`

FSTcheck=`df -Th | grep "$device1" | awk '{print $2}'`


if [ "$FSTcheck" != "vfat" ]  
then
      FSTexist="\e[91mFail\e[39m"
      if [ -z "$USBcheck" ]  
      then    
       det3="| \e[91mNo USB device detected on the system!\e[39m  |      |"  
      else 
       det3="| \e[91mThe USB device is not FAT32 formatted!\e[39m |      |"
      fi
      detall3='Please connect a "FAT32" formatted USB device.\033[1C\e[0m|'
      boolall="fail"
else
      FSTexist="\e[92mPass\e[39m"
      det3="| \e[92mThe USB device is FAT32 formatted!\e[39m     |      |"
      boolall="pass"
      
fi

echo -e "| Checking for USB filesystem type...    | $FSTexist |"
echo "|                                        |      |"
echo -e "$det3"
echo "|                                        |      |"
echo "+-----------------------------------------------+"
echo ""

if [ $boolall == "fail" ]
then
echo -e "+----------+                          +----------+"
echo -e "| \e[5m\e[91mERROR !!\e[0m |                          | \e[5m\e[91mERROR !!\e[0m |"
echo "+------------------------------------------------+"
echo "|				                 |"
echo -e "| \e[91m$detall1\e[0m"
echo "|				                 |"
echo -e "| \e[91m$detall2\e[0m"
echo "|				                 |"
echo -e "| \e[91m$detall3\e[0m"
echo "|				                 |"
echo "|				                 |"
echo "+------------------------------------------------+"
echo -e "| \e[5m\e[91mERROR !!\e[0m |                          | \e[5m\e[91mERROR !!\e[0m |"
echo -e "+----------+                          +----------+"

echo ""
read -n 1 -s -r -p "Press any key to exit..."
exit
else
echo "All required prerequisite checks passed!"
fi
echo ""
echo "Please answer the following set of Yes/No to allow the system to progress further... "
echo ""
read -n 1 -s -r -p "Press any key to continue..."
echo ""

##Start of the actual process

device1=`readlink -f /dev/disk/by-id/usb* | grep 1`
path1=`mount | grep $device1 | awk '{print $3}'`
existing="2"

echo ""
echo "Your device is:" 
echo ""
echo "$device1"
echo "" 
echo "And, it is mounted at:"
echo ""
echo "$path1"
echo ""
while true; do
    read -p "Is this information correct? (Yy/Nn)" yn
    case $yn in
        [Yy]* ) echo ""; break;;
        [Nn]* ) echo "Please only plug in one, single USB Drive to avoid conflicts!, and try again..."; exit;;
        * ) echo "Please answer Yes or No.";;
    esac
done

echo "Okay, continuing..." 
echo ""
echo "Checking for GRUB installation..."
echo ""
FILE="$path1/boot/grub/grub.cfg"
if test -f "$FILE"; then
    echo "$FILE Exists..."
    existing="1"
    echo ""
else
 echo "$FILE Doesnot exist..."
 existing="0"
 echo ""
fi

if [[ "$existing" == 1 ]]; then
echo "It seems a previous Installation exists..."
echo ""
else
echo "No previous installation detected!"
echo ""
echo "If you have a previous Linux installation in the USB Drive, You might have plugged in the worng USB drive..."
echo ""
fi

while true; do
    read -p "Do you want to continue? (Yy/Nn)" yn
    case $yn in
        [Yy]* ) echo ""; break;;
        [Nn]* ) echo "Please recheck and insert the correct USB drive, and try again..."; exit;;
        * ) echo "Please answer Yes or No.";;
    esac
done

if [[ "$existing" == 1 ]]; then
echo "Continuing with update of the existing  installation..."
else
echo "Creating a new installation..."
NewInst
fi
current1=`cat $path1/boot/grub/grub.cfg | grep -n "EFI System Shell" | awk '{print $1}' | cut -f1 -d":"`

echo ""
echo "EFI System Shell config at line number: $current1"
echo ""
echo ""
echo ""
listup=`ls -l $path1/filesystems/ | awk '{print $9}' | sed 1d`
COLUMNS=12

while true
 do
echo 'Please enter your choice as a number: '
echo ""
COLUMNS=12
options=("List all Installed Distro's..." "Install a Distro..." "Remove a Distro..." "Remove the Linux system altogether!" "Device storage..." "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "List all Installed Distro's...")
	echo ""
	echo "Checking the list  of all Installed Distro's..."
	echo ""
	echo "List of existing Distro's on USB is:"
	echo "$listup" | awk '{printf("%1d) %s\n", NR, $0)}'
	echo ""    
        read -n 1 -s -r -p "Press any key to continue"
       echo ""
       echo ""
	    break 
            ;;
        "Install a Distro...")
	    echo ""
            echo 'You chose to "Install a Distro..."'
            echo ""
	    echo "Which distro would you like to Install?"
	    echo ""
            Install
	    break 
            ;;
        "Remove a Distro...")
	    echo ""
            echo 'You chose to "Remove a Distro..."'
            echo ""
	    break
	    ;;
        "Device storage...")
	    device1=`readlink -f /dev/disk/by-id/usb* | grep 1`
	    echo ""
            echo 'You chose "Device storage..."'
            echo ""
	    Totaal=`df -h $device1 | tail -n 1 |awk '{print $2}'`
	    Usaage=`df -h $device1 | tail -n 1 |awk '{print $3}'`	
	    Awhale=`df -h $device1 | tail -n 1 |awk '{print $4}'`
	    MultiUsage=`du -h $path1/filesystems | tail -n 1 | awk '{print $1}'`
echo ""
echo "USB device storage usage..."
echo ""
echo " Total     Used     Available     Multiboot Usage"
echo   " $Totaal""B     "$Usaage"B    "      $Awhale"B         "             $MultiUsage"B     "
echo ""
	    break
	    ;;
        "Remove the Linux system altogether!")
            echo ""
	    echo 'you chose choice "Remove the Linux System altogether!"'
            echo ""
	    break
            ;;
        "Quit")
	    echo ""
	    echo "You chose to exit the system..."
	    echo ""
	    echo "Exiting...Goodbye!"
	    echo ""
            exit
            ;;
        *) 
	    echo ""
	    echo -e "\e[91mInavlid selection, $REPLY is not an option here!\e[39m"
	    echo ""
	    echo "Please try again..."
	    echo ""
	    ;;
    esac
done
done
