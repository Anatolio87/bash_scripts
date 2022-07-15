#!/bin/sh

# create a file to store the password
output="psw.txt"
# remove the password file, if already exists.

trap "rm -f psw.txt" 2 15
dialog --title "Password" \
--insecure \
--clear \
--passwordbox "Please enter password" 10 30 2> $output
reply=$?
case $reply in
0) echo "You have entered Password : $(cat $output)";;
1) echo "You have pressed Cancel";;
255) cat $data && [ -s $data ] || echo "Escape key is pressed.";;
esac

# getting the value into a variable
var=$(cat $output)

echo $var

# remove the password file
rm psw.txt

# create a file to store the password
output="psw.txt"
# remove the password file, if already exists.

trap "rm -f psw.txt" 2 15
dialog --title "Password" \
--insecure \
--clear \
--passwordbox "Please enter password" 10 30 2> $output
reply=$?
case $reply in
0) echo "You have entered Password : $(cat $output)";;
1) echo "You have pressed Cancel";;
255) cat $data && [ -s $data ] || echo "Escape key is pressed.";;
esac

# getting the value into a variable
var=$(cat $output)

echo $var

# remove the password file
rm psw.txt
