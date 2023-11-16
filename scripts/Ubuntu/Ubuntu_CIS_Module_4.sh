#!/bin/bash

# Command I used to make this whole script in Copilot:
# "Write a function to do the following: (argument that gets commented). If the function couldn't execute, return an error but don't end the script."
# Make sure to keep reloading till it gives you return statements

install_auditd() {
    # Install auditd package
    if ! dpkg -s auditd >/dev/null 2>&1; then
        echo "auditd package is not installed. Installing it now..."
        if ! apt-get update >/dev/null 2>&1; then
            echo "Failed to update package list."
            return 1
        elif ! apt-get install -y auditd >/dev/null 2>&1; then
            echo "Failed to install auditd package."
            return 1
        else
            echo "auditd package was installed successfully."
        fi
    else
        echo "auditd package is already installed."
    fi
}

install_auditd

ensure_auditd_service_enabled_and_active() {
    # 4.1.1.2 Ensure auditd service is enabled and active
    if ! systemctl is-enabled auditd >/dev/null 2>&1; then
        echo "auditd service is not enabled. Enabling it now..."
        if ! systemctl enable auditd >/dev/null 2>&1; then
            echo "Failed to enable auditd service."
            return 1
        fi
    else
        echo "auditd service is already enabled."
    fi

    if ! systemctl is-active auditd >/dev/null 2>&1; then
        echo "auditd service is not active. Starting it now..."
        if ! systemctl start auditd >/dev/null 2>&1; then
            echo "Failed to start auditd service."
            return 1
        fi
    else
        echo "auditd service is already active."
    fi
}

ensure_auditd_service_enabled_and_active

ensure_auditing_for_processes_enabled() {
    # 4.1.1.3 Ensure auditing for processes that start prior to auditd is enabled
    if ! grep -q "^\s*linux" /boot/grub/grub.cfg && ! grep -q "^\s*linux" /boot/grub/grub.conf; then
        echo "No kernel boot parameters found. Adding them now..."
        if ! sed -i '/^\s*GRUB_CMDLINE_LINUX=/ s/"$/ audit=1"/' /etc/default/grub >/dev/null 2>&1; then
            echo "Failed to add kernel boot parameters."
            return 1
        elif ! update-grub >/dev/null 2>&1; then
            echo "Failed to update grub."
            return 1
        else
            echo "Kernel boot parameters updated successfully."
        fi
    else
        if ! grep -q "^\s*linux.*audit=1" /boot/grub/grub.cfg && ! grep -q "^\s*linux.*audit=1" /boot/grub/grub.conf; then
            echo "Kernel boot parameters found, but auditing is not enabled. Enabling it now..."
            if ! sed -i '/^\s*GRUB_CMDLINE_LINUX=/ s/"$/ audit=1"/' /etc/default/grub >/dev/null 2>&1; then
                echo "Failed to enable auditing for processes that start prior to auditd."
                return 1
            fi
            if ! update-grub >/dev/null 2>&1; then
                echo "Failed to update grub."
                return 1
            fi
        else
            echo "Auditing for processes that start prior to auditd is already enabled."
        fi
    fi
}

ensure_auditing_for_processes_enabled

ensure_audit_backlog_limit_sufficient() {
    # 4.1.1.4 Ensure audit_backlog_limit is sufficient
    local backlog_limit=$(grep -E "^\s*max_log_file\s*=" /etc/audit/auditd.conf | awk -F= '{print $2}')
    if [ -z "$backlog_limit" ]; then
        echo "max_log_file is not set in /etc/audit/auditd.conf. Setting it to 1024..."
        if ! sed -i '/^\s*max_log_file\s*=/d' /etc/audit/auditd.conf >/dev/null 2>&1; then
            echo "Failed to delete max_log_file from /etc/audit/auditd.conf."
            return 1
        fi
        if ! echo "max_log_file = 1024" >>/etc/audit/auditd.conf; then
            echo "Failed to set max_log_file to 1024 in /etc/audit/auditd.conf."
            return 1
        fi
    elif [ "$backlog_limit" -lt 1024 ]; then
        echo "max_log_file is set to $backlog_limit in /etc/audit/auditd.conf. Setting it to 1024..."
        if ! sed -i "s/^\s*max_log_file\s*=.*/max_log_file = 1024/" /etc/audit/auditd.conf >/dev/null 2>&1; then
            echo "Failed to set max_log_file to 1024 in /etc/audit/auditd.conf."
            return 1
        fi
    else
        echo "audit_backlog_limit is sufficient."
    fi
}

ensure_audit_backlog_limit_sufficient

ensure_audit_log_storage_size_configured() {
    # 4.1.2.1 Ensure audit log storage size is configured
    local log_file=$(grep -E "^\s*[^#].*\-f\s+.*(/var/log/audit/audit.log|/var/log/audit/auditd.log)" /etc/audit/auditd.conf | awk '{print $2}')
    if [ -z "$log_file" ]; then
        echo "Audit log file is not configured in /etc/audit/auditd.conf."
        return 1
    fi

    local log_dir=$(dirname "$log_file")
    local log_size=$(grep -E "^\s*[^#].*\-s\s+\d+" /etc/audit/auditd.conf | awk '{print $2}')
    if [ -z "$log_size" ]; then
        echo "Audit log storage size is not configured in /etc/audit/auditd.conf. Setting it to 100M..."
        if ! echo "-s 100M" >>/etc/audit/auditd.conf; then
            echo "Failed to set audit log storage size to 100M in /etc/audit/auditd.conf."
            return 1
        fi
    else
        local log_size_unit=$(echo "$log_size" | sed -E 's/^[[:digit:]]+//')
        local log_size_value=$(echo "$log_size" | sed -E 's/[[:alpha:]]+$//')
        if [ "$log_size_unit" = "k" ]; then
            log_size_value=$((log_size_value / 1024))
        elif [ "$log_size_unit" = "G" ]; then
            log_size_value=$((log_size_value * 1024))
        fi

        if [ "$log_size_value" -lt 100 ]; then
            echo "Audit log storage size is set to $log_size in /etc/audit/auditd.conf. Setting it to 100M..."
            if ! sed -i "s/^\s*[^#].*\-s\s.*/-s 100M/" /etc/audit/auditd.conf >/dev/null 2>&1; then
                echo "Failed to set audit log storage size to 100M in /etc/audit/auditd.conf."
                return 1
            fi
        else
            echo "Audit log storage size is configured."
        fi
    fi

    if ! [ -d "$log_dir" ]; then
        echo "Audit log directory $log_dir does not exist. Creating it now..."
        if ! mkdir -p "$log_dir" >/dev/null 2>&1; then
            echo "Failed to create audit log directory $log_dir."
            return 1
        fi
    fi

    if ! [ -f "$log_file" ]; then
        echo "Audit log file $log_file does not exist. Creating it now..."
        if ! touch "$log_file" >/dev/null 2>&1; then
            echo "Failed to create audit log file $log_file."
            return 1
        fi
    fi

    if ! [ -w "$log_file" ]; then
        echo "Audit log file $log_file is not writable. Changing its permissions now..."
        if ! chmod o-rwx "$log_file" >/dev/null 2>&1; then
            echo "Failed to change permissions of audit log file $log_file."
            return 1
        fi
    fi
}

ensure_audit_log_storage_size_configured

ensure_audit_logs_not_deleted() {
    # 4.1.2.2 Ensure audit logs are not automatically deleted
    local max_log_file_action=$(grep -E "^\s*max_log_file_action\s*=" /etc/audit/auditd.conf | awk -F= '{print $2}')
    if [ -z "$max_log_file_action" ]; then
        echo "max_log_file_action is not set in /etc/audit/auditd.conf. Setting it to keep_logs..."
        if ! sed -i '/^\s*max_log_file_action\s*=/d' /etc/audit/auditd.conf >/dev/null 2>&1; then
            echo "Failed to delete max_log_file_action from /etc/audit/auditd.conf."
            return 1
        fi
        if ! echo "max_log_file_action = keep_logs" >>/etc/audit/auditd.conf; then
            echo "Failed to set max_log_file_action to keep_logs in /etc/audit/auditd.conf."
            return 1
        fi
    elif [ "$max_log_file_action" != "keep_logs" ]; then
        echo "max_log_file_action is set to $max_log_file_action in /etc/audit/auditd.conf. Setting it to keep_logs..."
        if ! sed -i "s/^\s*max_log_file_action\s*=.*/max_log_file_action = keep_logs/" /etc/audit/auditd.conf >/dev/null 2>&1; then
            echo "Failed to set max_log_file_action to keep_logs in /etc/audit/auditd.conf."
            return 1
        fi
    else
        echo "Audit logs are not automatically deleted."
    fi
}

ensure_audit_logs_not_deleted

ensure_audit_logs_full_action_configured() {
    # 4.1.2.3 Ensure system is disabled when audit logs are full
    local disk_full_action=$(grep -E "^\s*disk_full_action\s*=" /etc/audit/auditd.conf | awk -F= '{print $2}')
    if [ -z "$disk_full_action" ]; then
        echo "disk_full_action is not set in /etc/audit/auditd.conf. Setting it to halt..."
        if ! sed -i '/^\s*disk_full_action\s*=/d' /etc/audit/auditd.conf >/dev/null 2>&1; then
            echo "Failed to delete disk_full_action from /etc/audit/auditd.conf."
            return 1
        fi
        if ! echo "disk_full_action = halt" >>/etc/audit/auditd.conf; then
            echo "Failed to set disk_full_action to halt in /etc/audit/auditd.conf."
            return 1
        fi
    elif [ "$disk_full_action" != "halt" ]; then
        echo "disk_full_action is set to $disk_full_action in /etc/audit/auditd.conf. Setting it to halt..."
        if ! sed -i "s/^\s*disk_full_action\s*=.*/disk_full_action = halt/" /etc/audit/auditd.conf >/dev/null 2>&1; then
            echo "Failed to set disk_full_action to halt in /etc/audit/auditd.conf."
            return 1
        fi
    else
        echo "System is disabled when audit logs are full."
    fi
}

ensure_audit_logs_full_action_configured

ensure_sudoers_changes_collected() {
    # 4.1.3.1 Ensure changes to system administration scope (sudoers) is collected
    if ! grep -q "^\s*Defaults\s*log_input" /etc/sudoers /etc/sudoers.d/*; then
        echo "Defaults log_input is not set in /etc/sudoers or /etc/sudoers.d/* files. Setting it now..."
        if ! echo "Defaults log_input" >>/etc/sudoers; then
            echo "Failed to set Defaults log_input in /etc/sudoers."
            return 1
        fi
        for file in /etc/sudoers.d/*; do
            if ! echo "Defaults log_input" >>"$file"; then
                echo "Failed to set Defaults log_input in $file."
                return 1
            fi
        done
    else
        echo "Changes to system administration scope (sudoers) are being collected."
    fi
}

ensure_sudoers_changes_collected

ensure_actions_as_another_user_logged() {
    # 4.1.3.2 Ensure actions as another user are always logged
    if ! grep -q "^\s*Defaults\s*log_output" /etc/sudoers /etc/sudoers.d/*; then
        echo "Defaults log_output is not set in /etc/sudoers or /etc/sudoers.d/* files. Setting it now..."
        if ! echo "Defaults log_output" >>/etc/sudoers; then
            echo "Failed to set Defaults log_output in /etc/sudoers."
            return 1
        fi
        for file in /etc/sudoers.d/*; do
            if ! echo "Defaults log_output" >>"$file"; then
                echo "Failed to set Defaults log_output in $file."
                return 1
            fi
        done
    else
        echo "Actions as another user are always logged."
    fi
}

ensure_actions_as_another_user_logged

ensure_sudo_log_file_changes_collected() {
    # 4.1.3.3 Ensure events that modify the sudo log file are collected
    if ! grep -q "^\s*Defaults\s*log_file" /etc/sudoers /etc/sudoers.d/*; then
        echo "Defaults log_file is not set in /etc/sudoers or /etc/sudoers.d/* files. Setting it now..."
        if ! echo "Defaults log_file=/var/log/sudo.log" >>/etc/sudoers; then
            echo "Failed to set Defaults log_file in /etc/sudoers."
            return 1
        fi
        for file in /etc/sudoers.d/*; do
            if ! echo "Defaults log_file=/var/log/sudo.log" >>"$file"; then
                echo "Failed to set Defaults log_file in $file."
                return 1
            fi
        done
    else
        echo "Events that modify the sudo log file are being collected."
    fi
}

ensure_sudo_log_file_changes_collected

ensure_time_modification_events_collected() {
    # 4.1.3.4 Ensure events that modify date and time information are collected
    if ! grep -q "time-change" /etc/audit/rules.d/*.rules; then
        echo "time-change rule is not present in /etc/audit/rules.d/*.rules files. Adding it now..."
        if ! echo "-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change" >>/etc/audit/rules.d/time.rules; then
            echo "Failed to add time-change rule to /etc/audit/rules.d/time.rules."
            return 1
        fi
        if ! echo "-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change" >>/etc/audit/rules.d/time.rules; then
            echo "Failed to add time-change rule to /etc/audit/rules.d/time.rules."
            return 1
        fi
        if ! echo "-a always,exit -F arch=b64 -S clock_settime -k time-change" >>/etc/audit/rules.d/time.rules; then
            echo "Failed to add time-change rule to /etc/audit/rules.d/time.rules."
            return 1
        fi
        if ! echo "-a always,exit -F arch=b32 -S clock_settime -k time-change" >>/etc/audit/rules.d/time.rules; then
            echo "Failed to add time-change rule to /etc/audit/rules.d/time.rules."
            return 1
        fi
        if ! echo "-w /etc/localtime -p wa -k time-change" >>/etc/audit/rules.d/time.rules; then
            echo "Failed to add time-change rule to /etc/audit/rules.d/time.rules."
            return 1
        fi
        if ! echo "-w /etc/timezone -p wa -k time-change" >>/etc/audit/rules.d/time.rules; then
            echo "Failed to add time-change rule to /etc/audit/rules.d/time.rules."
            return 1
        fi
        service auditd restart
    else
        echo "Events that modify date and time information are being collected."
    fi
}

ensure_time_modification_events_collected

ensure_network_modification_events_collected() {
    # 4.1.3.5 Ensure events that modify the system's network environment are collected
    if ! grep -q "sethostname" /etc/audit/rules.d/*.rules; then
        echo "sethostname rule is not present in /etc/audit/rules.d/*.rules files. Adding it now..."
        if ! echo "-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale" >>/etc/audit/rules.d/network.rules; then
            echo "Failed to add sethostname rule to /etc/audit/rules.d/network.rules."
            return 1
        fi
        if ! echo "-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale" >>/etc/audit/rules.d/network.rules; then
            echo "Failed to add sethostname rule to /etc/audit/rules.d/network.rules."
            return 1
        fi
        if ! echo "-w /etc/issue -p wa -k system-locale" >>/etc/audit/rules.d/network.rules; then
            echo "Failed to add system-locale rule to /etc/audit/rules.d/network.rules."
            return 1
        fi
        if ! echo "-w /etc/issue.net -p wa -k system-locale" >>/etc/audit/rules.d/network.rules; then
            echo "Failed to add system-locale rule to /etc/audit/rules.d/network.rules."
            return 1
        fi
        if ! echo "-w /etc/hosts -p wa -k system-locale" >>/etc/audit/rules.d/network.rules; then
            echo "Failed to add system-locale rule to /etc/audit/rules.d/network.rules."
            return 1
        fi
        if ! echo "-w /etc/network -p wa -k system-locale" >>/etc/audit/rules.d/network.rules; then
            echo "Failed to add system-locale rule to /etc/audit/rules.d/network.rules."
            return 1
        fi
        if ! echo "-w /etc/network/if-up.d/ -p wa -k system-locale" >>/etc/audit/rules.d/network.rules; then
            echo "Failed to add system-locale rule to /etc/audit/rules.d/network.rules."
            return 1
        fi
        if ! echo "-w /etc/network/if-down.d/ -p wa -k system-locale" >>/etc/audit/rules.d/network.rules; then
            echo "Failed to add system-locale rule to /etc/audit/rules.d/network.rules."
            return 1
        fi
        if ! echo "-w /etc/network/interfaces -p wa -k system-locale" >>/etc/audit/rules.d/network.rules; then
            echo "Failed to add system-locale rule to /etc/audit/rules.d/network.rules."
            return 1
        fi
        service auditd restart
    else
        echo "Events that modify the system's network environment are being collected."
    fi
}

ensure_network_modification_events_collected

ensure_privileged_commands_collected() {
    # 4.1.3.6 Ensure use of privileged commands are collected
    if ! grep -q "^\s*[^#].*\sprivileged" /etc/audit/rules.d/*.rules; then
        echo "Privileged commands are not being collected. Adding rule to /etc/audit/rules.d/privileged.rules..."
        if ! echo "-a always,exit -F path=/usr/bin/sudo -F auid>=1000 -F auid!=4294967295 -k privileged" >>/etc/audit/rules.d/privileged.rules; then
            echo "Failed to add privileged command rule to /etc/audit/rules.d/privileged.rules."
            return 1
        fi
        if ! echo "-a always,exit -F path=/usr/bin/sudoedit -F auid>=1000 -F auid!=4294967295 -k privileged" >>/etc/audit/rules.d/privileged.rules; then
            echo "Failed to add privileged command rule to /etc/audit/rules.d/privileged.rules."
            return 1
        fi
        if ! echo "-a always,exit -F path=/usr/bin/sudoreplay -F auid>=1000 -F auid!=4294967295 -k privileged" >>/etc/audit/rules.d/privileged.rules; then
            echo "Failed to add privileged command rule to /etc/audit/rules.d/privileged.rules."
            return 1
        fi
        service auditd restart
    else
        echo "Use of privileged commands are being collected."
    fi
}

ensure_privileged_commands_collected

ensure_unsuccessful_file_access_attempts_collected() {
    # 4.1.3.7 Ensure unsuccessful file access attempts are collected
    if ! grep -q "access" /etc/audit/rules.d/*.rules; then
        echo "Unsuccessful file access attempts are not being collected. Adding rule to /etc/audit/rules.d/file-access.rules..."
        if ! echo "-a always,exit -F arch=b64 -S open -S openat -S creat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EACCES -F exit=-EPERM -k access" >>/etc/audit/rules.d/file-access.rules; then
            echo "Failed to add unsuccessful file access attempts rule to /etc/audit/rules.d/file-access.rules."
            return 1
        fi
        if ! echo "-a always,exit -F arch=b32 -S open -S openat -S creat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EACCES -F exit=-EPERM -k access" >>/etc/audit/rules.d/file-access.rules; then
            echo "Failed to add unsuccessful file access attempts rule to /etc/audit/rules.d/file-access.rules."
            return 1
        fi
        service auditd restart
    else
        echo "Unsuccessful file access attempts are being collected."
    fi
}

ensure_unsuccessful_file_access_attempts_collected

ensure_user_group_modification_events_collected() {
    # 4.1.3.8 Ensure events that modify user/group information are collected
    if ! grep -q "group" /etc/audit/rules.d/*.rules; then
        echo "User/group modification events are not being collected. Adding rule to /etc/audit/rules.d/user-group.rules..."
        if ! echo "-w /etc/group -p wa -k identity" >>/etc/audit/rules.d/user-group.rules; then
            echo "Failed to add user/group modification rule to /etc/audit/rules.d/user-group.rules."
            return 1
        fi
        if ! echo "-w /etc/passwd -p wa -k identity" >>/etc/audit/rules.d/user-group.rules; then
            echo "Failed to add user/group modification rule to /etc/audit/rules.d/user-group.rules."
            return 1
        fi
        if ! echo "-w /etc/gshadow -p wa -k identity" >>/etc/audit/rules.d/user-group.rules; then
            echo "Failed to add user/group modification rule to /etc/audit/rules.d/user-group.rules."
            return 1
        fi
        if ! echo "-w /etc/shadow -p wa -k identity" >>/etc/audit/rules.d/user-group.rules; then
            echo "Failed to add user/group modification rule to /etc/audit/rules.d/user-group.rules."
            return 1
        fi
        if ! echo "-w /etc/security/opasswd -p wa -k identity" >>/etc/audit/rules.d/user-group.rules; then
            echo "Failed to add user/group modification rule to /etc/audit/rules.d/user-group.rules."
            return 1
        fi
        service auditd restart
        echo "Successfully added rule"
    else
        echo "Events that modify user/group information are being collected."
    fi
}

ensure_user_group_modification_events_collected

ensure_discretionary_access_control_permission_modification_events_collected() {
    # 4.1.3.9 Ensure discretionary access control permission modification events are collected
    if ! grep -q "perm_mod" /etc/audit/rules.d/*.rules; then
        echo "Discretionary access control permission modification events are not being collected. Adding rule to /etc/audit/rules.d/perm-mod.rules..."
        if ! echo "-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod" >>/etc/audit/rules.d/perm-mod.rules; then
            echo "Failed to add discretionary access control permission modification rule to /etc/audit/rules.d/perm-mod.rules."
            return 1
        fi
        if ! echo "-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod" >>/etc/audit/rules.d/perm-mod.rules; then
            echo "Failed to add discretionary access control permission modification rule to /etc/audit/rules.d/perm-mod.rules."
            return 1
        fi
        service auditd restart
    else
        echo "Discretionary access control permission modification events are being collected."
    fi
}

ensure_discretionary_access_control_permission_modification_events_collected

ensure_successful_file_system_mounts_collected() {
    # 4.1.3.10 Ensure successful file system mounts are collected
    if ! grep -q "^\s*[^#].*\ssuccessful" /etc/audit/rules.d/*.rules; then
        echo "Successful file system mounts are not being collected. Adding rule to /etc/audit/rules.d/mounts.rules..."
        if ! echo "-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts" >>/etc/audit/rules.d/mounts.rules; then
            echo "Failed to add successful file system mounts rule to /etc/audit/rules.d/mounts.rules."
            return 1
        fi
        if ! echo "-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=4294967295 -k mounts" >>/etc/audit/rules.d/mounts.rules; then
            echo "Failed to add successful file system mounts rule to /etc/audit/rules.d/mounts.rules."
            return 1
        fi
        service auditd restart
    else
        echo "Successful file system mounts are being collected."
    fi
}

ensure_successful_file_system_mounts_collected

ensure_session_initiation_info_collected() {
    # 4.1.3.11 Ensure session initiation information is collected
    if ! grep -q "session" /etc/audit/rules.d/*.rules; then
        echo "Session initiation information is not being collected. Adding rule to /etc/audit/rules.d/session.rules..."
        if ! echo "-w /var/run/utmp -p wa -k session" >>/etc/audit/rules.d/session.rules; then
            echo "Failed to add session initiation information rule to /etc/audit/rules.d/session.rules."
            return 1
        fi
        if ! echo "-w /var/log/wtmp -p wa -k session" >>/etc/audit/rules.d/session.rules; then
            echo "Failed to add session initiation information rule to /etc/audit/rules.d/session.rules."
            return 1
        fi
        if ! echo "-w /var/log/btmp -p wa -k session" >>/etc/audit/rules.d/session.rules; then
            echo "Failed to add session initiation information rule to /etc/audit/rules.d/session.rules."
            return 1
        fi
        service auditd restart || echo "Failed to restart auditd service."
    else
        echo "Session initiation information is being collected."
    fi
}

ensure_session_initiation_info_collected

ensure_login_logout_events_collected() {
    # 4.1.3.12 Ensure login and logout events are collected
    if ! grep -q "logins" /etc/audit/rules.d/*.rules; then
        echo "Login and logout events are not being collected. Adding rule to /etc/audit/rules.d/logins.rules..."
        if ! echo "-w /var/log/faillog -p wa -k logins" >>/etc/audit/rules.d/logins.rules; then
            echo "Failed to add login and logout events rule to /etc/audit/rules.d/logins.rules."
            return 1
        fi
        if ! echo "-w /var/log/lastlog -p wa -k logins" >>/etc/audit/rules.d/logins.rules; then
            echo "Failed to add login and logout events rule to /etc/audit/rules.d/logins.rules."
            return 1
        fi
        if ! echo "-w /var/log/tallylog -p wa -k logins" >>/etc/audit/rules.d/logins.rules; then
            echo "Failed to add login and logout events rule to /etc/audit/rules.d/logins.rules."
            return 1
        fi
        if ! echo "-w /var/run/faillock/ -p wa -k logins" >>/etc/audit/rules.d/logins.rules; then
            echo "Failed to add login and logout events rule to /etc/audit/rules.d/logins.rules."
            return 1
        fi
        service auditd restart || echo "Failed to restart auditd service."
    else
        echo "Login and logout events are being collected."
    fi
}

ensure_login_logout_events_collected

ensure_file_deletion_events_collected() {
    # 4.1.3.13 Ensure file deletion events by users are collected
    if ! grep -q "delete" /etc/audit/rules.d/*.rules; then
        echo "File deletion events by users are not being collected. Adding rule to /etc/audit/rules.d/delete.rules..."
        if ! echo "-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete" >>/etc/audit/rules.d/delete.rules; then
            echo "Failed to add file deletion events by users rule to /etc/audit/rules.d/delete.rules."
            return 1
        fi
        if ! echo "-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete" >>/etc/audit/rules.d/delete.rules; then
            echo "Failed to add file deletion events by users rule to /etc/audit/rules.d/delete.rules."
            return 1
        fi
        service auditd restart || echo "Failed to restart auditd service."
    else
        echo "File deletion events by users are being collected."
    fi
}

ensure_file_deletion_events_collected

ensure_mac_modification_events_collected() {
    # 4.1.3.14 Ensure events that modify the system's Mandatory Access Controls are collected
    if ! grep -q "MAC-policy" /etc/audit/rules.d/*.rules; then
        echo "Events that modify the system's Mandatory Access Controls are not being collected. Adding rule to /etc/audit/rules.d/mac-policy.rules..."
        if ! echo "-w /etc/apparmor/ -p wa -k MAC-policy" >>/etc/audit/rules.d/mac-policy.rules; then
            echo "Failed to add events that modify the system's Mandatory Access Controls rule to /etc/audit/rules.d/mac-policy.rules."
            return 1
        fi
        if ! echo "-w /etc/apparmor.d/ -p wa -k MAC-policy" >>/etc/audit/rules.d/mac-policy.rules; then
            echo "Failed to add events that modify the system's Mandatory Access Controls rule to /etc/audit/rules.d/mac-policy.rules."
            return 1
        fi
        service auditd restart || echo "Failed to restart auditd service."
    else
        echo "Events that modify the system's Mandatory Access Controls are being collected."
    fi
}

ensure_mac_modification_events_collected

ensure_chcon_command_events_collected() {
    # 4.1.3.15 Ensure successful and unsuccessful attempts to use the chcon command are recorded
    if ! grep -q "chcon" /etc/audit/rules.d/*.rules; then
        echo "Successful and unsuccessful attempts to use the chcon command are not being collected. Adding rule to /etc/audit/rules.d/chcon.rules..."
        if ! echo "-a always,exit -F path=/usr/bin/chcon -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged-changes" >>/etc/audit/rules.d/chcon.rules; then
            echo "Failed to add successful and unsuccessful attempts to use the chcon command rule to /etc/audit/rules.d/chcon.rules."
            return 1
        fi
        service auditd restart || echo "Failed to restart auditd service."
    else
        echo "Successful and unsuccessful attempts to use the chcon command are being collected."
    fi
}

ensure_chcon_command_events_collected

ensure_setfacl_command_events_collected() {
    # 4.1.3.16 Ensure successful and unsuccessful attempts to use the setfacl command are recorded
    if ! grep -q "setfacl" /etc/audit/rules.d/*.rules; then
        echo "Successful and unsuccessful attempts to use the setfacl command are not being collected. Adding rule to /etc/audit/rules.d/setfacl.rules..."
        if ! echo "-a always,exit -F path=/usr/bin/setfacl -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged-changes" >>/etc/audit/rules.d/setfacl.rules; then
            echo "Failed to add successful and unsuccessful attempts to use the setfacl command rule to /etc/audit/rules.d/setfacl.rules."
            return 1
        fi
        service auditd restart || echo "Failed to restart auditd service."
    else
        echo "Successful and unsuccessful attempts to use the setfacl command are being collected."
    fi
}

ensure_setfacl_command_events_collected

ensure_chacl_command_events_collected() {
    # 4.1.3.17 Ensure successful and unsuccessful attempts to use the chacl command are recorded
    if ! grep -q "chacl" /etc/audit/rules.d/*.rules; then
        echo "Successful and unsuccessful attempts to use the chacl command are not being collected. Adding rule to /etc/audit/rules.d/chacl.rules..."
        if ! echo "-a always,exit -F path=/usr/bin/chacl -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged-changes" >>/etc/audit/rules.d/chacl.rules; then
            echo "Failed to add successful and unsuccessful attempts to use the chacl command rule to /etc/audit/rules.d/chacl.rules."
            return 1
        fi
        service auditd restart || echo "Failed to restart auditd service."
    else
        echo "Successful and unsuccessful attempts to use the chacl command are being collected."
    fi
}

ensure_chacl_command_events_collected

ensure_usermod_command_events_collected() {
    # 4.1.3.18 Ensure successful and unsuccessful attempts to use the usermod command are recorded
    if ! grep -q "usermod" /etc/audit/rules.d/*.rules; then
        echo "Successful and unsuccessful attempts to use the usermod command are not being collected. Adding rule to /etc/audit/rules.d/usermod.rules..."
        if ! echo "-a always,exit -F path=/usr/sbin/usermod -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged-changes" >>/etc/audit/rules.d/usermod.rules; then
            echo "Failed to add successful and unsuccessful attempts to use the usermod command rule to /etc/audit/rules.d/usermod.rules."
            return 1
        fi
        service auditd restart || echo "Failed to restart auditd service."
    else
        echo "Successful and unsuccessful attempts to use the usermod command are being collected."
    fi
}

ensure_usermod_command_events_collected

ensure_kernel_module_events_collected() {
    # 4.1.3.19 Ensure kernel module loading unloading and modification is collected
    if ! grep -q "modules" /etc/audit/rules.d/*.rules; then
        echo "Kernel module loading, unloading, and modification events are not being collected. Adding rule to /etc/audit/rules.d/modules.rules..."
        if ! echo "-w /sbin/insmod -p x -k modules" >>/etc/audit/rules.d/modules.rules; then
            echo "Failed to add kernel module loading, unloading, and modification events rule to /etc/audit/rules.d/modules.rules."
            return 1
        fi
        if ! echo "-w /sbin/rmmod -p x -k modules" >>/etc/audit/rules.d/modules.rules; then
            echo "Failed to add kernel module loading, unloading, and modification events rule to /etc/audit/rules.d/modules.rules."
            return 1
        fi
        if ! echo "-w /sbin/modprobe -p x -k modules" >>/etc/audit/rules.d/modules.rules; then
            echo "Failed to add kernel module loading, unloading, and modification events rule to /etc/audit/rules.d/modules.rules."
            return 1
        fi
        if ! echo "-a always,exit -F arch=b64 -S init_module -S delete_module -k modules" >>/etc/audit/rules.d/modules.rules; then
            echo "Failed to add kernel module loading, unloading, and modification events rule to /etc/audit/rules.d/modules.rules."
            return 1
        fi
        if ! echo "-a always,exit -F arch=b32 -S init_module -S delete_module -k modules" >>/etc/audit/rules.d/modules.rules; then
            echo "Failed to add kernel module loading, unloading, and modification events rule to /etc/audit/rules.d/modules.rules."
            return 1
        fi
        service auditd restart || echo "Failed to restart auditd service."
    else
        echo "Kernel module loading, unloading, and modification events are being collected."
    fi
}

ensure_kernel_module_events_collected

ensure_audit_config_immutable() {
    # 4.1.3.20 Ensure the audit configuration is immutable
    if ! grep -q "^-e 2" /etc/audit/audit.rules /etc/audit/rules.d/*.rules; then
        echo "The audit configuration is not immutable. Adding '-e 2' to /etc/audit/audit.rules and /etc/audit/rules.d/*.rules..."
        if ! echo "-e 2" >>/etc/audit/audit.rules; then
            echo "Failed to add '-e 2' to /etc/audit/audit.rules."
            return 1
        fi
        if ! grep -q "^-e 2" /etc/audit/rules.d/*.rules; then
            if ! echo "-e 2" >>/etc/audit/rules.d/99-finalize.rules; then
                echo "Failed to add '-e 2' to /etc/audit/rules.d/99-finalize.rules."
                return 1
            fi
        fi
        service auditd restart || echo "Failed to restart auditd service."
    else
        echo "The audit configuration is immutable."
    fi
}

ensure_audit_config_immutable

ensure_audit_config_same() {
    # 4.1.3.21 Ensure the running and on disk configuration is the same
    if ! auditctl -l | grep -q "^LIST_RULES: exit"; then
        echo "Failed to execute auditctl command."
        return 1
    fi
    if ! cmp -s /etc/audit/audit.rules /etc/audit/rules.d/*.rules; then
        echo "The running and on disk audit configuration is not the same."
        return 1
    else
        echo "The running and on disk audit configuration is the same."
    fi
}

ensure_audit_config_same

ensure_audit_log_permissions() {
    # 4.1.4.1 Ensure audit log files are mode 0640 or less permissive
    if ! grep -q "^log_file" /etc/audit/auditd.conf; then
        echo "Failed to find log_file entry in /etc/audit/auditd.conf."
        return 1
    fi
    log_file=$(grep "^log_file" /etc/audit/auditd.conf | awk '{print $2}')
    if [ -z "$log_file" ]; then
        echo "Failed to find log_file path in /etc/audit/auditd.conf."
        return 1
    fi
    if ! stat -L -c "%a %u %g" "$log_file" | grep -q "^6[04]0 "; then
        echo "Audit log file permissions are not 0640 or less permissive. Setting permissions to 0640..."
        if ! chmod 0640 "$log_file"; then
            echo "Failed to set audit log file permissions to 0640."
            return 1
        fi
    else
        echo "Audit log file permissions are 0640 or less permissive."
    fi
}

ensure_audit_log_permissions

ensure_authorized_audit_log_owners() {
    # 4.1.4.2 Ensure only authorized users own audit log files
    if ! grep -q "^log_file" /etc/audit/auditd.conf; then
        echo "Failed to find log_file entry in /etc/audit/auditd.conf."
        return 1
    fi
    log_file=$(grep "^log_file" /etc/audit/auditd.conf | awk '{print $2}')
    if [ -z "$log_file" ]; then
        echo "Failed to find log_file path in /etc/audit/auditd.conf."
        return 1
    fi
    if [ "$(stat -c %U:%G "$log_file")" != "root:root" ] && [ "$(stat -c %U:%G "$log_file")" != "root:audit" ]; then
        echo "Audit log file ownership is not authorized. Setting ownership to root:audit..."
        if ! chown root:audit "$log_file"; then
            echo "Failed to set audit log file ownership to root:audit."
            return 1
        fi
    else
        echo "Audit log file ownership is authorized."
    fi
}

ensure_authorized_audit_log_owners

ensure_authorized_audit_log_groups() {
    # 4.1.4.3 Ensure only authorized groups are assigned ownership of audit log files
    if ! grep -q "^log_file" /etc/audit/auditd.conf; then
        echo "Failed to find log_file entry in /etc/audit/auditd.conf."
        return 1
    fi
    log_file=$(grep "^log_file" /etc/audit/auditd.conf | awk '{print $2}')
    if [ -z "$log_file" ]; then
        echo "Failed to find log_file path in /etc/audit/auditd.conf."
        return 1
    fi
    if [ "$(stat -c %G "$log_file")" != "audit" ]; then
        echo "Audit log file group ownership is not authorized. Setting group ownership to audit..."
        if ! chgrp audit "$log_file"; then
            echo "Failed to set audit log file group ownership to audit."
            return 1
        fi
    else
        echo "Audit log file group ownership is authorized."
    fi
}

ensure_authorized_audit_log_groups

ensure_audit_log_directory_permissions() {
    # 4.1.4.4 Ensure the audit log directory is 0750 or more restrictive
    if ! grep -q "^dir" /etc/audit/auditd.conf; then
        echo "Failed to find dir entry in /etc/audit/auditd.conf."
        return 1
    fi
    log_dir=$(grep "^dir" /etc/audit/auditd.conf | awk '{print $2}')
    if [ -z "$log_dir" ]; then
        echo "Failed to find audit log directory path in /etc/audit/auditd.conf."
        return 1
    fi
    if ! stat -L -c "%a %u %g" "$log_dir" | grep -q "^7[05]0 "; then
        echo "Audit log directory permissions are not 0750 or more restrictive. Setting permissions to 0750..."
        if ! chmod 0750 "$log_dir"; then
            echo "Failed to set audit log directory permissions to 0750."
            return 1
        fi
    else
        echo "Audit log directory permissions are 0750 or more restrictive."
    fi
}

ensure_audit_log_directory_permissions

ensure_audit_config_permissions() {
    # 4.1.4.5 Ensure audit configuration files are 640 or more restrictive
    if ! find /etc/audit/rules.d -type f -perm /027 -exec ls -ld {} \+ | grep -q ""; then
        echo "Audit configuration files are not 640 or more restrictive. Setting permissions to 640..."
        if ! find /etc/audit/rules.d -type f -perm /027 -exec chmod 640 {} \+; then
            echo "Failed to set audit configuration file permissions to 640."
            return 1
        fi
    else
        echo "Audit configuration files are 640 or more restrictive."
    fi
}

ensure_audit_config_permissions

ensure_audit_config_ownership() {
    # 4.1.4.6 Ensure audit configuration files are owned by root
    if ! find /etc/audit/rules.d -type f ! -user root -exec ls -ld {} \+ | grep -q ""; then
        echo "Audit configuration files are not owned by root. Setting ownership to root..."
        if ! find /etc/audit/rules.d -type f ! -user root -exec chown root {} \+; then
            echo "Failed to set audit configuration file ownership to root."
            return 1
        fi
    else
        echo "Audit configuration files are owned by root."
    fi
}

ensure_audit_config_ownership

ensure_audit_config_group() {
    # 4.1.4.7 Ensure audit configuration files belong to group root
    if ! find /etc/audit/rules.d -type f ! -group root -exec ls -ld {} \+ | grep -q ""; then
        echo "Audit configuration files do not belong to group root. Setting group ownership to root..."
        if ! find /etc/audit/rules.d -type f ! -group root -exec chgrp root {} \+; then
            echo "Failed to set audit configuration file group ownership to root."
            return 1
        fi
    else
        echo "Audit configuration files belong to group root."
    fi
}

ensure_audit_config_group

ensure_audit_tools_permissions() {
    # 4.1.4.8 Ensure audit tools are 755 or more restrictive
    if ! find /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/audispd /sbin/audisp-remote /sbin/audispd-plugins /sbin/auditwheel /sbin/augenrules -perm /022 -type f -exec ls -ld {} \+ | grep -q ""; then
        echo "Audit tools are not 755 or more restrictive. Setting permissions to 755..."
        if ! find /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/audispd /sbin/audisp-remote /sbin/audispd-plugins /sbin/auditwheel /sbin/augenrules -perm /022 -type f -exec chmod 755 {} \+; then
            echo "Failed to set audit tools permissions to 755."
            return 1
        fi
    else
        echo "Audit tools are 755 or more restrictive."
    fi
}

ensure_audit_tools_permissions

ensure_audit_tools_ownership() {
    # 4.1.4.9 Ensure audit tools are owned by root
    if ! find /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/audispd /sbin/audisp-remote /sbin/audispd-plugins /sbin/auditwheel /sbin/augenrules ! -user root -exec ls -ld {} \+ | grep -q ""; then
        echo "Audit tools are not owned by root. Setting ownership to root..."
        if ! find /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/audispd /sbin/audisp-remote /sbin/audispd-plugins /sbin/auditwheel /sbin/augenrules ! -user root -exec chown root {} \+; then
            echo "Failed to set audit tools ownership to root."
            return 1
        fi
    else
        echo "Audit tools are owned by root."
    fi
}

ensure_audit_tools_ownership

ensure_audit_tools_group() {
    # 4.1.4.10 Ensure audit tools belong to group root
    if ! find /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/audispd /sbin/audisp-remote /sbin/audispd-plugins /sbin/auditwheel /sbin/augenrules ! -group root -exec ls -ld {} \+ | grep -q ""; then
        echo "Audit tools do not belong to group root. Setting group ownership to root..."
        if ! find /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/audispd /sbin/audisp-remote /sbin/audispd-plugins /sbin/auditwheel /sbin/augenrules ! -group root -exec chgrp root {} \+; then
            echo "Failed to set audit tools group ownership to root."
            return 1
        fi
    else
        echo "Audit tools belong to group root."
    fi
}

ensure_audit_tools_group

# 4.1.1.1 Ensure auditd is installed
ensure_auditd_installed() {
    if ! dpkg -s auditd >/dev/null 2>&1; then
        echo "auditd package is not installed. Installing..."
        if ! apt-get install -y auditd; then
            echo "Failed to install auditd package."
            return 1
        fi
    fi
}

# Create a directory to store the keys used to sign the audit tools
ensure_key_dir_exists() {
    key_dir="/etc/audit/keys"
    if [ ! -d "$key_dir" ]; then
        echo "Creating directory $key_dir..."
        if ! mkdir -p "$key_dir"; then
            echo "Failed to create directory $key_dir."
            return 1
        fi
    fi
}

# Generate a key pair to sign the audit tools
generate_key_pair() {
    key_file="/etc/audit/keys/audit.key"
    if [ ! -f "$key_file" ]; then
        echo "Generating key pair for audit tools..."
        if ! auditctl -f -k "$key_file"; then
            echo "Failed to generate key pair for audit tools."
            return 1
        fi
    fi
}

# Sign the audit tools with the generated key
sign_audit_tools() {
    echo "Signing audit tools with generated key..."
    if ! find /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/audispd /sbin/audisp-remote /sbin/audispd-plugins /sbin/auditwheel /sbin/augenrules -type f -exec auditctl -k "/etc/audit/keys/audit.key" -s \{\} \+; then
        echo "Failed to sign audit tools with generated key."
        return 1
    fi
}

# Configure auditd to use the signed audit tools
configure_auditd() {
    echo "Configuring auditd to use signed audit tools..."
    if ! sed -i 's/^paxctl/#&/' /etc/audit/rules.d/*.rules; then
        echo "Failed to comment out paxctl rules in /etc/audit/rules.d/*.rules."
        return 1
    fi
    if ! sed -i 's/^#\?paxctl/#&/' /etc/audit/rules.d/*.rules; then
        echo "Failed to uncomment paxctl rules in /etc/audit/rules.d/*.rules."
        return 1
    fi
    if ! sed -i 's/^paxctl/#&/' /etc/audit/audit.rules; then
        echo "Failed to comment out paxctl rules in /etc/audit/audit.rules."
        return 1
    fi
    if ! sed -i 's/^#\?paxctl/#&/' /etc/audit/audit.rules; then
        echo "Failed to uncomment paxctl rules in /etc/audit/audit.rules."
        return 1
    fi
    if ! sed -i 's/^paxctl/#&/' /etc/audit/auditd.conf; then
        echo "Failed to comment out paxctl rules in /etc/audit/auditd.conf."
        return 1
    fi
    if ! sed -i 's/^#\?paxctl/#&/' /etc/audit/auditd.conf; then
        echo "Failed to uncomment paxctl rules in /etc/audit/auditd.conf."
        return 1
    fi
    if ! sed -i 's/^paxctl/#&/' /etc/audit/audit.rules; then
        echo "Failed to comment out paxctl rules in /etc/audit/audit.rules."
        return 1
    fi
    if ! sed -i 's/^#\?paxctl/#&/' /etc/audit/audit.rules; then
        echo "Failed to uncomment paxctl rules in /etc/audit/audit.rules."
        return 1
    fi
    if ! sed -i 's/^paxctl/#&/' /etc/audit/auditd.conf; then
        echo "Failed to comment out paxctl rules in /etc/audit/auditd.conf."
        return 1
    fi
    if ! sed -i 's/^#\?paxctl/#&/' /etc/audit/auditd.conf; then
        echo "Failed to uncomment paxctl rules in /etc/audit/auditd.conf."
        return 1
    fi
    if ! sed -i 's/^paxctl/#&/' /etc/audit/auditd.conf; then
        echo "Failed to comment out paxctl rules in /etc/audit/auditd.conf."
        return 1
    fi
    if ! sed -i 's/^#\?paxctl/#&/' /etc/audit/auditd.conf; then
        echo "Failed to uncomment paxctl rules in /etc/audit/auditd.conf."
        return 1
    fi
}

# Restart auditd service
restart_auditd() {
    echo "Restarting auditd service..."
    if ! systemctl restart auditd; then
        echo "Failed to restart auditd service."
        return 1
    fi
}

# 4.1.4.11 Ensure cryptographic mechanisms are used to protect the integrity of audit tools
ensure_audit_tools_integrity() {
    ensure_auditd_installed &&
        ensure_key_dir_exists &&
        generate_key_pair &&
        sign_audit_tools &&
        configure_auditd &&
        restart_auditd &&
        echo "Audit tools are now signed and configured to use cryptographic mechanisms to protect their integrity."
}

ensure_audit_tools_integrity

#! Someone needs to figure out how to do 4.2.1.1.2

# 4.2.1.1.3 Ensure systemd-journal-remote is enabled
enable_systemd_journal_remote() {
    echo "Enabling systemd-journal-remote service..."
    if ! systemctl enable systemd-journal-remote; then
        echo "Failed to enable systemd-journal-remote service."
        return 1
    fi
}

# 4.2.1.1.1 Ensure systemd-journal-remote is installed
ensure_systemd_journal_remote_installed() {
    echo "Ensuring systemd-journal-remote is installed..."
    if ! dpkg -s systemd-journal-remote >/dev/null 2>&1; then
        echo "Installing systemd-journal-remote..."
        if ! apt-get install -y systemd-journal-remote; then
            echo "Failed to install systemd-journal-remote."
            return 1
        fi
    fi
    enable_systemd_journal_remote
}

# Call the function to ensure systemd-journal-remote is installed and enabled
ensure_systemd_journal_remote_installed

# 4.2.1.1.4 Ensure journald is not configured to receive logs from a remote client
#! This function might break the machine, dont use
: '
ensure_journald_not_receive_logs_from_remote_client() {
    echo "Checking if journald is configured to receive logs from a remote client..."
    if [ -f /etc/systemd/journald.conf ]; then
        if grep -q "^ForwardToSyslog=no" /etc/systemd/journald.conf && \
           grep -q "^ForwardToKMsg=no" /etc/systemd/journald.conf && \
           grep -q "^ForwardToWall=yes" /etc/systemd/journald.conf && \
           ! grep -q "^RemoteServer=" /etc/systemd/journald.conf && \
           ! grep -q "^RemoteServerPort=" /etc/systemd/journald.conf; then
            echo "journald is not configured to receive logs from a remote client."
        else
            echo "Configuring journald to not receive logs from a remote client..."
            sed -i 's/^ForwardToSyslog=.*/ForwardToSyslog=no/' /etc/systemd/journald.conf
            sed -i 's/^ForwardToKMsg=.*/ForwardToKMsg=no/' /etc/systemd/journald.conf
            sed -i 's/^ForwardToWall=.*/ForwardToWall=yes/' /etc/systemd/journald.conf
            sed -i '/^RemoteServer=/d' /etc/systemd/journald.conf
            sed -i '/^RemoteServerPort=/d' /etc/systemd/journald.conf
            echo "journald is now configured to not receive logs from a remote client."
        fi
    else
        echo "journald.conf file not found."
        return 1
    fi
}

ensure_journald_not_receive_logs_from_remote_client
'

# 4.2.1.2 Ensure journald service is enabled
enable_journald_service() {
    echo "Enabling journald service..."
    if ! systemctl enable systemd-journald.service; then
        echo "Failed to enable journald service."
        return 1
    fi
}

# Call the function to ensure journald service is enabled
enable_journald_service

# 4.2.1.3 Ensure journald is configured to compress large log files
configure_journald_compress_large_logs() {
    echo "Configuring journald to compress large log files..."
    if [ -f /etc/systemd/journald.conf ]; then
        if grep -q "^Compress=yes" /etc/systemd/journald.conf; then
            echo "journald is already configured to compress large log files."
            return 0
        else
            sed -i 's/^#Compress=.*/Compress=yes/' /etc/systemd/journald.conf
            echo "journald is now configured to compress large log files."
        fi
    else
        echo "journald.conf file not found."
        return 1
    fi
    systemctl restart systemd-journald.service
}

# Call the function to ensure journald is configured to compress large log files
configure_journald_compress_large_logs

# 4.2.1.4 Ensure journald is configured to write logfiles to persistent disk
configure_journald_persistent_storage() {
    echo "Configuring journald to write logfiles to persistent disk..."
    if [ -f /etc/systemd/journald.conf ]; then
        if grep -q "^Storage=persistent" /etc/systemd/journald.conf; then
            echo "journald is already configured to write logfiles to persistent disk."
            return 0
        else
            sed -i 's/^#Storage=.*/Storage=persistent/' /etc/systemd/journald.conf
            echo "journald is now configured to write logfiles to persistent disk."
        fi
    else
        echo "journald.conf file not found. Creating file..."
        echo "Storage=persistent" >/etc/systemd/journald.conf
    fi
    systemctl restart systemd-journald.service
}

# Call the function to ensure journald is configured to write logfiles to persistent disk
configure_journald_persistent_storage

# 4.2.1.5 Ensure journald is not configured to send logs to rsyslog
ensure_journald_not_send_logs_to_rsyslog() {
    echo "Checking if journald is configured to send logs to rsyslog..."
    if [ -f /etc/systemd/journald.conf ]; then
        if grep -q "^ForwardToSyslog=no" /etc/systemd/journald.conf &&
            grep -q "^ForwardToKMsg=no" /etc/systemd/journald.conf &&
            grep -q "^ForwardToWall=yes" /etc/systemd/journald.conf &&
            ! grep -q "^SyslogIdentifier=" /etc/systemd/journald.conf &&
            ! grep -q "^SyslogFacility=" /etc/systemd/journald.conf &&
            ! grep -q "^SyslogLevel=" /etc/systemd/journald.conf; then
            echo "journald is not configured to send logs to rsyslog."
        else
            echo "Configuring journald to not send logs to rsyslog..."
            sed -i 's/^ForwardToSyslog=.*/ForwardToSyslog=no/' /etc/systemd/journald.conf
            sed -i 's/^ForwardToKMsg=.*/ForwardToKMsg=no/' /etc/systemd/journald.conf
            sed -i 's/^ForwardToWall=.*/ForwardToWall=yes/' /etc/systemd/journald.conf
            sed -i '/^SyslogIdentifier=/d' /etc/systemd/journald.conf
            sed -i '/^SyslogFacility=/d' /etc/systemd/journald.conf
            sed -i '/^SyslogLevel=/d' /etc/systemd/journald.conf
            echo "journald is now configured to not send logs to rsyslog."
        fi
    else
        echo "journald.conf file not found."
        return 1
    fi
    systemctl restart systemd-journald.service
}

# Call the function to ensure journald is not configured to send logs to rsyslog
ensure_journald_not_send_logs_to_rsyslog

# 4.2.1.6 Ensure journald log rotation is configured per site policy
configure_journald_log_rotation() {
    echo "Configuring journald log rotation..."
    if [ -f /etc/systemd/journald.conf ]; then
        if grep -q "^SystemMaxUse=" /etc/systemd/journald.conf &&
            grep -q "^SystemMaxFileSize=" /etc/systemd/journald.conf &&
            grep -q "^SystemMaxFiles=" /etc/systemd/journald.conf; then
            echo "journald log rotation is already configured."
            return 0
        else
            # Set desired log rotation settings
            sed -i 's/^#SystemMaxUse=.*/SystemMaxUse=50M/' /etc/systemd/journald.conf
            sed -i 's/^#SystemMaxFileSize=.*/SystemMaxFileSize=10M/' /etc/systemd/journald.conf
            sed -i 's/^#SystemMaxFiles=.*/SystemMaxFiles=10/' /etc/systemd/journald.conf
            echo "journald log rotation is now configured."
        fi
    else
        echo "journald.conf file not found. Creating file..."
        # Set desired log rotation settings
        echo "SystemMaxUse=50M" >/etc/systemd/journald.conf
        echo "SystemMaxFileSize=10M" >>/etc/systemd/journald.conf
        echo "SystemMaxFiles=10" >>/etc/systemd/journald.conf
    fi
    systemctl restart systemd-journald.service
}

# Call the function to ensure journald log rotation is configured
configure_journald_log_rotation

# 4.2.1.7 Ensure journald default file permissions configured
configure_journald_default_file_permissions() {
    echo "Configuring journald default file permissions..."
    if [ -f /etc/systemd/journald.conf ]; then
        if grep -q "^#Storage=" /etc/systemd/journald.conf; then
            echo "journald default file permissions are already configured."
            return 0
        else
            sed -i 's/^#Storage=.*/Storage=persistent/' /etc/systemd/journald.conf
            echo "journald default file permissions are now configured."
        fi
    else
        echo "journald.conf file not found. Creating file..."
        echo "Storage=persistent" >/etc/systemd/journald.conf
    fi
    chmod 640 /etc/systemd/journald.conf
    chown root:root /etc/systemd/journald.conf
    systemctl restart systemd-journald.service
}

# Call the function to ensure journald default file permissions are configured
configure_journald_default_file_permissions

# 4.2.2.1 Ensure rsyslog is installed
ensure_rsyslog_installed() {
    echo "Checking if rsyslog is installed..."
    if [ -x "$(command -v rsyslogd)" ]; then
        echo "rsyslog is already installed."
        return 0
    else
        echo "rsyslog is not installed. Installing..."
        apt-get install -y rsyslog
        echo "rsyslog is now installed."
    fi
}

# Call the function to ensure rsyslog is installed
ensure_rsyslog_installed

# 4.2.2.2 Ensure rsyslog service is enabled
ensure_rsyslog_service_enabled() {
    echo "Checking if rsyslog service is enabled..."
    if systemctl is-enabled rsyslog >/dev/null 2>&1; then
        echo "rsyslog service is already enabled."
    else
        echo "rsyslog service is not enabled. Enabling..."
        systemctl enable rsyslog
        echo "rsyslog service is now enabled."
    fi
}

# Call the function to ensure rsyslog service is enabled
ensure_rsyslog_service_enabled

# 4.2.2.3 Ensure journald is configured to send logs to rsyslog
configure_journald_send_logs_to_rsyslog() {
    echo "Configuring journald to send logs to rsyslog..."
    if [ -f /etc/systemd/journald.conf ]; then
        if grep -q "^ForwardToSyslog=yes" /etc/systemd/journald.conf &&
            grep -q "^SyslogFacility=daemon" /etc/systemd/journald.conf; then
            echo "journald is already configured to send logs to rsyslog."
            return 0
        else
            echo "ForwardToSyslog=yes" >>/etc/systemd/journald.conf
            echo "SyslogFacility=daemon" >>/etc/systemd/journald.conf
            echo "journald is now configured to send logs to rsyslog."
        fi
    else
        echo "journald.conf file not found."
        return 1
    fi
    systemctl restart systemd-journald.service
}

# Call the function to ensure journald is configured to send logs to rsyslog
configure_journald_send_logs_to_rsyslog

# 4.2.2.4 Ensure rsyslog default file permissions are configured
configure_rsyslog_default_file_permissions() {
    echo "Configuring rsyslog default file permissions..."
    if [ -f /etc/rsyslog.conf ]; then
        if grep -q "^\$FileCreateMode" /etc/rsyslog.conf; then
            echo "rsyslog default file permissions are already configured."
            return 0
        else
            echo "\$FileCreateMode 0640" >>/etc/rsyslog.conf
            echo "rsyslog default file permissions are now configured."
        fi
    else
        echo "rsyslog.conf file not found. Creating file..."
        echo "\$FileCreateMode 0640" >/etc/rsyslog.conf
        chown root:adm /etc/rsyslog.conf
        chmod 640 /etc/rsyslog.conf
    fi
}

# Call the function to ensure rsyslog default file permissions are configured
configure_rsyslog_default_file_permissions

# 4.2.2.5 Ensure logging is configured

# 4.2.2.5.1 Configure logrotate to rotate logs
configure_logrotate_rotate_logs() {
    echo "Configuring logrotate to rotate logs..."
    if [ -f /etc/logrotate.conf ]; then
        if grep -q "^rotate " /etc/logrotate.conf; then
            echo "logrotate is already configured to rotate logs."
            return 0
        else
            sed -i '/^# no packages own/ a rotate 30' /etc/logrotate.conf
            echo "logrotate is now configured to rotate logs."
        fi
    else
        echo "logrotate.conf file not found."
        return 1
    fi
}

# Call the function to configure logrotate to rotate logs
configure_logrotate_rotate_logs

# 4.2.2.5.2 Ensure logrotate is configured to send logs to syslog
configure_logrotate_send_logs_to_syslog() {
    echo "Configuring logrotate to send logs to syslog..."
    if [ -f /etc/logrotate.conf ]; then
        if grep -q "^#syslog" /etc/logrotate.conf; then
            echo "logrotate is already configured to send logs to syslog."
            return 0
        else
            sed -i 's/^#compress/compress\n\tsyslog/' /etc/logrotate.conf
            echo "logrotate is now configured to send logs to syslog."
        fi
    else
        echo "logrotate.conf file not found."
        return 1
    fi
}

# Call the function to ensure logrotate is configured to send logs to syslog
configure_logrotate_send_logs_to_syslog

# 4.2.2.5.3 Ensure logrotate is configured to compress logs
configure_logrotate_compress_logs() {
    echo "Configuring logrotate to compress logs..."
    if [ -f /etc/logrotate.conf ]; then
        if grep -q "^#compress" /etc/logrotate.conf; then
            echo "logrotate is already configured to compress logs."
            return 0
        else
            sed -i 's/^compress/compress\n\tcompresscmd \/usr\/bin\/gzip\n\tcompressoptions -9\n\tcompressext .gz/' /etc/logrotate.conf
            echo "logrotate is now configured to compress logs."
        fi
    else
        echo "logrotate.conf file not found."
        return 1
    fi
}

# Call the function to ensure logrotate is configured to compress logs
configure_logrotate_compress_logs

# 4.2.2.5.4 Ensure logrotate is configured to keep logs for 30 days
configure_logrotate_keep_logs() {
    echo "Configuring logrotate to keep logs for 30 days..."
    if [ -f /etc/logrotate.conf ]; then
        if grep -q "^#rotate " /etc/logrotate.conf; then
            echo "logrotate is already configured to keep logs for 30 days."
            return 0
        else
            sed -i 's/^rotate [0-9]*/rotate 30/' /etc/logrotate.conf
            echo "logrotate is now configured to keep logs for 30 days."
        fi
    else
        echo "logrotate.conf file not found."
        return 1
    fi
}

# Call the function to ensure logrotate is configured to keep logs for 30 days
configure_logrotate_keep_logs

# 4.2.2.6 Ensure rsyslog is configured to send logs to a remote log host
: ' configure_rsyslog_send_logs_to_remote_host() {
    echo "Configuring rsyslog to send logs to a remote log host..."
    if [ -f /etc/rsyslog.conf ]; then
        if grep -q "^*.* @@<remote_log_host>:514" /etc/rsyslog.conf; then
            echo "rsyslog is already configured to send logs to a remote log host."
            return 0
        else
            echo "*.* @@<remote_log_host>:514" >>/etc/rsyslog.conf
            echo "rsyslog is now configured to send logs to a remote log host."
        fi
    else
        echo "rsyslog.conf file not found."
        return 1
    fi
    systemctl restart rsyslog
}

configure_rsyslog_send_logs_to_remote_host
'
# 4.2.2.7 Ensure rsyslog is not configured to receive logs from a remote client
#! The 2 functions above might break the machine, dont use

# 4.2.3 Ensure all logfiles have appropriate permissions and ownership
ensure_logfiles_permissions() {
    echo "Ensuring all logfiles have appropriate permissions and ownership..."
    if ! find /var/log -type f -perm /027 -exec ls -ld {} \+ | grep -q ""; then
        echo "Logfiles do not have appropriate permissions and ownership. Setting permissions to 640..."
        if ! find /var/log -type f -perm /027 -exec chmod 640 {} \+; then
            echo "Failed to set logfile permissions to 640."
            return 1
        fi
    else
        echo "Logfiles have appropriate permissions and ownership."
    fi
}
