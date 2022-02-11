#!/bin/bash


# Kill process from Ransomware
# If the ransomware strts to crypt files test present in folderfile table variable, the script will kill all pid initiated by Ransomware
# The folderfile table variable in this script contains file such as pdf, png, xlsx, docx etc....
# These files must be just a real file sample. Not a real document and the filename must start by "a" letter to be at the top of the folder.
# This script is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE


# Author: Anthony Havé
# Release version: 1.0.1 - Beta
# Release date : 11 february 2022
# Tested on Debian Plateform


#path or file to check
folderfile=( "/var/www/html/afile.pdf" "/home/user/afile.docx" )

for file in "${folderfile[@]}"
do
   /sbin/auditctl -w $file -p warx
done


while true
do
        filetouched=`/bin/inotifywait -q ${folderfile[@]} | sed -e 's/ .*//g'`
        pidtokill=`/sbin/ausearch -f $filetouched | grep ' pid=[0-9]* ' | sed -e 's/.* pid=//g' -e 's/ .*//g' | tr '\n' ' ' `
        #kill all process
        /bin/kill -9 $pidtokill 2>&1 /dev/null
        pidresidue=`ps -ef | grep $filetouched | grep -v grep | awk -F " " '{print $2}'`
        #kill process if ausearch had not match all pid
        /bin/kill -9 $pidresidue 2>&1 /dev/null
done



exit 0;

