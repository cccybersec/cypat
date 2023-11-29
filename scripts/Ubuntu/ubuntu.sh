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
# the name of the debain version like bullseye or bookworm
ubuver=focal
# get users & admins from the README you can use chat gpt for easy formatting ("user" "user" "user")
users=("pverisof" "rolivaw" "jfara" "lpirenne" "lponyets" "lcrast" "shardin" "tsutt" "yfulham" "ylee" "dvenabili" "gtrevize" "jpelorat")
admins=("gdornick" "hseldon" "hmallow" "adarell")


_backup-files(){
## make copys of EVERYTHING that is changed in case my code hits the fan
buppaths=("/etc/pam.d/common-auth" "/etc/pam.d/common-password" "/etc/shadow" "/etc/group" "/etc/passwd" "/etc/ssh/sshd_config" "/etc/apt/sources.list")

# funky sed sheniganders that appends .bak to these ^
for buppath in $buppaths
do	
	    sed '' $buppath -i.bak
done
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


_pkgsearch(){
#search for no no haxor man packages
badpkgs=("nmap" "zenmap" "apache2" "nginx" "lighttpd" "wireshark" "tcpdump" "netcat" "nikto" "crack" "etter" "deluge" "sploit" "john" "ydra" "burp" "strike" "veil" "darkcomet" "empire")

for badpkg in "${badpkgs[@]}"; do
	dpkg-query --showformat='${Package}\n' --show | grep $badpkg
	if [ $? -eq 0 ]; then
		if [ YOLO == true ]; then
			echo ${Package} | grep "\S" | apt remove #!#!# need to test if this works
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


_ufw(){
if [ YOLO == true ]; then

else

fi
}


_pkgsearch
_sudoers-check
_backup
_ufw
_uid-check
_apt-source
