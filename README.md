# protectcrypt-ransomware
 
It's a simple bash script in order to avoid to crypt files or folders by ransowmare.

If a ransomware starts to crypt files, the script will kill all PID processes initiated by Ransomware.

The folderfile table variable in the script contains files name such as pdf, png, xlsx, docx etc....

These files must be just a real file sample. Not a real document and the filename must start by "a" letter to be at the top of the folder.


Name file example: /var/www/html/afile.pdf or /home/user/afile.docx etc....

Note: This is the first release. Everyone are welcome to improve this script.


This script depend of following <b>Debian packages</b>:


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&rarr;inotify-tools

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&rarr;auditd
  
  
 
  
By adjustment, you can use on other Linux OS


Note: You can use also this script to check an action on files or folder by sending an email alert without kill processes. Just comment the kill process line in the bash script
