#!/bin/bash

#Heading and command for system’s fully-qualified domain name
FQDN=$(hostname -f)

#Heading and command for The operating system name and version
Host_Information=$(hostnamectl | awk 'FNR == 7 {print $3, $4, $5}')

#Heading and command for the  IP addresses
IP_Address=$(hostname -I)

#Heading and command for amount of space available
Space_Available=$(df / -h | awk 'FNR == 2 {print $4}')

cat <<EOF

My Report

============
FQDN=$FQDN
Operating system name and version=$Host_Information
IP Address=$IP_Address
Root filesystem space line and Space Available=$Space_Available
============

EOF




