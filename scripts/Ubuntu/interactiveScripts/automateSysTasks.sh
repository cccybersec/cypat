#!/bin/bash

# Function to perform system backups and archive them
backup_system() {
    # Create a backup directory if it doesn't exist
    if [ ! -d "/var/backups" ]; then
        sudo mkdir /var/backups
    fi

    # Create a backup file with timestamp
    backup_file="/var/backups/backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

    # Archive system files and directories
    sudo tar -czvf $backup_file /etc /home /var/log

    # Print success message
    echo "System backup created at $backup_file"
}

# Function to monitor and analyze system logs for suspicious activities
monitor_logs() {
    # Check for failed login attempts
    failed_logins=$(grep "Failed password" /var/log/auth.log | wc -l)
    if [ $failed_logins -gt 0 ]; then
        echo "WARNING: $failed_logins failed login attempts detected"
    fi

    # Check for sudo access attempts
    sudo_access=$(grep "sudo:" /var/log/auth.log | wc -l)
    if [ $sudo_access -gt 0 ]; then
        echo "WARNING: $sudo_access sudo access attempts detected"
    fi

    # Check for SSH login attempts
    ssh_logins=$(grep "sshd" /var/log/auth.log | wc -l)
    if [ $ssh_logins -gt 0 ]; then
        echo "WARNING: $ssh_logins SSH login attempts detected"
    fi
}

# Function to run security scanning tools to identify vulnerabilities
run_security_scan() {
    # Install and run Lynis security auditing tool
    sudo apt-get update
    sudo apt-get install lynis -y
    sudo lynis audit system
}

# Function to automate vulnerability assessment and remediation where possible
automate_vulnerability() {
    # Install and run unattended-upgrades package for automatic security updates
    sudo apt-get update
    sudo apt-get install unattended-upgrades -y
    sudo dpkg-reconfigure -plow unattended-upgrades
}

# Function to schedule regular system updates and patch management
schedule_updates() {
    # Install and configure cron-apt package for automatic updates
    sudo apt-get update
    sudo apt-get install cron-apt -y
    sudo dpkg-reconfigure -plow cron-apt
}

# Function to enforce password policies, including complexity and expiration rules
enforce_password_policy() {
    # Install and configure libpam-pwquality package for password policy enforcement
    sudo apt-get update
    sudo apt-get install libpam-pwquality -y
    sudo sed -i 's/# minlen = 8/minlen = 12/g' /etc/security/pwquality.conf
    sudo sed -i 's/# dcredit = 0/dcredit = -1/g' /etc/security/pwquality.conf
    sudo sed -i 's/# ucredit = 0/ucredit = -1/g' /etc/security/pwquality.conf
    sudo sed -i 's/# ocredit = 0/ocredit = -1/g' /etc/security/pwquality.conf
    sudo sed -i 's/# lcredit = 0/lcredit = -1/g' /etc/security/pwquality.conf
    sudo sed -i 's/# minclass = 0/minclass = 2/g' /etc/security/pwquality.conf
    sudo sed -i 's/# maxrepeat = 0/maxrepeat = 2/g' /etc/security/pwquality.conf
    sudo sed -i 's/# maxsequence = 0/maxsequence = 3/g' /etc/security/pwquality.conf
    sudo sed -i 's/# maxclassrepeat = 0/maxclassrepeat = 2/g' /etc/security/pwquality.conf
    sudo sed -i 's/# minclass = 0/minclass = 2/g' /etc/pam.d/common-password
}

# Main function to execute all system maintenance tasks
main() {
    # Call each function to perform system maintenance tasks
    backup_system
    monitor_logs
    run_security_scan
    automate_vulnerability
    schedule_updates
    enforce_password_policy
}

# Call main function
main
