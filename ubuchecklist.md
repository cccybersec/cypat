# packages

## sources.list

## scan for "bad packages"

## system update and upgrade

# disk encryption

# ufw
## gufw?

# app-armor?

# lynis

# passwords 

## empty passwords

# users & groups

## uid of 0

## sudoers

## non approved users

# premissions

## sudo config

# networking
#Display All Current Connections, Listening Services, and Processes
netstat -tulpn

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

# other
#Check for Rootkits
apt-get install rkhunter
rkhunter -C

#chron

