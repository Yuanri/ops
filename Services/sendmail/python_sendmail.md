## Python 发送邮件脚本
### 1、Python 发送TXT 邮件脚本

    #!/usr/bin/env python
    #coding: utf-8 
    import smtplib 
    from email.mime.text import MIMEText
    
    def sendmail(tos,subject,content):
      mail_host = 'mail.domain.com' 
      mail_user = 'mail_user' 
      mail_pass = 'password'
      me="hello"+"<"+mail_user+">" 
      msg = MIMEText(content,_subtype='plain',_charset='gb2312') 
      msg['Subject'] = subject
      msg['From'] = me 
      msg['To'] = ";".join(tos)

      try:
        server = smtplib.SMTP() 
        server.connect(mail_host) 
        server.login(mail_user,mail_pass) 
        server.sendmail(me, tos, msg.as_string()) 
        server.close() 
        return True
      except Exception, e:
        print str(e) 
        return False
        
        
### 2、Python 发送多附件
    #!/usr/bin/env python
    #coding: utf-8  

    # Usage: sendMail.py local-IP receiver att-file
    import smtplib 
    import sys,os 
    from time import strftime
    from email.mime.multipart import MIMEMultipart  
    from email.mime.text import MIMEText  
    from email.mime.image import MIMEImage  


    receiver = sys.argv[1].split(',')
    subject = 'XXXXXXXXXX' 
    username = 'user' 
    password = 'password'  

    attfiles=sys.argv[2:]

    msgRoot = MIMEMultipart('related')  
    msgRoot['Subject'] = subject  

    for attfile in attfiles:
      att = MIMEText(open(attfile, 'rb').read(), 'base64', 'utf-8')  
      att["Content-Type"] = 'application/octet-stream'  
      att["Content-Disposition"] = 'attachment; filename='+os.path.basename(attfile)
      msgRoot.attach(att)  

    smtp = smtplib.SMTP()  
    smtp.connect(username)  
    smtp.login(username, password)  
    smtp.sendmail(username, receiver, msgRoot.as_string())  
    smtp.quit()
