buppaths=("/etc/pam.d/common-auth" "/etc/pam.d/common-password" "/etc/login.defs" "/etc/shadow" "/etc/group" "/etc/passwd" "/etc/ssh/sshd_config" "/etc/apt/sources.list")

# funky sed sheniganders that appends .bak to these ^
for buppath in ${buppaths[@]}
do	
	  # sed '' $buppath -i.bak
    echo $buppath
done
