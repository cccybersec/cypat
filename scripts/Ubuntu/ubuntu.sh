#!/bin/bash

# require root
if [ "$(id -u)" -ne 0 ]; then
		        echo 'This script must be run by root' >&2
    exit 1
fi


#SET 
#THESE
#VARS!V!V!V!V!V!V!V!
#yolo=false echo things yolo=true do the things like remove users and edit files
YOLO=false
# the name of the ubuntu version like bullseye or snapbloat
ubuver=focal
# get users & admins from the README you can use chat gpt for easy formatting ("user" "user" "user")
users=("pverisof" "rolivaw" "jfara" "lpirenne" "lponyets" "lcrast" "shardin" "tsutt" "yfulham" "ylee" "dvenabili" "gtrevize" "jpelorat")
admins=("gdornick" "hseldon" "hmallow" "adarell")


_backup-files(){
## make copys of EVERYTHING that is changed in case my code hits the fan
buppaths=("/etc/pam.d/common-auth" "/etc/pam.d/common-password" "/etc/login.defs" "/etc/shadow" "/etc/group" "/etc/passwd" "/etc/ssh/sshd_config" "/etc/apt/sources.list" "/etc/adduser.conf" "/etc/audit/auditd.conf" "/etc/audit/rules.d/hardening.rules" "/etc/pam.d/common-password" "/etc/pam.d/common-account" "/etc/pam.d/common-auth" "/etc/systemd/coredump.conf" "/etc/default/grub.d" "/etc/modprobe.d/disablefs.conf" "/etc/modprobe.d/disablemod.conf" "/etc/modprobe.d/disablenet.conf" "/etc/security/faillock.conf" "/etc/systemd/journald.conf" "/etc/security/limits.conf" "/etc/systemd/logind.conf" "/etc/login.defs" "/etc/logrotate.conf" "/etc/pam.d/login" "/etc/psad/psad.conf" "/etc/psad/auto_dl" "/etc/systemd/resolved.conf" "/etc/default/rkhunter" "/etc/rsyslog.conf" "/etc/security/access.conf" "/etc/ssh/ssh_config" "/etc/ssh/sshd_config" "/etc/sysctl.conf" "/etc/systemd/system.conf" "/etc/systemd/timesyncd.conf" "/etc/default/ufw" "/etc/default/useradd" "/etc/systemd/user.conf"
)

# funky sed sheniganders that appends .bak to these ^
for buppath in ${buppaths[@]}
do	
	    sed '' $buppath -i.bak
done
}

_config_diff(){
dpkg-query -W -f='${Conffiles}\n' '*' | awk 'OFS="  "{print $2,$1}' | LANG=C md5sum -c 2>/dev/null | awk -F': ' '$2 !~ /OK$/{print $1}'

echo "if anything shows up press no and check the file/s then rerun script and press yes"

# Ask the user if they want to continue
read -p "Do you want to continue? (y/n): " exit_script

if [[ "$exit_script" == "y" || "$exit_script" == "Y" ]]; then
    echo "onwards"
else
    echo "so long pardner"
    exit 0
fi
}


_apt-source(){
# add correct sources to sources.list
if [ YOLO == true ]; then
	sed -i '/^#/!s/^/#/' /etc/apt/sources.list
	echo "
	deb http://security.ubuntu.com/ubuntu $ubuver-security main restricted
	deb http://security.ubuntu.com/ubuntu $ubuver-security universe
	deb http://security.ubuntu.com/ubuntu $ubuver-security multiverse " >> /etc/apt/sources.list
else
	cat /etc/apt/sources.list
fi
}


_pkgsearch(){ ## add note about libpam-cracklib in run section to echo to user
#search for no no haxor man packages
badpkgs=("nmap" "zenmap" "apache" "nginx" "lighttpd" "wireshark" "tcpdump" "netcat" "nikto" "crack" "etter" "deluge" "sploit" "john" "ydra" "burp" "strike" "veil" "darkcomet" "empire")

for badpkg in "${badpkgs[@]}"; do
	dpkg-query --showformat='${Package}\n' --show | grep $badpkg
	if [ $? -eq 0 ]; then
		if [ YOLO == true ]; then
			#echo ${Package} | grep "\S" | apt remove #!#!# need to test if this works
			echo ${Package} | grep "\S"
		else
			#the "\S" removes blank lines
			echo ${Package} | grep "\S"
		fi
	fi
done
}




_uid-check(){
mawk -F: '$3 == 0 && $1 != "root"' /etc/passwd
}


_sudoers-check(){
current_sudo=$(getent group sudo | cut -d: -f4 | sed 's/,/ /g')
for cur_su in ${current_sudo[@]}; do
   	echo ${admins[@]} | grep -Eqow $cur_su
   	if [ $? -eq 1 ]; then
		if [ YOLO == true ]; then
			gpasswd --delete $cur_su sudo
		else
       		echo $cur_su
		fi
    fi
done
}



_pkgsearch
_sudoers-check
_backup
_uid-check
_apt-source
_config_diff

