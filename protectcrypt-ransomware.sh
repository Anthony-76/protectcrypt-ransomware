#!/bin/bash


# Kill process from Ransomware
# If the ransomware starts to crypt files test present in folderfile table variable, the script will kill all pid initiated by Ransomware
# The folderfile table variable in this script contains file such as pdf, png, xlsx, docx etc....
# These files must be just a real file sample. Not a real document and the filename must start by "a" letter to be at the top of the folder.
# This script is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE


# Author: Anthony Havé - Sysun Cybersécurité
# Release version: 1.0.1 
# Release date : 2 february 2022
# Tested on Debian Plateform
# GNU General Public License v3.0


#path or file to check
folderfile=( "/var/www/html/afile.pdf" "/home/user/afile.docx" )

#log action on the above files in audit.log
for file in "${folderfile[@]}"
do
   /sbin/auditctl -w $file -p warx
done


while true
do
        filetouched=`/bin/inotifywait -q ${folderfile[@]} | sed -e 's/ .*//g'`
        #ausearch check audit.log to find PID processes
        pidtokill=`/sbin/ausearch -f $filetouched | grep ' pid=[0-9]* ' | sed -e 's/.* pid=//g' -e 's/ .*//g' | tr '\n' ' ' `
        #kill all processes
        /bin/kill -9 $pidtokill 2>&1 /dev/null
        pidresidue=`ps -ef | grep $filetouched | grep -v grep | awk -F " " '{print $2}'`
        #kill process if ausearch had not match all PID
        /bin/kill -9 $pidresidue 2>&1 /dev/null
        
        if [ "$pidtokill" != "" ]
        then
             #this is a simple action to trigger an alert email. /home/user/email.txt contains the body of email.
             /bin/mail -s "Ransomware attack" -a "From: email@domain.tld" myemail@mydomain.tld < /home/user/email.txt 
        fi
done



exit 0;

