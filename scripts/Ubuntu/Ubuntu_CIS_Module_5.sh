#!/bin/bash

# 5.1.1 Ensure cron daemon is enabled and running
ensure_cron_daemon_enabled_running() {
    echo "Ensuring cron daemon is enabled and running..."
    if systemctl is-enabled cron >/dev/null 2>&1; then
        echo "cron daemon is enabled."
    else
        systemctl enable cron
        echo "cron daemon is now enabled."
    fi
    if systemctl is-active cron >/dev/null 2>&1; then
        echo "cron daemon is running."
    else
        systemctl start cron
        echo "cron daemon is now running."
    fi
}

# Call the function to ensure cron daemon is enabled and running
ensure_cron_daemon_enabled_running

# 5.1.2 Ensure permissions on /etc/crontab are configured
ensure_crontab_permissions() {
    echo "Ensuring permissions on /etc/crontab are configured..."
    if ! stat -L -c "%a %u %g" /etc/crontab | grep -q "^600 0 0"; then
        echo "Permissions on /etc/crontab are not configured. Setting permissions to 600..."
        if ! chmod 600 /etc/crontab; then
            echo "Failed to set permissions on /etc/crontab to 600."
            return 1
        fi
    else
        echo "Permissions on /etc/crontab are configured."
    fi
}

# Call the function to ensure permissions on /etc/crontab are configured
ensure_crontab_permissions

# 5.1.3 Ensure permissions on /etc/cron.hourly are configured
ensure_cron_hourly_permissions() {
    echo "Ensuring permissions on /etc/cron.hourly are configured..."
    if ! stat -L -c "%a %u %g" /etc/cron.hourly | grep -q "^600 0 0"; then
        echo "Permissions on /etc/cron.hourly are not configured. Setting permissions to 600..."
        if ! chmod 600 /etc/cron.hourly; then
            echo "Failed to set permissions on /etc/cron.hourly to 600."
            return 1
        fi
    else
        echo "Permissions on /etc/cron.hourly are configured."
    fi
}

# Call the function to ensure permissions on /etc/cron.hourly are configured
ensure_cron_hourly_permissions

# 5.1.4 Ensure permissions on /etc/cron.daily are configured
ensure_cron_daily_permissions() {
    echo "Ensuring permissions on /etc/cron.daily are configured..."
    if ! stat -L -c "%a %u %g" /etc/cron.daily | grep -q "^600 0 0"; then
        echo "Permissions on /etc/cron.daily are not configured. Setting permissions to 600..."
        if ! chmod 600 /etc/cron.daily; then
            echo "Failed to set permissions on /etc/cron.daily to 600."
            return 1
        fi
    else
        echo "Permissions on /etc/cron.daily are configured."
    fi
}

# Call the function to ensure permissions on /etc/cron.daily are configured
ensure_cron_daily_permissions

# 5.1.5 Ensure permissions on /etc/cron.weekly are configured
ensure_cron_weekly_permissions() {
    echo "Ensuring permissions on /etc/cron.weekly are configured..."
    if ! stat -L -c "%a %u %g" /etc/cron.weekly | grep -q "^600 0 0"; then
        echo "Permissions on /etc/cron.weekly are not configured. Setting permissions to 600..."
        if ! chmod 600 /etc/cron.weekly; then
            echo "Failed to set permissions on /etc/cron.weekly to 600."
            return 1
        fi
    else
        echo "Permissions on /etc/cron.weekly are configured."
    fi
}

# Call the function to ensure permissions on /etc/cron.weekly are configured
ensure_cron_weekly_permissions

# 5.1.6 Ensure permissions on /etc/cron.monthly are configured
ensure_cron_monthly_permissions() {
    echo "Ensuring permissions on /etc/cron.monthly are configured..."
    if ! stat -L -c "%a %u %g" /etc/cron.monthly | grep -q "^600 0 0"; then
        echo "Permissions on /etc/cron.monthly are not configured. Setting permissions to 600..."
        if ! chmod 600 /etc/cron.monthly; then
            echo "Failed to set permissions on /etc/cron.monthly to 600."
            return 1
        fi
    else
        echo "Permissions on /etc/cron.monthly are configured."
    fi
}

# Call the function to ensure permissions on /etc/cron.monthly are configured
ensure_cron_monthly_permissions

# 5.1.7 Ensure permissions on /etc/cron.d are configured
ensure_cron_d_permissions() {
    echo "Ensuring permissions on /etc/cron.d are configured..."
    if ! stat -L -c "%a %u %g" /etc/cron.d | grep -q "^600 0 0"; then
        echo "Permissions on /etc/cron.d are not configured. Setting permissions to 600..."
        if ! chmod 600 /etc/cron.d; then
            echo "Failed to set permissions on /etc/cron.d to 600."
            return 1
        fi
    else
        echo "Permissions on /etc/cron.d are configured."
    fi
}

# Call the function to ensure permissions on /etc/cron.d are configured
ensure_cron_d_permissions

# 5.1.8 Ensure cron is restricted to authorized users
ensure_cron_authorized_users() {
    echo "Ensuring cron is restricted to authorized users..."
    # Create /etc/cron.allow if it does not exist
    if [ ! -f /etc/cron.allow ]; then
        touch /etc/cron.allow
    fi
    # Add authorized users to /etc/cron.allow
    echo "root" >>/etc/cron.allow
    # Set the correct permissions on /etc/cron.allow
    chmod 600 /etc/cron.allow
    # Create /etc/cron.deny if it does not exist
    if [ ! -f /etc/cron.deny ]; then
        touch /etc/cron.deny
    fi
    # Remove all entries from /etc/cron.deny
    >/etc/cron.deny
    # Set the correct permissions on /etc/cron.deny
    chmod 600 /etc/cron.deny
}

# Call the function to ensure cron is restricted to authorized users
ensure_cron_authorized_users

# 5.1.9 Ensure at is restricted to authorized users
ensure_at_authorized_users() {
    echo "Ensuring at is restricted to authorized users..."
    # Create /etc/at.allow if it does not exist
    if [ ! -f /etc/at.allow ]; then
        touch /etc/at.allow
    fi
    # Add authorized users to /etc/at.allow
    echo "root" >>/etc/at.allow
    # Set the correct permissions on /etc/at.allow
    chmod 600 /etc/at.allow
    # Create /etc/at.deny if it does not exist
    if [ ! -f /etc/at.deny ]; then
        touch /etc/at.deny
    fi
    # Remove all entries from /etc/at.deny
    >/etc/at.deny
    # Set the correct permissions on /etc/at.deny
    chmod 600 /etc/at.deny
}

# Call the function to ensure at is restricted to authorized users
ensure_at_authorized_users

#! Everything from 5.3.10 - 5.3.4 is because copilot went on a really long tangent

# Call the function to ensure permissions on /etc/cron.daily are configured
ensure_cron_daily_permissions

# 5.2.7 Ensure at/cron is restricted to authorized users
ensure_at_cron_authorized_users() {
    echo "Ensuring at/cron is restricted to authorized users..."
    # Create /etc/cron.allow if it does not exist
    if [ ! -f /etc/cron.allow ]; then
        touch /etc/cron.allow
    fi
    # Add authorized users to /etc/cron.allow
    echo "root" >>/etc/cron.allow
    # Set the correct permissions on /etc/cron.allow
    chmod 600 /etc/cron.allow
    # Create /etc/cron.deny if it does not exist
    if [ ! -f /etc/cron.deny ]; then
        touch /etc/cron.deny
    fi
    # Remove all entries from /etc/cron.deny
    >/etc/cron.deny
    # Set the correct permissions on /etc/cron.deny
    chmod 600 /etc/cron.deny
    # Create /etc/at.allow if it does not exist
    if [ ! -f /etc/at.allow ]; then
        touch /etc/at.allow
    fi
    # Add authorized users to /etc/at.allow
    echo "root" >>/etc/at.allow
    # Set the correct permissions on /etc/at.allow
    chmod 600 /etc/at.allow
    # Create /etc/at.deny if it does not exist
    if [ ! -f /etc/at.deny ]; then
        touch /etc/at.deny
    fi
    # Remove all entries from /etc/at.deny
    >/etc/at.deny
    # Set the correct permissions on /etc/at.deny
    chmod 600 /etc/at.deny
}

# Call the function to ensure at/cron is restricted to authorized users
ensure_at_cron_authorized_users

# 5.3.1 Ensure sudo is installed
ensure_sudo_installed() {
    echo "Ensuring sudo is installed..."
    if command -v sudo >/dev/null 2>&1; then
        echo "sudo is already installed."
        return 0
    else
        apt-get install -y sudo
        echo "sudo is now installed."
    fi
}

# Call the function to ensure sudo is installed
ensure_sudo_installed

# 5.3.3 Ensure sudo log file exists
ensure_sudo_log_file_exists() {
    echo "Ensuring sudo log file exists..."
    if [ -f /var/log/sudo.log ]; then
        echo "sudo log file already exists."
        return 0
    else
        touch /var/log/sudo.log
        chmod 640 /var/log/sudo.log
        chown root:adm /var/log/sudo.log
        echo "sudo log file has been created."
    fi
}

# Call the function to ensure sudo log file exists
ensure_sudo_log_file_exists

# 5.3.2 Ensure sudo commands use pty
ensure_sudo_commands_use_pty() {
    echo "Ensuring sudo commands use pty..."
    if grep -q "^Defaults.*requiretty" /etc/sudoers; then
        echo "sudo commands already use pty."
        return 0
    else
        if ! sudo sed -i '/^Defaults.*requiretty/d' /etc/sudoers; then
            echo "Failed to remove requiretty from sudoers file."
            return 1
        fi
        if ! sudo sh -c 'echo "Defaults    requiretty" >> /etc/sudoers'; then
            echo "Failed to add requiretty to sudoers file."
            return 1
        fi
        echo "sudo commands now use pty."
    fi
}

# Call the function to ensure sudo commands use pty
ensure_sudo_commands_use_pty

# 5.3.4 Ensure users must provide password for privilege escalation
ensure_password_for_privilege_escalation() {
    echo "Ensuring users must provide password for privilege escalation..."
    if grep -q "^%sudo.*ALL=(ALL:ALL) ALL" /etc/sudoers; then
        if grep -q "^%sudo.*ALL=(ALL:ALL) ALL.*NOPASSWD" /etc/sudoers; then
            sudo sed -i 's/^%sudo.*ALL=(ALL:ALL) ALL.*NOPASSWD/%sudo ALL=(ALL:ALL) ALL/' /etc/sudoers
            echo "Users must now provide password for privilege escalation."
        else
            echo "Users already must provide password for privilege escalation."
        fi
    else
        echo "%sudo ALL=(ALL:ALL) ALL" >>/etc/sudoers
        echo "Users must now provide password for privilege escalation."
    fi
}

# Call the function to ensure users must provide password for privilege escalation
ensure_password_for_privilege_escalation

# 5.3.5 Ensure re-authentication for privilege escalation is not disabled globally
ensure_reauthentication_for_privilege_escalation() {
    echo "Ensuring re-authentication for privilege escalation is not disabled globally..."
    if grep -q "^Defaults\s+!authenticate" /etc/sudoers; then
        sudo sed -i 's/^Defaults\s+!authenticate/# Defaults !authenticate/' /etc/sudoers
        echo "Re-authentication for privilege escalation is now enabled."
    else
        echo "Re-authentication for privilege escalation is already enabled."
    fi
}

# Call the function to ensure re-authentication for privilege escalation is not disabled globally
ensure_reauthentication_for_privilege_escalation

# 5.3.6 Ensure sudo authentication timeout is configured correctly
ensure_sudo_authentication_timeout() {
    echo "Ensuring sudo authentication timeout is configured correctly..."
    if grep -q "^Defaults\s+timestamp_timeout=300" /etc/sudoers; then
        echo "sudo authentication timeout is already set to 300 seconds."
        return 0
    else
        sudo sed -i 's/^Defaults\s+env_reset$/&\nDefaults\ttimestamp_timeout=300/' /etc/sudoers
        echo "sudo authentication timeout is now set to 300 seconds."
    fi
}

# Call the function to ensure sudo authentication timeout is configured correctly
ensure_sudo_authentication_timeout

# 5.3.7 Ensure access to the su command is restricted
ensure_su_restricted() {
    echo "Ensuring access to the su command is restricted..."
    if grep -q "^auth\s+required\s+pam_wheel.so\s+use_uid$" /etc/pam.d/su; then
        echo "Access to the su command is already restricted."
        return 0
    else
        echo "auth required pam_wheel.so use_uid" >>/etc/pam.d/su
        echo "Access to the su command is now restricted."
    fi
}

# Call the function to ensure access to the su command is restricted
ensure_su_restricted

# 5.4.1 Ensure password creation requirements are configured
ensure_password_creation_requirements() {
    echo "Ensuring password creation requirements are configured..."
    if grep -q "^password\s+requisite\s+pam_pwquality.so" /etc/pam.d/common-password; then
        echo "Password creation requirements are already configured."
        return 0
    else
        password requisite pam_pwquality.so retry=3
        password requisite pam_unix.so sha512 shadow minlen=8
        password required pam_deny.so
        if ! sudo sed -i '/^password\s+requisite\s+pam_pwquality.so/d' /etc/pam.d/common-password; then
            echo "Failed to remove existing password creation requirements from common-password file."
            return 1
        fi
        if ! sudo sh -c 'echo "password requisite pam_pwquality.so retry=3" >> /etc/pam.d/common-password'; then
            echo "Failed to add password creation requirements to common-password file."
            return 1
        fi
        echo "Password creation requirements are now configured."
    fi
}

# Call the function to ensure password creation requirements are configured
ensure_password_creation_requirements

# 5.4.2 Ensure lockout for failed password attempts is configured
ensure_lockout_for_failed_password_attempts() {
    echo "Ensuring lockout for failed password attempts is configured..."
    if ! dpkg -s libpam-modules &>/dev/null; then
        sudo apt-get install -y libpam-modules
    fi
    if grep -q "^auth\s+required\s+pam_tally2.so\s+onerr=fail\s+deny=3\s+unlock_time=1800\s+audit\s+silent$" /etc/pam.d/common-auth; then
        echo "Lockout for failed password attempts is already configured."
        return 0
    else
        if ! sudo sed -i '/^auth\s+required\s+pam_tally2.so/d' /etc/pam.d/common-auth; then
            echo "Failed to remove existing lockout configuration from common-auth file."
            return 1
        fi
        echo "auth required pam_tally2.so onerr=fail deny=3 unlock_time=1800 audit silent" >>/etc/pam.d/common-auth
        echo "Lockout for failed password attempts is now configured."
    fi
}

# Call the function to ensure lockout for failed password attempts is configured
ensure_lockout_for_failed_password_attempts

# 5.4.3 Ensure password reuse is limited
ensure_password_reuse_limited() {
    echo "Ensuring password reuse is limited..."
    if grep -q "^password\s+requisite\s+pam_pwhistory.so" /etc/pam.d/common-password; then
        echo "Password reuse is already limited."
        return 0
    else
        if ! sudo sed -i '/^password\s+requisite\s+pam_unix.so/d' /etc/pam.d/common-password; then
            echo "Failed to remove existing password configuration from common-password file."
            return 1
        fi
        if ! sudo sh -c 'echo "password requisite pam_unix.so sha512 shadow remember=5 minlen=8" >> /etc/pam.d/common-password'; then
            echo "Failed to add password configuration to common-password file."
            return 1
        fi
        echo "Password reuse is now limited."
    fi
}

# Call the function to ensure password reuse is limited
ensure_password_reuse_limited

# 5.4.4 Ensure password hashing algorithm is up to date with the latest standards
ensure_password_hashing_algorithm() {
    echo "Ensuring password hashing algorithm is up to date with the latest standards..."
    if grep -q "^ENCRYPT_METHOD\s+SHA512" /etc/login.defs; then
        echo "Password hashing algorithm is already up to date with the latest standards."
        return 0
    else
        sudo sed -i 's/^ENCRYPT_METHOD\s\+.*/ENCRYPT_METHOD SHA512/' /etc/login.defs
        echo "Password hashing algorithm is now up to date with the latest standards."
    fi
}

# Call the function to ensure password hashing algorithm is up to date with the latest standards
ensure_password_hashing_algorithm

#! Can't get 5.4.5 to work

# 5.5.1.1 Ensure minimum days between password changes is configured
# Function to ensure minimum days between password changes is configured
ensure_minimum_days_between_password_changes_configured() {
    echo "Ensuring minimum days between password changes is configured..."
    # Check if the configuration already exists
    if grep -q "^PASS_MIN_DAYS\s+[0-9]\+$" /etc/login.defs; then
        PASS_MIN_DAYS 7
        echo "Minimum days between password changes is already configured."
        return 0
    else
        # Add the configuration to the login.defs file
        if ! sudo sh -c 'echo "# BEGIN: ed8c6549bwf9" >> /etc/login.defs'; then
            echo "Failed to add configuration to login.defs file."
            return 1
        fi
        if ! sudo sh -c 'echo "PASS_MIN_DAYS   7" >> /etc/login.defs'; then
            echo "Failed to add configuration to login.defs file."
            return 1
        fi
        if ! sudo sh -c 'echo "# END: ed8c6549bwf9" >> /etc/login.defs'; then
            echo "Failed to add configuration to login.defs file."
            return 1
        fi
        echo "Minimum days between password changes is now configured."
    fi
}

# Call the function to ensure minimum days between password changes is configured
ensure_minimum_days_between_password_changes_configured

# 5.5.1.2 Ensure password expiration is 365 days or less
# Function to ensure password expiration is 365 days or less
ensure_password_expiration() {
    echo "Ensuring password expiration is 365 days or less..."
    # Check if the configuration already exists
    if grep -q "^PASS_MAX_DAYS\s+[0-9]\+$" /etc/login.defs; then
        sudo sed -i 's/^PASS_MAX_DAYS\s\+.*/PASS_MAX_DAYS 365/' /etc/login.defs
        echo "Password expiration is now configured."
    else
        # Add the configuration to the login.defs file
        if ! sudo sh -c 'echo "# BEGIN: ed8c6549bwf9" >> /etc/login.defs'; then
            echo "Failed to add configuration to login.defs file."
            return 1
        fi
        if ! sudo sh -c 'echo "PASS_MAX_DAYS   365" >> /etc/login.defs'; then
            echo "Failed to add configuration to login.defs file."
            return 1
        fi
        if ! sudo sh -c 'echo "# END: ed8c6549bwf9" >> /etc/login.defs'; then
            echo "Failed to add configuration to login.defs file."
            return 1
        fi
        echo "Password expiration is now configured."
    fi
}

# Call the function to ensure password expiration is 365 days or less
ensure_password_expiration

# 5.5.1.3 Ensure password expiration warning days is 7 or more
ensure_password_expiration_warning_days_configured() {
    echo "Ensuring password expiration warning days is 7 or more..."
    # Check if the configuration already exists
    if grep -q "^PASS_WARN_AGE\s+[0-9]\+$" /etc/login.defs; then
        sudo sed -i 's/^PASS_WARN_AGE\s\+.*/PASS_WARN_AGE 7/' /etc/login.defs
        echo "Password expiration warning days is now configured."
    else
        # Add the configuration to the login.defs file
        if ! sudo sh -c 'echo "# BEGIN: ed8c6549bwf9" >> /etc/login.defs'; then
            echo "Failed to add configuration to login.defs file."
            return 1
        fi
        if ! sudo sh -c 'echo "PASS_WARN_AGE   7" >> /etc/login.defs'; then
            echo "Failed to add configuration to login.defs file."
            return 1
        fi
        if ! sudo sh -c 'echo "# END: ed8c6549bwf9" >> /etc/login.defs'; then
            echo "Failed to add configuration to login.defs file."
            return 1
        fi
        echo "Password expiration warning days is now configured."
    fi
}

# 5.5.1.4 Ensure inactive password lock is 30 days or less
# Function to ensure inactive password lock is 30 days or less
ensure_inactive_password_lock() {
    echo "Ensuring inactive password lock is 30 days or less..."
    # Check if the configuration already exists
    if grep -q "^INACTIVE\s+[0-9]\+$" /etc/default/useradd; then
        sudo sed -i 's/^INACTIVE\s\+.*/INACTIVE=30/' /etc/default/useradd
        echo "Inactive password lock is now configured."
    else
        # Add the configuration to the useradd file
        if ! sudo sh -c 'echo "# BEGIN: ed8c6549bwf9" >> /etc/default/useradd'; then
            echo "Failed to add configuration to useradd file."
            return 1
        fi
        if ! sudo sh -c 'echo "INACTIVE=30" >> /etc/default/useradd'; then
            echo "Failed to add configuration to useradd file."
            return 1
        fi
        if ! sudo sh -c 'echo "# END: ed8c6549bwf9" >> /etc/default/useradd'; then
            echo "Failed to add configuration to useradd file."
            return 1
        fi
        echo "Inactive password lock is now configured."
    fi
}

# Call the function to ensure inactive password lock is 30 days or less
ensure_inactive_password_lock

# 5.5.1.5 Ensure all users last password change date is in the past
ensure_all_users_last_password_change_date_in_past() {
    echo "Ensuring all users last password change date is in the past..."
    # Loop through all users and check their password expiry information
    for user in $(cut -d: -f1 /etc/passwd); do
        password_expiry_info=$(sudo chage -l $user)
        # Check if the Last password change field is not in the past
        if echo "$password_expiry_info" | grep -q "Last password change.*never"; then
            echo "User $user has never changed their password."
        elif echo "$password_expiry_info" | grep -q "Last password change.*$(date +%m/%d/%Y)"; then
            echo "User $user last changed their password today."
        elif echo "$password_expiry_info" | grep -q "Last password change.*$(date -d yesterday +%m/%d/%Y)"; then
            echo "User $user last changed their password yesterday."
        else
            # Set the last password change date to the current date
            sudo chage -d $(date +%m/%d/%Y) $user
            echo "Last password change date for user $user has been set to today's date."
        fi
    done
}

# Call the function to ensure all users last password change date is in the past
ensure_all_users_last_password_change_date_in_past

# 5.5.2 Ensure system accounts are secured
# Function to ensure system accounts are secured
ensure_system_accounts_secured() {
    echo "Ensuring system accounts are secured..."
    # Run the audit command to check for system accounts that need to be secured
    system_accounts=$(awk -F: '$1!~/(root|sync|shutdown|halt|^\+)/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' && $7!~/((\/usr)?\/sbin\/nologin)/ && $7!~/(\/bin)?\/false/ {print}' /etc/passwd | awk '{print $1}')

    # For each account returned by the audit, set the shell to nologin
    for account in $system_accounts; do
        if ! sudo usermod -s /usr/sbin/nologin $account; then
            echo "Failed to set shell for account $account to nologin."
            return 1
        fi
        echo "Shell for account $account has been set to nologin."
    done

    # For each non-root account returned by the audit, lock the account
    for account in $(awk -F: '($1!~/(root|^\+)/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"') {print $1}' /etc/passwd); do
        if ! sudo passwd -l $account; then
            echo "Failed to lock account $account."
            return 1
        fi
        echo "Account $account has been locked."
    done

    echo "System accounts are now secured."
}

# Call the function to ensure system accounts are secured
ensure_system_accounts_secured

# 5.5.3 Ensure default group for the root account is GID 0
ensure_default_group_for_root() {
    echo "Ensuring default group for the root account is GID 0..."
    # Check if the default group for the root account is GID 0
    if [ "$(grep "^root:" /etc/passwd | cut -f4 -d:)" = "0" ]; then
        echo "Default group for the root account is already GID 0."
    else
        # Set the default group for the root account to GID 0
        if ! sudo usermod -g 0 root; then
            echo "Failed to set default group for the root account to GID 0."
            return 1
        fi
        echo "Default group for the root account is now GID 0."
    fi
}

# Call the function to ensure default group for the root account is GID 0
ensure_default_group_for_root

# 5.5.4 Ensure default user umask is 027 or more restrictive
ensure_default_user_umask() {
    echo "Ensuring default user umask is 027 or more restrictive..."
    # Check if the umask is already set to 027 or more restrictive
    if [ "$(grep "^umask" /etc/bash.bashrc | awk '{print $2}')" = "027" ]; then
        echo "Default user umask is already 027 or more restrictive."
    else
        # Set the umask to 027 or more restrictive
        if ! sudo sh -c 'echo "umask 027" >> /etc/bash.bashrc'; then
            echo "Failed to set default user umask to 027 or more restrictive."
            return 1
        fi
        echo "Default user umask is now 027 or more restrictive."
    fi
}

# Call the function to ensure default user umask is 027 or more restrictive
ensure_default_user_umask

# 5.5.5 Ensure default user shell timeout is 900 seconds or less
ensure_default_user_shell_timeout() {
    echo "Ensuring default user shell timeout is 900 seconds or less..."
    # Check if the TMOUT environment variable is already set to 900 or less
    if [ "$(grep "^TMOUT" /etc/profile | awk -F= '{print $2}')" -le 900 ]; then
        echo "Default user shell timeout is already 900 seconds or less."
    else
        # Set the TMOUT environment variable to 900
        if ! sudo sh -c 'echo "TMOUT=900" >> /etc/profile'; then
            echo "Failed to set default user shell timeout to 900 seconds or less."
            return 1
        fi
        echo "Default user shell timeout is now 900 seconds or less."
    fi
}

# Call the function to ensure default user shell timeout is 900 seconds or less
ensure_default_user_shell_timeout
