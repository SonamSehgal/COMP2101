#!/bin/bash
#
# This script produces a dynamic welcome message
# it should look like
#   Welcome to planet hostname, title name!

# Task 1: Use the variable $USER instead of the myname variable to get your name
# Task 2: Dynamically generate the value for your hostname variable using the hostname command - e.g. $(hostname)
# Task 3: Add the time and day of the week to the welcome message using the format shown below
#   Use a format like this:
#   It is weekday at HH:MM AM.
# Task 4: Set the title using the day of the week
#   e.g. On Monday it might be Optimist, Tuesday might be Realist, Wednesday might be Pessimist, etc.
#   You will need multiple tests to set a title
#   Invent your own titles, do not use the ones from this example

###############
# Variables   #
day=$(date +%A)
###############
title="Overlord"

###############
# Main        #
###############
cat <<EOF

It is $(date +%A) $(date +%R) $(date +%p)
Welcome to planet $(hostname), "$title $USER!"




EOF

#Print the message for monday.
if [[ $(date +%A) == 'Monday' ]];
then
	ABC='Hangover'
	pwd
fi

#=============================================
#print the message for tuesday.
if [[ $(date +%A) == 'Tuesday' ]];
then
	ABC='Surviving'
	pwd
fi

#=============================================
#Print the message for wednesday.
if [[ $(date +%A) == 'Wednesday' ]];
then
	ABC='Working'
	pwd
fi

#=============================================
#print the message for thursday
if [[ $(date +%A) == 'Thursday' ]];
then
	ABC='Halfway'
	pwd
fi

#=============================================
#Print the message for friday
if [[ $(date +%A) == 'Friday' ]];
then
	ABC='Weekending'
	pwd
fi

#=============================================
#Print the message for saturday
if [[ $(date +%A) == 'Saturday' ]];
then
	ABC='Nightout'
	pwd
fi

#=============================================
#Print the message for sunday
if [[ $(date +%A) == 'Sunday' ]];
then
	ABC='Restart'
	pwd
fi

echo $ABC
