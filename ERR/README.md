
# ERR 
### 1、No space left on device: mod_security: Could not create modsec_auditlog_lock
Today one of my customers contacted me with a normally simple “directadmin won’t restart my apache” question. I restarted apache via SSH and still nothing. I checked the apache error_log and saw the following error:
[Thu Sep 18 13:09:02 2008] [error] (28)No space left on device: mod_security: Could not create modsec_auditlog_lock
Configuration Failed

Did the normal things like checking the free space on the hard disk, cleaning /tmp etc, and then went on google to search for a solution. Then i found the following post:
This was because mod_security wasn’t cleaning up its semaphores for some reason. My solution was to add this to the stop function in my init script:

    ipcs | perl -ane ‘`ipcrm -s $F[1]` if $F[2] == “apache” and $F[1] =~ /\d+/ and $F[1] != 0′
    
This removes any semaphores left by Apache when ever /etc/init.d/httpd stop or /etc/init.d/httpd restart are called.
After running this command apache was willing to start again. Problem solved!
