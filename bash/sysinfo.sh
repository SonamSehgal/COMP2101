#!/bin/bash

#####################################################

#if the script we run has root privilage and if not, exit.
if  [ "$(id -u)" != 0 ] ; then 
	echo "You need to be root for this script.";
	exit 1
fi

lshwOutput=$(lshw)
lscpuOutput=$(lscpu)
lsblkOutput=$(lsblk)
dmidecodeOutput=$(dmidecode)
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
cmpmanuftr=$(echo "$lshwOutput" -class system | grep 'vendor:' | head -1 | awk '{$1=""; print $0}') 
if [ -z "$cmpmanuftr" ]; then
	cmpmanuftr='Error! Data is unavailable.'
else
	cmpmanuftr=$(echo "$lshwOutput" -class system | grep 'vendor:' | head -1 | awk '{$1=""; print $0}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the Computer description or model.
cmpdescription=$(echo "$lshwOutput" -class system | grep -m1 -i 'description:' | awk '{print $2}')
if [ -z "$cmpdescription" ]; then 
	cmpdescription='Error! Data is unavailable.'
else
	cmpdescription=$(echo "$lshwOutput" -class system | grep -m1 -i 'description:' | awk '{print $2}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the Computer serial number.
cmpserial=$(echo "$lshwOutput" -class system | grep -m1 -i 'serial: ' | awk '{$1=""; print $0}')
if [ -z "$cmpdescription" ]; then 
	cmpserial='Error! Data is unavailable.'
else
	cmpserial=$(echo "$lshwOutput" -class system | grep -m1 -i 'serial: ' | awk '{$1=""; print $0}')
fi

###############################################################################################

#Cmd to get the cpu manufacturer.
cpumanufac=$(echo "$lshwOutput" | grep 'Model name:' | sed 's/,"Model name: *//') 
if [ -z "$cmpdescription" ]; then 
	cpumanufac='Error! Data is unavailable.'
else
	cpumanufac=$(echo "$lscpuOutput" | grep 'Model name:' | sed 's/,"Model name: *//')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the Cpu architecture.
cpuarchi=$(echo "$lscpuOutput" | grep 'Architecture: ' | awk '{print$2}')
if [ -z "$cmpdescription" ]; then 
	cpuarchi='Error! Data is unavailable.'
else
	cpuarchi=$(echo "$lscpuOutput" | grep 'Architecture: ' | awk '{print$2}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the Cpu core count.
cpucore=$(echo "$lscpuOutput" | grep 'CPU(s): ' | head -1 | awk '{print$2}')
if [ -z "$cmpdescription" ]; then 
	cpucore='Error! Data is unavailable.'
else
	cpucore=$(echo "$lscpuOutput" | grep 'CPU(s): ' | head -1 | awk '{print$2}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the Cpu maximum speed.
cpuspeed=$(echo "$lshwOutput" -class cpu | grep 'capacity: ' | head -1 | awk '{print$2}')
if [ -z "$cmpdescription" ]; then 
	cpuspeed='Error! Data is unavailable.'
else
	cpuspeed=$(echo "$lshwOutput" -class cpu | grep 'capacity: ' | head -1 | awk '{print$2}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the size of L1d.
sizeL1d=$(echo "$lscpuOutput" | grep 'L1d ' | awk '{print $3}')
if [ -z "$cmpdescription" ]; then 
	sizeL1d='Error! Data is unavailable.'
else
	sizeL1d=$(echo "$lscpuOutput" | grep 'L1d ' | awk '{print $3}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the size of L1i.
sizeL1i=$(echo "$lscpuOutput" | grep 'L1i ' | awk '{print $3}')
if [ -z "$cmpdescription" ]; then 
	sizeL1i='Error! Data is unavailable.'
else
	sizeL1i=$(echo "$lscpuOutput" | grep 'L1i ' | awk '{print $3}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the size of L2.
sizeL2=$(echo "$lscpuOutput" | grep 'L2' | awk '{print $3}')
if [ -z "$cmpdescription" ]; then 
	sizeL2='Error! Data is unavailable.'
else
	sizeL2=$(echo "$lscpuOutput" | grep 'L2 ' | awk '{print $3}')
fi
#-----------------------------------------------------------------------------------------------
#Cmd to get the size of L3.
sizeL3=$(echo "$lscpuOutput" | grep 'L3' | awk '{print $3}')
if [ -z "$cmpdescription" ]; then 
	sizeL3='Error! Data is unavailable.'
else
	sizeL3=$(echo "$lscpuOutput" | grep 'L3 ' | awk '{print $3}')
fi
#####################################################

#Cmd to get Os distro version.
distroversion=$(hostnamectl | grep 'Kernel: ' | awk '{$1=""; print $0}')
if [ -z "$cmpdescription" ]; then 
	distroversion='Error! Data is unavailable.'
else
	distroversion=$(hostnamectl | grep 'Kernel: ' | awk '{$1=""; print $0}')
fi

####################### RAM INFORMATION ##############################

ramManufacturer=$(echo "$dmidecodeOutput" | grep -m1 -i "manufacturer" | awk '{$1=""; print $0}')
ramProductName=$(echo "$dmidecodeOutput" | grep -m1 -i "Product name" | awk '{$1=""; $2=""; print $0}')
ramSerialNum=$(echo "$dmidecodeOutput" | grep -m1 -i "serial number" | awk '{$1=""; print $0}')
ramSize=$(echo "$lshwOutput" | grep -A10 "\-memory" | grep 'size:' | awk 'FNR == 2 {$1=""; print $0}')
ramSpeed=$(echo "$dmidecodeOutput" --type 17 | grep -m1 Speed | awk '{$1=""; print $0}')
ramLocation=$(echo "$lshwOutput" | grep -m1 'slot: RAM' |awk '{$1=""; $2=""; print $0}')
totalSize=$(echo "$lshwOutput" | grep -A5 "\-memory" | grep -m1 'size:' | awk '{$1=""; print $0}')
ramTable=$(paste -d ';' <(echo "$ramManufacturer") <(echo "$ramProductName") <(echo "$ramSerialNum") <(echo "$ramSize") <(echo "$ramSpeed") <(echo "$ramLocation") <(echo "$totalSize") | column -N Manufacturer,Model,'Seial Number',Size,Speed,Location,'Total size' -s ';' -o ' | ' -t)

####################### Storage Information ##############################

driveManufacturer0=$(echo "$lshwOutput" | grep -A10 '\*\-disk' | grep 'vendor:' | awk '{$1=""; print $0}')
drivevendor1=$(echo "$lshwOutput" | grep -m1 -A8 "\-volume:0" | grep 'vendor:' | awk '{$1=""; print $0}')
drivevendor2=$(echo "$lshwOutput" | grep -m1 -A8 "\-volume:1" | grep 'vendor:' | awk '{$1=""; print $0}')
drivevendor3=$(echo "$lshwOutput" | grep -m1 -A8 "\-volume:2" | grep 'vendor:' | awk '{$1=""; print $0}')

driveModel=$(echo "$lshwOutput" | grep -m1 -A10 "\-disk" | grep 'product:' | awk '{$1=""; print $0}')

driveSize0=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==1 {print $4"B"}')
driveSize1=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==2 {print $4"B"}')
driveSize2=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==3 {print $4"B"}')
driveSize3=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==4 {print $4"B"}')

drivePartition0=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==1 {print $1}')
drivePartition1=$(echo "$lsblkOutput" | grep "sda1" | awk 'FNR==1 {print $1}' | tail -c 5)
drivePartition2=$(echo "$lsblkOutput" | grep "sda2" | awk 'FNR==1 {print $1}' | tail -c 5)
drivePartition3=$(echo "$lsblkOutput" | grep "sda3" | awk 'FNR==1 {print $1}' | tail -c 5)

driveMountPoint0=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==1 {print $7}')
driveMountPoint1=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==2 {print $7}')
driveMountPoint2=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==3 {print $7}')
driveMountPoint3=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==4 {print $7}')

driveFilesystemSizeSDA2=$(echo "$lsblkOutput" | grep "sda2" | awk '{print $2"B"}')
driveFilesystemSizeSDA3=$(echo "$lsblkOutput" | grep "sda3" | awk '{print $2"B"}')

driveFilesystemFreeSDA2=$(echo "$lsblkOutput" | grep "sda2" | awk '{print $4"B"}')
driveFilesystemFreeSDA3=$(echo "$lsblkOutput" | grep "sda3" | awk '{print $4"B"}')

diskTable=$(paste -d ';' <(echo "$drivePartition0" ; echo "$drivePartition1" ; echo "$drivePartition2" ; echo "$drivePartition3") <(echo "$driveManufacturer0" ; echo "$drivevendor1" ; echo "$drivevendor2" ; echo "$drivevendor3") <(echo "$driveModel" ; echo "N/A" ; echo "N/A" ; echo "N/A") <(echo "$driveSize0" ; echo "$driveSize1" ; echo "$driveSize2" ; echo "$driveSize3") <(echo "N/A" ; echo "N/A" ; echo "$driveFilesystemSizeSDA2" ; echo "$driveFilesystemSizeSDA3") <(echo "N/A" ; echo "N/A" ; echo "$driveFilesystemFreeSDA2" ; echo "$driveFilesystemFreeSDA3") <(echo "$driveMountPoint0" ; echo "$driveMountPoint1" ; echo "$driveMountPoint2" ; echo "$driveMountPoint3") | column -N 'Logical Name (/dev/sda)',Vendor,Model,Size,'Filesystem Size','Filesystem Free Space','Mount Point' -s ';' -o ' | ' -t) 
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

$ramTable
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
$diskTable
EOF




