#!/bin/bash

#Heading and command for system’s fully-qualified domain name
echo 'FQDN:'
hostname -f

#Heading and command for The operating system name and version
echo 'Host Information:'
hostnamectl

#Heading and command for the  IP addresses
echo 'IP address:'
hostname -I

#Heading and command for amount of space available
echo 'Space Available:'
df / -h
