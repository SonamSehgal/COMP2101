#!/bin/bash

##################################################################################################

#if the script we run has root privilage and if not, exit.
if  [ "$(id -u)" != 0 ] ; then 
	echo "You need to be root for this script.";
	exit 1
fi

source ./reportfunctions.sh

###################################################################################################

#Heading and command for system’s fully-qualified domain name
FQDN=$(hostname -f)

#Heading and command for the  IP addresses
IP_Address=$(hostname -I)

#Heading and command for amount of space available
Space_Available=$(df / -h | awk 'FNR == 2 {print $4}')

##############################  error message to the user on stderr #################################

log_errors() {
    somecommand 2> >(logger -t "$(basename "$0")" -i -p user.warning)
}

# usage
log_errors

############################# error message with a timestamp #######################################


verbose=false
systemReport=false
diskReport=false
networkReport=false
fullReport=false

function save_error_log() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    local error_message="$1"
    echo "[$timestamp] $error_message" >> /var/log/systeminfo.log
    if [["$verbose"=true]]; then 
    echo "Error has occured at [$timestamp] for invalid option: $error_message ; Refer to help section (sysinfo.sh -h)"
    fi
    
}

#This function displays help information if the user asks for it on the command line or gives us a bad command line
function displayhelp {
cat <<EOF 
  Usage: sysconfig [OPTION]...
  [OPTIONS]       [DESCRIPTION]
  --help:         Displays Help Information\n
  --disk:         Displays Disk Information\n
  --network:      Runs only the network report\n
  --system:       runs only the computerreport, osreport, cpureport, ramreport, and videoreport
  --verbose:      runs your script verbosely, showing any errors to the user instead of sending them to the logfile
EOF
}


cat <<EOF

----------------------------Report Content------------------------------

FQDN= $FQDN
Operating system name and version= $Host_Information
IP Address= $IP_Address
Root filesystem space line and Space Available= $Space_Available
EOF
cpuReport
networkReport
storageReport
ramReport
videoReport
cmpReport
osReport
