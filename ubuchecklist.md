# packages

## sources.list

## scan for "bad packages"

## system update and upgrade

# lynis

# passwords 

## empty passwords

# users & groups
disable root user

## uid of 0

## sudoers

## non approved users

# premissions

## sudo config

# networking
#Display All Current Connections, Listening Services, and Processes
netstat -tulpn

## ufw
gufw?

## ip tables

# services
sshd

# log locations
/var/log/message — Where whole system logs or current activity logs are available.  
/var/log/auth.log — Authentication logs.  
/var/log/kern.log — Kernel logs.  
/var/log/cron.log — Crond logs (cron job).  
/var/log/maillog — Mail server logs.  
/var/log/boot.log — System boot log.  
/var/log/mysqld.log — MySQL database server log file.  
/var/log/secure — Authentication log.  
/var/log/utmp or /var/log/wtmp — Login records file.  
/var/log/apt — Apt package manager logs.  

# CUPS


# other
#Check for Rootkits  
apt-get install rkhunter
rkhunter -C

#fail2ban

#disk encryption

## clamav
Update database – sudo apt-get update  
o Install ClamAV – sudo apt-get install clamav  
o Update virus database – sudo freshclam  
o Check entire system for viruses – sudo clamscan –i –r --remove=yes /  
- Run this in a separate terminal as it will take a while

see if config files have been changed
dpkg-query -W -f='${Conffiles}\n' '*' | awk 'OFS="  "{print $2,$1}' | LANG=C md5sum -c 2>/dev/null | awk -F': ' '$2 !~ /OK$/{print $1}' | sort | less

#app-armor?

#chron

