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
debver=bullseye
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
if [ $YOLO == true ]; then
	sed -i '/^#/!s/^/#/' /etc/apt/sources.list
	echo "
	deb http://deb.debian.org/debian/ $debver-updates main contrib
	deb http://security.debian.org/debian-security $debver-security main contrib
	deb http://deb.debian.org/debian/ $debver main contrib " >> /etc/apt/sources.list
else
	cat /etc/apt/sources.list
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

_passwd-reqs(){


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

_pkginstall(){ 
goodpkgs=("ufw lynis rkhunter clamtk libpam-cracklib libpam-pwquality")
if [ $YOLO == true ]; then
	sudo apt-get install ${goodpkgs}
else
	echo "install these packages:" ${goodpkgs}
fi
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






_pkgsearch
_sudoers-check
