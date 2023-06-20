#!/bin/bash

#####################################################

#if the script we run has root privilage and if not, exit.
if  [ "$(id -u)" != 0 ] ; then 
	echo "You need to be root for this script.";
	exit 1
fi

######################################################

#Heading and command for system’s fully-qualified domain name
FQDN=$(hostname -f)

#Heading and command for The operating system name and version
Host_Information=$(hostnamectl | awk 'FNR == 7 {print $3, $4, $5}')

#Heading and command for the  IP addresses
IP_Address=$(hostname -I)

#Heading and command for amount of space available
Space_Available=$(df / -h | awk 'FNR == 2 {print $4}')

##############################################################################################

#Cmd to get the computer manufacturer.
cmpmanuftr=$(lshw -class system | grep 'vendor:' | head -1 | awk '{$1=""; print $0}') 
if [ -z "$cmpmanuftr" ]; then
	cmpmanuftr='Error! Data is unavailable.'
else
	cmpmanuftr=$(lshw -class system | grep 'vendor:' | head -1 | awk '{$1=""; print $0}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the Computer description or model.
cmpdescription=$(lshw -class system | grep 'description:' | awk '{print $2}')
if [ -z "$cmpdescription" ]; then 
	cmpdescription='Error! Data is unavailable.'
else
	cmpdescription=$(lshw -class system | grep 'description:' | awk '{print $2}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the Computer serial number.
cmpserial=$(lshw -class system | grep 'serial: ' | awk '{$1=""; print $0}')
if [ -z "$cmpdescription" ]; then 
	cmpserial='Error! Data is unavailable.'
else
	cmpserial=$(lshw -class system | grep 'serial: ' | awk '{$1=""; print $0}')
fi

###############################################################################################

#Cmd to get the cpu manufacturer.
cpumanufac=$(lscpu | grep 'Model name:' | sed 's/,"Model name: *//') 
if [ -z "$cmpdescription" ]; then 
	cpumanufac='Error! Data is unavailable.'
else
	cpumanufac=$(lscpu | grep 'Model name:' | sed 's/,"Model name: *//')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the Cpu architecture.
cpuarchi=$(lscpu | grep 'Architecture: ' | awk '{print$2}')
if [ -z "$cmpdescription" ]; then 
	cpuarchi='Error! Data is unavailable.'
else
	cpuarchi=$(lscpu | grep 'Architecture: ' | awk '{print$2}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the Cpu core count.
cpucore=$(lscpu | grep 'CPU(s): ' | head -1 | awk '{print$2}')
if [ -z "$cmpdescription" ]; then 
	cpucore='Error! Data is unavailable.'
else
	cpucore=$(lscpu | grep 'CPU(s): ' | head -1 | awk '{print$2}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the Cpu maximum speed.
cpuspeed=$(lshw -class cpu | grep 'capacity: ' | head -1 | awk '{print$2}')
if [ -z "$cmpdescription" ]; then 
	cpuspeed='Error! Data is unavailable.'
else
	cpuspeed=$(lshw -class cpu | grep 'capacity: ' | head -1 | awk '{print$2}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the size of L1d.
sizeL1d=$(lscpu | grep 'L1d ' | awk '{print $3}')
if [ -z "$cmpdescription" ]; then 
	sizeL1d='Error! Data is unavailable.'
else
	sizeL1d=$(lscpu | grep 'L1d ' | awk '{print $3}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the size of L1i.
sizeL1i=$(lscpu | grep 'L1i ' | awk '{print $3}')
if [ -z "$cmpdescription" ]; then 
	sizeL1i='Error! Data is unavailable.'
else
	sizeL1i=$(lscpu | grep 'L1i ' | awk '{print $3}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the size of L2.
sizeL2=$(lscpu | grep 'L2' | awk '{print $3}')
if [ -z "$cmpdescription" ]; then 
	sizeL2='Error! Data is unavailable.'
else
	sizeL2=$(lscpu | grep 'L2 ' | awk '{print $3}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the size of L3.
sizeL3=$(lscpu | grep 'L3' | awk '{print $3}')
if [ -z "$cmpdescription" ]; then 
	sizeL3='Error! Data is unavailable.'
else
	sizeL3=$(lscpu | grep 'L3 ' | awk '{print $3}')
fi
#####################################################

#Cmd to get Os distro version.
distroversion=$(hostnamectl | grep 'Kernel: ' | awk '{$1=""; print $0}')
if [ -z "$cmpdescription" ]; then 
	distroversion='Error! Data is unavailable.'
else
	distroversion=$(hostnamectl | grep 'Kernel: ' | awk '{$1=""; print $0}')
fi

#####################################################

cat <<EOF

----------------------------Report Content------------------------------

=======================================================================
-SYSTEM DESCRIPTION-

Computer manufacturer=         $cmpmanuftr
Computer description or model=  $cmpdescription
Computer serial number=        $cmpserial

========================================================================
-CPU INFORMATION-

CPU manufacturer and model=$cpumanufac
CPU architecture=              $cpuarchi
CPU core count=                $cpucore
CPU maximum speed=             $cpuspeed
Size of caches (L1d)=          $sizeL1d
Size of caches (L1i)=          $sizeL1i
Size of caches (L2)=           $sizeL2
Size of caches (L3)=           $sizeL3

========================================================================
-OS INFOPRMATION-

Linux distro=                  $Host_Information
Distro version=               $distroversion

========================================================================

FQDN= $FQDN
Operating system name and version= $Host_Information
IP Address= $IP_Address
Root filesystem space line and Space Available= $Space_Available

========================================================================

EOF




