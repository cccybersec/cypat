# Debian script for CyPat #

import os
import subprocess

if subprocess.getoutput("whoami") != "root":
    print("WARNING: You are not running this script as root.")
    run_anyway = input("Run script anyway? (y/n) ").lower()

    if run_anyway == "y" or run_anyway == "yes":
        print("Running script.")
    else:
        print("Exiting.")
        exit()

# main_user = input("Who is the main user? (ex: perry in the training rounds): ")
# ^^^^ UNCOMMENT IF SETTING PASSWORD POLICIES ON CURRENT USERS GETS UNCOMMENTED (around line 130)

# update apt repos and install package upgrades
os.system("sudo apt update && sudo apt upgrade")

# install unattended-upgrades and enable auto update
os.system("sudo apt install unattended-upgrades")
#TODO

# install and enable ufw
os.system("sudo apt install ufw")
os.system("sudo ufw enable")
print("UFW is installed and enabled.")

# install, start and enable ssh
os.system("sudo apt install openssh-server")
os.system("sudo systemctl enable sshd")
os.system("sudo systemctl start sshd")

# disable root ssh login by replacing text in config
os.system("sudo sed -i \"s/PermitRootLogin yes/PermitRootLogin no/g\" /etc/ssh/sshd_config")
print("Disabled root login through SSH.")

# update db for locating files
os.system("sudo updatedb")
print("Updated file name database.")

# search for media files, prompt whether to delete or not
locate_output = (subprocess.getoutput("locate *.mp3") + "\n" + subprocess.getoutput("locate *.mp4") + "\n" + subprocess.getoutput("locate *.wav")).split("\n")
for file in locate_output:
    if file != '':
        should_delete = input(f"Delete media file {file}? (y/n/stop) ").lower()
        if should_delete == "y":
            try:
                print("Deleted media file.")
                os.remove(file)
            except:
                print("Failed to delete media file, please try doing it manually.")
        elif should_delete == "stop" or should_delete == "s":
            print("Stopped going through media files.")
            break
        elif should_delete == "n":
            print("Did not delete media file.")
        else:
            print("Invalid input; defaulted to not deleting.")

# disable anonymous ftp login
os.system("sudo sed -i \"s/anonymous_enable=YES/anonymous_enable=NO/g\" /etc/vsftpd.conf")
print("Disabled vsftpd anonymous_enable")

# enable ssl for ftp
os.system("sudo sed -i \"s/ssl_enable=NO/ssl_enable=YES/g\" /etc/vsftpd.conf")
print("Enabled vsftpd ssl_enable")

# require sudo to authenticate
os.system("sudo sed -i \"s/!authenticate/authenticate/g\" /etc/sudoers")
print("Enabled sudo requiring authentication.\nWARNING: Double check /etc/sudoers anyway.")

# remember previous passwords and extra dictionary-based strength tests added
try:
    with open("/etc/pam.d/common-password", "a+") as common_password_file:
        common_password_file.write("\npassword requisite pam_pwquality.so\n")
        print("Set better password strength (Extra dictionary-based checks)")
        print("Set setting for remembering past passwords.")
        print("WARNING: Please check /etc/pam.d/common-password for any conflicts this may have made.")
except:
    print("ERROR: Failed to edit /etc/pam.d/common-password; it may not exist.")


# set good password aging policies for future users
try:
    with open('/etc/login.defs', 'r') as logindefs_file:
        lines = logindefs_file.readlines()
        
        # iterate through lines in login.defs and set different values.
        for i, line in enumerate(lines): 
            if line.startswith("PASS_MAX_DAYS"):
                lines[i] = "PASS_MAX_DAYS 90\n"
            elif line.startswith("PASS_MIN_DAYS"):
                lines[i] = "PASS_MIN_DAYS 7\n"
            elif line.startswith("PASS_WARN_AGE"):
                lines[i] = "PASS_WARN_AGE 5\n"

        # write changes to login.defs
        with open('/etc/login.defs', 'w') as file:
            file.writelines(lines)
        print("Set system password aging policies for future users.")

except:
    print("ERROR: Failed to read/write /etc/login.defs")


# get all users on system, and authorized users from authorized-users.txt.
users = []
auth_users = []


# get all users on system and append to users list
with open('/etc/passwd', 'r') as passwd_file:
    for line in passwd_file.readlines():
        if "/home/" in line: # only have actual users
            users.append(line.split(":")[0]) # only take user's name from /etc/passwd

# read authorized_users.txt and append to auth_users list
try:
    with open('authorized-users.txt', 'r') as authorized_users:
        for user in authorized_users.readlines():
            auth_users.append(user.strip())
except:
    print("ERROR: Failed to read authorized-users.txt; it may not exist.")

# set good password aging policies for current users
""" DISABLED UNTIL FIXED, because I ended up soft locking sudo authentication after running it, and this doesn't seem required.
for user in users:
    if user != "root" and user != "main_user":
        os.system(f"sudo chage --mindays 7 --maxdays 90 --warndays 5 {user}")

    print("Set system password aging policies for current users.")

"""

# check if any users are unauthorized on the system and ask whether to delete or not
for auth_user in auth_users:
    if auth_user != "DISABLED":
        if auth_user not in auth_users:
            remove_user = input(f"Remove user {auth_user}? They are not in authorized_users.txt. WARNING: Double check before answering! (y/n) ").lower()
            if remove_user == "y" or remove_user == "yes":
                pass # remove user here
            elif remove_user == "n" or remove_user == "no":
                print("Not removing user.")
            else:
                print("Invalid input; defaulting to not removing user.")
    else:
        print("authorized-users.txt is set to DISABLED. Not checking users.")
        break

# ensure /etc/shadow has correct file permissions.
# owner has rw, owner's group has r, all others have none.
os.system("sudo chmod 640 /etc/shadow")

# ask user whether to disable ipv4 forwarding or not
disable_ip_forward = input("Disable IPv4 Forwarding? You can always change this later in /etc/sysctl.conf (y/n) ").lower()
if disable_ip_forward == "y" or disable_ip_forward == "yes":
    os.system("sudo sed -i \"s/net.ipv4.ip_forward=1/net.ipv4.ip_forward=0/g\" /etc/sysctl.conf")
    print("Disabled IPv4 forwarding.")
else:
    print("Leaving IPv4 forwarding settings at default.")
