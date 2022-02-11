# protectcrypt-ransomware
Simple bash script in order to avoid to crypt files or folders by ransowmare.

If a ransomware starts to crypt files, the script will kill all pid initiated by Ransomware.

The folderfile table variable contains files name  such as pdf, png, xlsx, docx etc....

These files must be just a real file sample. Not a real document and the filename must start by "a" letter to be at the top of the folder.


Name file example: /var/www/html/afile.pdf or /home/user/afile.docx etc....

Note: This is the first release. Everyone are welcome to improve this script.


This script depend of following Debian packages:


  -inotify-tools

  -auditd
