#!/bin/bash
#
# this script demonstrates doing arithmetic

# Task 1: Remove the assignments of numbers to the first and second number variables. Use one or more read commands to get 3 numbers from the user.
# Task 2: Change the output to only show:
#    the sum of the 3 numbers with a label
#    the product of the 3 numbers with a label

echo "Enter Num1"
read firstnum
echo "Enter Num2"
read secondnum
echo "Enter Num3"
read thirdnum
firstnum=5
secondnum=2
thirdnum=9
sum=$((firstnum + secondnum + thirdnum))
multiply=$((firstnum * secondnum * thirdnum))

cat <<EOF
$firstnum plus $secondnum plus $thirdnum is $sum
$firstnum multiply by $secondnum multiply by $thirdnum is $multiply

EOF
