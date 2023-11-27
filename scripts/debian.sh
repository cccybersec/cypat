#!/bin/bash

# require root
if [ "$(id -u)" -ne 0 ]; then
		        echo 'This script must be run by root' >&2
    exit 1
fi

script_dir=$(dirname "$0")
log_file="logfile.log"

# Check if the log file already exists
if [ -e "$log_file" ]; then
    # Find the next available logfile
    i=1
    while [ -e "logfile$i.log" ]; do
        ((i++))
    done
    log_file="logfile$i.log"
fi

# Redirect both stdout and stderr to the terminal and log file
exec > >(tee -a "$log_file") 2>&1

#SET 
#THESE
#VARS!V!V!V!V!V!V!V!
#yolo=false echo things yolo=true do the things like remove users and edit files
YOLO=false
# the name of the debain version like bullseye or bookworm
debver=bullseye
# get users & admins from the README you can use chat gpt for easy formatting ("user" "user" "user")
users=("pverisof" "rolivaw" "jfara" "lpirenne" "lponyets" "lcrast" "shardin" "tsutt" "yfulham" "ylee" "dvenabili" "gtrevize" "jpelorat")
admins=("gdornick" "hseldon" "hmallow" "adarell")



_backup-files(){
## make copys of EVERYTHING that is changed in case my code hits the fan
buppaths=("/etc/pam.d/common-auth" "/etc/pam.d/common-password" "/etc/login.defs" "/etc/shadow" "/etc/group" "/etc/passwd" "/etc/ssh/sshd_config" "/etc/apt/sources.list")

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
if [ $YOLO == true ]; then
	echo "
	deb http://deb.debian.org/debian/ $debver-updates main contrib
	deb http://security.debian.org/debian-security $debver-security main contrib
	deb http://deb.debian.org/debian/ $debver main contrib " >> /etc/apt/sources.list
else
	cat /etc/apt/sources.list
fi
}

_pkginstall(){ 
goodpkgs=("ufw lynis rkhunter clamtk libpam-pwquality")
if [ $YOLO == true ]; then
	sudo apt-get install ${goodpkgs}
else
	echo "install these packages:" ${goodpkgs}
fi
}

_sshd(){
if [ $YOLO == true ]; then # make a proper sshd config later
sed -i '/^#/!s/^/#/' /etc/ssh/sshd_config # defaults should be good ¯\_(ツ)_/¯
echo /etc/ssh/sshd_config 
else
echo /etc/ssh/sshd_config
fi
}

_pam-cpasswd(){
if [ $YOLO == true ]; then
	sed -i '/^#/!s/^/#/' /etc/pam.d/common-password
	(echo "password	requisite			pam_pwquality.so retry=3 minlen=12 maxrepeat=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1 difok=4 reject_username enforce_for_root"
	echo "password	[success=1 default=ignore]	pam_unix.so obscure use_authtok try_first_pass yescrypt"
	echo "password	requisite			pam_deny.so"
	echo "password	required			pam_permit.so"
	echo "password	optional	pam_gnome_keyring.so " 
	cat /etc/pam.d/common-password) > /etc/pam.d/common-password.tmp && mv /etc/pam.d/common-password.tmp /etc/pam.d/common-password
else
	cat /etc/pam.d/common-password
fi
}

_login-defs(){
if [ $YOLO == true ]; then
	cat $script_dir/deb-login.defs > /etc/login.defs
else
	cat /etc/login.defs | grep -v '^#'
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
		if [ $YOLO == true ]; then
			gpasswd --delete $cur_su sudo
		else
       		echo $cur_su
		fi
    fi
done
}


_ufw(){
if [ $YOLO == true ]; then
	ufw reset --force & ufw enable
else
	ufw enable
fi
}

_avscan(){
if [ $YOLO == true ]; then
	echo start a clamtk scan from the gui
else
	echo start a clamtk scan from the gui
fi
}

_chmod(){
if [ $YOLO == true ]; then
	chmod u-x,go-wx /etc/passwd
	chown root:root /etc/passwd

	chmod u-x,go-wx /etc/passwd-
	chown root:root /etc/passwd-

	chmod u-x,go-wx /etc/group
	chown root:root /etc/group

	chmod u-x,go-wx /etc/group-
	chown root:root /etc/group-

	chmod u-x,g-wx,o-rwx /etc/shadow
	chown root:root /etc/shadow

	chmod u-x,g-wx,o-rwx /etc/shadow-
	chown root:root /etc/shadow-

	chmod u-x,g-wx,o-rwx /etc/gshadow
	chown root:root /etc/gshadow

	chmod u-x,g-wx,o-rwx /etc/gshadow-
	chown root:root /etc/gshadow-

	chmod u-x,go-wx /etc/shells
	chown root:root /etc/shells

	[ -e "/etc/security/opasswd" ] && chmod u-x,go-rwx /etc/security/opasswd
	[ -e "/etc/security/opasswd" ] && chown root:root /etc/security/opasswd
	[ -e "/etc/security/opasswd.old" ] && chmod u-x,go-rwx /etc/security/opasswd.old
	[ -e "/etc/security/opasswd.old" ] && chown root:root /etc/security/opasswd.old

	# 6.1.14 Ensure system command files are group-owned by root
	find /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin ! -group root -type f ! -perm /2000 -exec chgrp root '{}' \;

	# 6.1.16 Ensure directories that contain system commands set to 0755 or more restrictive
	find /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin -perm /022 -type d -exec chmod -R 755 '{}' \;

	# 6.1.17 Ensure system library directories are group-owned by root
	find /lib /usr/lib /lib64 ! -group root -type d -exec chgrp root '{}' \;

	# 6.1.18 Ensure system library files are group-owned by root
	find /lib /usr/lib /lib64 ! -group root -type f -exec chgrp root '{}' \;

	#6.1.19 Ensure system library directories are owned by root
	find /lib /usr/lib /lib64 ! -user root -type d -exec chown root '{}' \;

	# 6.1.20 Ensure directories that contain system commands are owned by root
	find /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin ! -user root -type d -exec stat -c "%n %U" '{}' \;

	# 6.1.21 Ensure system library files are owned by root
	find /lib /usr/lib /lib64 ! -user root -type f -exec chown root '{}' \;

	# 6.1.22 Ensure directories that contain system commands are group-owned by root
	find /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin ! -group root -type d -exec stat -c "%n %G" '{}' \;

	# 6.1.23 Ensure system library directories are 0755 or more restrictive
	find /lib /lib64 /usr/lib -perm /022 -type d -exec chmod 755 '{}' \;

	# 6.1.24 Ensure system library files are 0755 or more restrictivE\e
	find /lib /lib64 /usr/lib -perm /022 -type f -exec chmod 755 '{}' \;
else
	echo "add ls-ing perms for files"
fi
}




_backup-files
_config_diff
_apt-source
_pkginstall
_sshd
_pam-cpasswd
_login-defs
_pkgsearch
_uid-check
_sudoers-check
_ufw
_avscan
_chmod
