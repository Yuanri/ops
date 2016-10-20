#!/usr/bin/env python
#coding: utf-8  

# Usage: sendMail.py   receiver1,re2,re3  att-file0  att-file1 att-file2
import smtplib 
import sys,os 
from time import strftime
from email.mime.multipart import MIMEMultipart  
from email.mime.text import MIMEText  
from email.mime.image import MIMEImage  

# multi receiver split with ','

subject = 'MySQL Slow Log' 
smtpserver = 'mail.example.com'  
username = 'username' 
sender='from_user'
password = 'password'  


receiver = sys.argv[1].split(',')
attfiles = sys.argv[2:]

msgRoot = MIMEMultipart('related')  
msgRoot['Subject'] = subject  

# more att file
for attfile in  attfiles:  
	att = MIMEText(open(attfile, 'rb').read(), 'base64', 'utf-8')  
	att["Content-Type"] = 'application/octet-stream'  
	att["Content-Disposition"] = 'attachment; filename='+os.path.basename(attfile) 
	msgRoot.attach(att)  
          
smtp = smtplib.SMTP()  
smtp.connect(smtpserver)  
smtp.login(username, password)  
smtp.sendmail(sender, receiver, msgRoot.as_string())  
smtp.quit()
