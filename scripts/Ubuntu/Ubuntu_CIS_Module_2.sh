#!/bin/bash

# Command I used to make this whole script in Copilot:
# "Write a function to do the following: (argument that gets commented). If the function couldn't execute, return an error but don't end the script."

single_time_sync_daemon() {
    # Check if systemd-timesyncd.service is active and enabled and if ntp.service is active and enabled. If both are active and enabled, return success. If only one is active and enabled, return success. If neither are active and enabled, return failure.
    # 2.1.1.1 Ensure a single time synchronization daemon is in use
    echo 'checking if a single time synchronization daemon is in use...'
    if [[ $(systemctl is-active systemd-timesyncd.service) == "active" ]]; then
        if [[ $(systemctl is-enabled systemd-timesyncd.service) == "enabled" ]]; then
            echo "Success: A single time synchronization daemon is in use."
            return 0
        else
            echo "Failure: systemd-timesyncd.service is not enabled."
            return 1
        fi
    elif [[ $(systemctl is-active ntp.service) == "active" ]]; then
        if [[ $(systemctl is-enabled ntp.service) == "enabled" ]]; then
            echo "Success: A single time synchronization daemon is in use."
            return 0
        else
            echo "Failure: ntp.service is not enabled."
            return 1
        fi
    else
        echo "Failure: No time synchronization daemon is active."
        return 1
    fi
}

single_time_sync_daemon
echo

check_if_chrony_is_installed() {
    # Check if chrony is installed.
    # 2.1.2.1 Ensure chrony is configured with authorized timeserver
    echo 'checking if chrony is installed...'
    if ! command -v chronyc &>/dev/null; then
        echo "Failure: chrony is not installed."
        return 1
    else
        echo "Success: chrony is installed."
    fi
}

check_if_config_file_exists() {
    # Check if the chrony configuration file exists.
    # 2.1.2.1 Ensure chrony is configured with authorized timeserver
    echo 'checking if the chrony configuration file exists...'
    if [ ! -f /etc/chrony/chrony.conf ]; then
        echo "Failure: /etc/chrony/chrony.conf does not exist."
        return 1
    else
        echo "Success: /etc/chrony/chrony.conf exists."
        return 0
    fi
}

check_if_config_file_contains_authorized_timeserver() {
    # Check if the chrony configuration file contains an authorized time server.
    # 2.1.2.1 Ensure chrony is configured with authorized timeserver
    if grep -q "^server" /etc/chrony/chrony.conf; then
        echo "Chrony is already configured with authorized timeserver."
        return 0
    else
        # Configure chrony with an authorized time server.
        echo "Configuring chrony with authorized time server..."
        echo "server time.nist.gov iburst" >>/etc/chrony/chrony.conf
        if grep -q "^server" /etc/chrony/chrony.conf; then
            echo "Success: chrony is configured with authorized timeserver."
            return 0
        else
            echo "Failure to configure chrony with authorized time server."
            return 1
        fi
    fi
}

configure_chrony_user() {
    # 2.1.2.2 Ensure chrony is running as user _chrony
    echo 'checking if chrony is running as user _chrony...'
    if [[ $(ps -ef | grep chronyd | grep -v grep | awk '{print $1}') == "_chrony" ]]; then
        echo "Success: chrony is already running as user _chrony."
        return 0
    else
        echo "chrony is not running as user _chrony. Configuring chrony to run as user _chrony..."
        sed -i 's/^#*.*\bchrony\b.*$/#&\nOPTIONS="-u _chrony"/' /etc/default/chrony
        if [[ $(ps -ef | grep chronyd | grep -v grep | awk '{print $1}') == "_chrony" ]]; then
            echo "Success: chrony is now running as user _chrony."
            return 0
        else
            echo "Failure: Unable to configure chrony to run as user _chrony."
            return 1
        fi
    fi
}

enable_chrony() {
    # 2.1.2.3 Ensure chrony is enabled and running
    echo 'checking if chrony is enabled...'
    if [[ $(systemctl is-enabled chrony.service) == "enabled" ]]; then
        echo "Success: chrony is already enabled."
        return 0
    else
        echo "enabling chrony..."
        systemctl enable chrony.service
        if [[ $(systemctl is-enabled chrony.service) == "enabled" ]]; then
            echo "Success: chrony is now enabled."
            return 0
        else
            echo "Failure: Unable to enable chrony."
            return 1
        fi
    fi
}

start_chrony() {
    # 2.1.2.3 Ensure chrony is enabled and running
    echo 'checking if chrony is running...'
    if [[ $(systemctl is-active chrony.service) == "active" ]]; then
        echo "Success: chrony is already running."
        return 0
    else
        echo "starting chrony..."
        systemctl start chrony.service
        if [[ $(systemctl is-active chrony.service) == "active" ]]; then
            echo "Success: chrony is now running."
            return 0
        else
            echo "Failure: Unable to start chrony."
            return 1
        fi
    fi
}

configure_chrony() {
    # 2.1.2 Configure chrony
    check_if_chrony_is_installed
    check_if_config_file_exists
    check_if_config_file_contains_authorized_timeserver
    configure_chrony_user
    enable_chrony
    start_chrony
    echo
}

configure_chrony

check_if_timesyncd_config_file_contains_authorized_timeserver() {
    # Check if the timesyncd configuration file contains an authorized time server.
    # 2.1.3.1 Ensure systemd-timesyncd configured with authorized timeserver
    if grep -q "^NTP" /etc/systemd/timesyncd.conf; then
        echo "systemd-timesyncd is already configured with authorized timeserver."
        return 0
    else
        # Configure systemd-timesyncd with an authorized time server.
        echo "Configuring systemd-timesyncd with authorized time server..."
        echo "NTP=time.nist.gov" >>/etc/systemd/timesyncd.conf
        if grep -q "^NTP" /etc/systemd/timesyncd.conf; then
            echo "Success: systemd-timesyncd is configured with authorized timeserver."
            return 0
        else
            echo "Failure to configure systemd-timesyncd with authorized time server."
            return 1
        fi
    fi
}

enable_timesyncd() {
    # 2.1.3.2 Ensure systemd-timesyncd is enabled and running
    echo 'checking if systemd-timesyncd is enabled...'
    if [[ $(systemctl is-enabled systemd-timesyncd.service) == "enabled" ]]; then
        echo "Success: systemd-timesyncd is already enabled."
        echo 'checking if systemd-timesyncd is running...'
        if [[ $(systemctl is-active systemd-timesyncd.service) == "active" ]]; then
            echo "Success: systemd-timesyncd is already running."
            return 0
        else
            echo "starting systemd-timesyncd..."
            systemctl start systemd-timesyncd.service
            if [[ $(systemctl is-active systemd-timesyncd.service) == "active" ]]; then
                echo "Success: systemd-timesyncd is now running."
                return 0
            else
                echo "Failure: Unable to start systemd-timesyncd."
                return 1
            fi
        fi
    else
        echo "enabling systemd-timesyncd..."
        systemctl enable systemd-timesyncd.service
        if [[ $(systemctl is-enabled systemd-timesyncd.service) == "enabled" ]]; then
            echo "Success: systemd-timesyncd is now enabled."
            echo 'checking if systemd-timesyncd is running...'
            if [[ $(systemctl is-active systemd-timesyncd.service) == "active" ]]; then
                echo "Success: systemd-timesyncd is now running."
                return 0
            else
                echo "starting systemd-timesyncd..."
                systemctl start systemd-timesyncd.service
                if [[ $(systemctl is-active systemd-timesyncd.service) == "active" ]]; then
                    echo "Success: systemd-timesyncd is now running."
                    return 0
                else
                    echo "Failure: Unable to start systemd-timesyncd."
                    return 1
                fi
            fi
        else
            echo "Failure: Unable to enable systemd-timesyncd."
            return 1
        fi
    fi
}

restart_timesyncd() {
    # Restart the systemd-timesyncd service.
    echo 'restarting systemd-timesyncd...'
    systemctl restart systemd-timesyncd.service
    if [[ $(systemctl is-active systemd-timesyncd.service) == "active" ]]; then
        echo "Success: systemd-timesyncd is now running."
        return 0
    else
        echo "Failure: Unable to start systemd-timesyncd."
        return 1
    fi
}

configure_timesyncd() {
    # 2.1.3 Configure systemd-timesyncd
    check_if_timesyncd_config_file_contains_authorized_timeserver
    enable_timesyncd
    restart_timesyncd
    echo
}

configure_timesyncd

check_if_ntp_is_installed() {
    # Check if the ntp package is installed.
    # 2.1.4.1 Ensure ntp access control is configured
    echo 'Checking if ntp package is installed...'
    if ! dpkg -s ntp >/dev/null 2>&1; then
        echo "Installing ntp package..."
        apt-get install -y ntp
        if ! dpkg -s ntp >/dev/null 2>&1; then
            echo "Error: Unable to install ntp package."
            return 1
        else
            echo "Success: ntp package is installed."
        fi
    else
        echo "Success: ntp package is already installed."
    fi
}

check_if_ntp_config_file_exists() {
    # Check if the ntp configuration file exists.
    # 2.1.4.1 Ensure ntp access control is configured
    echo 'Checking if /etc/ntp.conf exists...'
    if [ ! -f /etc/ntp.conf ]; then
        echo "Creating /etc/ntp.conf..."
        touch /etc/ntp.conf
        if [ ! -f /etc/ntp.conf ]; then
            echo "Error: Unable to create /etc/ntp.conf."
            return 1
        else
            echo "Success: /etc/ntp.conf is created."
        fi
    else
        echo "Success: /etc/ntp.conf already exists."
    fi
}

check_if_ntp_config_file_contains_restrict() {
    # Check if the ntp configuration file contains the "restrict" keyword.
    # 2.1.4.1 Ensure ntp access control is configured
    echo 'Checking if the "restrict" keyword is present in /etc/ntp.conf...'
    if grep -q "^restrict" /etc/ntp.conf; then
        echo 'The "restrict" keyword is aready present in /etc/ntp.conf.'
        return 0
    else
        echo 'The "restrict" keyword is not present in /etc/ntp.conf. Adding it to the configuration file...'
        echo "restrict default nomodify notrap" >>/etc/ntp.conf
        if grep -q "^restrict" /etc/ntp.conf; then
            echo 'Success: The "restrict" keyword is now present in /etc/ntp.conf.'
            return 0
        else
            echo 'Error: Unable to add the "restrict" keyword to /etc/ntp.conf.'
            return 1
        fi
    fi
}

add_default_to_restrict_line() {
    # If the "default" keyword is present, check if it has the "nomodify" and "notrap" options.
    # 2.1.4.1 Ensure ntp access control is configured
    if grep -q "^restrict.*default" /etc/ntp.conf; then
        if grep -q "^restrict.*default.*nomodify.*notrap" /etc/ntp.conf; then
            return 0
        else
            sed -i 's/^restrict.*default.*/& nomodify notrap/' /etc/ntp.conf
        fi
    else
        # If the "default" keyword is not present, add it to the configuration file.
        sed -i '/^restrict/ a restrict default nomodify notrap' /etc/ntp.conf
    fi
}

# add_authorized_timeservers_to_ntp_config_file() {
#     # Add authorized timeservers to /etc/ntp.conf
#     # 2.1.4.2 Ensure ntp is configured with authorized timeserver
#     authorized_timeservers=("192.168.1.1" "192.168.1.2")
#     for server in "${authorized_timeservers[@]}"; do
#         if grep -q "^server $server" /etc/ntp.conf; then
#             echo "The timeserver $server is already present in /etc/ntp.conf."
#         else
#             echo "Adding the timeserver $server to /etc/ntp.conf..."
#             echo "server $server" >>/etc/ntp.conf
#         fi
#     done
# }

ensure_ntp_running_as_ntp_user() {
    # 2.1.4.3 Ensure ntp is running as user ntp
    echo 'Checking if ntp is running as user ntp...'
    if ps -ef | grep -q "^ntp"; then
        echo 'Success: ntp is running as user ntp.'
    else
        echo 'Error: ntp is not running as user ntp. Restarting ntp with user ntp...'
        service ntp stop
        ntpd -u ntp:ntp -g
        if ps -ef | grep -q "^ntp"; then
            echo 'Success: ntp is now running as user ntp.'
        else
            echo 'Error: Unable to start ntp as user ntp.'
            return 1
        fi
    fi
}

enable_ntp_service() {
    # 2.1.4.4 Ensure ntp is enabled and running
    echo 'Checking if ntp service is enabled...'
    if systemctl is-enabled ntp >/dev/null 2>&1; then
        echo 'Success: ntp service is enabled.'
        return 0
    else
        echo 'Enabling ntp service...'
        systemctl enable ntp
        if systemctl is-enabled ntp >/dev/null 2>&1; then
            echo 'Success: ntp service is now enabled.'
            return 0
        else
            echo 'Error: Unable to enable ntp service.'
            return 1
        fi
    fi
}

start_ntp_service() {
    # 2.1.4.4 Ensure ntp is enabled and running
    echo 'Checking if ntp service is running...'
    if systemctl is-active ntp >/dev/null 2>&1; then
        echo 'Success: ntp service is running.'
        return 0
    else
        echo 'Starting ntp service...'
        systemctl start ntp
        if systemctl is-active ntp >/dev/null 2>&1; then
            echo 'Success: ntp service is now running.'
            return 0
        else
            echo 'Error: Unable to start ntp service.'
            return 1
        fi
    fi
}

configure_ntp() {
    # 2.1.4 Configure NTP
    check_if_ntp_is_installed
    check_if_ntp_config_file_exists
    check_if_ntp_config_file_contains_restrict
    add_default_to_restrict_line
    # add_authorized_timeservers_to_ntp_config_file
    ensure_ntp_running_as_ntp_user
    enable_ntp_service
    start_ntp_service
    echo
}

configure_ntp

remove_x_window_system() {
    # 2.2.1 Ensure X Window System is not installed
    echo 'Checking if X Window System is installed...'
    if dpkg -s xserver-xorg-core >/dev/null 2>&1; then
        echo 'X Window System is installed. Removing...'
        apt-get remove --purge xserver-xorg-core -y
        apt-get autoremove -y
        apt-get autoclean -y
        if dpkg -s xserver-xorg-core >/dev/null 2>&1; then
            echo 'Error: Unable to remove X Window System.'
            return 1
        else
            echo 'Success: X Window System has been removed.'
            return 0
        fi
    else
        echo 'Success: X Window System was not installed.'
        return 0
    fi
}

remove_avahi_server() {
    # 2.2.2 Ensure Avahi Server is not installed
    echo 'Checking if Avahi Server is installed...'
    if dpkg -s avahi-daemon >/dev/null 2>&1; then
        echo 'Avahi Server is installed. Removing...'
        apt-get remove --purge avahi-daemon -y
        apt-get autoremove -y
        apt-get autoclean -y
        if dpkg -s avahi-daemon >/dev/null 2>&1; then
            echo 'Error: Unable to remove Avahi Server.'
            return 1
        else
            echo 'Success: Avahi Server has been removed.'
            return 0
        fi
    else
        echo 'Success: Avahi Server was not installed.'
        return 0
    fi
}

remove_cups() {
    # 2.2.3 Ensure CUPS is not installed
    echo 'Checking if CUPS is installed...'
    if dpkg -s cups >/dev/null 2>&1; then
        echo 'CUPS is installed. Removing...'
        apt-get remove --purge cups -y
        apt-get autoremove -y
        apt-get autoclean -y
        if dpkg -s cups >/dev/null 2>&1; then
            echo 'Error: Unable to remove CUPS.'
            return 1
        else
            echo 'Success: CUPS has been removed.'
            return 0
        fi
    else
        echo 'Success: CUPS was not installed.'
        return 0
    fi
}

remove_dhcp_server() {
    # 2.2.4 Ensure DHCP Server is not installed
    echo 'Checking if DHCP Server is installed...'
    if dpkg -s isc-dhcp-server >/dev/null 2>&1; then
        echo 'DHCP Server is installed. Removing...'
        apt-get remove --purge isc-dhcp-server -y
        apt-get autoremove -y
        apt-get autoclean -y
        if dpkg -s isc-dhcp-server >/dev/null 2>&1; then
            echo 'Error: Unable to remove DHCP Server.'
            return 1
        else
            echo 'Success: DHCP Server has been removed.'
            return 0
        fi
    else
        echo 'Success: DHCP Server was not installed.'
        return 0
    fi
}

remove_ldap_server() {
    # 2.2.5 Ensure LDAP server is not installed
    echo 'Checking if LDAP server is installed...'
    if dpkg -s slapd >/dev/null 2>&1; then
        echo 'LDAP server is installed. Removing...'
        apt-get remove --purge slapd -y
        apt-get autoremove -y
        apt-get autoclean -y
        if dpkg -s slapd >/dev/null 2>&1; then
            echo 'Error: Unable to remove LDAP server.'
            return 1
        else
            echo 'Success: LDAP server has been removed.'
            return 0
        fi
    else
        echo 'Success: LDAP server was not installed.'
        return 0
    fi
}

remove_nfs() {
    # 2.2.6 Ensure NFS is not installed
    echo 'Checking if NFS is installed...'
    if dpkg -s nfs-kernel-server >/dev/null 2>&1; then
        echo 'NFS is installed. Removing...'
        apt-get remove --purge nfs-kernel-server -y
        apt-get autoremove -y
        apt-get autoclean -y
        if dpkg -s nfs-kernel-server >/dev/null 2>&1; then
            echo 'Error: Unable to remove NFS.'
            return 1
        else
            echo 'Success: NFS has been removed.'
            return 0
        fi
    else
        echo 'Success: NFS was not installed.'
        return 0
    fi
}

remove_dns_server() {
    # 2.2.7 Ensure DNS Server is not installed
    echo 'Checking if DNS Server is installed...'
    if dpkg -s bind9 >/dev/null 2>&1; then
        echo 'DNS Server is installed. Removing...'
        apt-get remove --purge bind9 -y
        apt-get autoremove -y
        apt-get autoclean -y
        if dpkg -s bind9 >/dev/null 2>&1; then
            echo 'Error: Unable to remove DNS Server.'
            return 1
        else
            echo 'Success: DNS Server has been removed.'
            return 0
        fi
    else
        echo 'Success: DNS Server was not installed.'
        return 0
    fi
}

# remove_ftp_server() {
#     # 2.2.8 Ensure FTP Server is not installed
#     echo 'Checking if FTP Server is installed...'
#     if dpkg -s vsftpd >/dev/null 2>&1; then
#         echo 'FTP Server is installed. Removing...'
#         apt-get remove --purge vsftpd -y
#         apt-get autoremove -y
#         apt-get autoclean -y
#         if dpkg -s vsftpd >/dev/null 2>&1; then
#             echo 'Error: Unable to remove FTP Server.'
#             return 1
#         else
#             echo 'Success: FTP Server has been removed.'
#             return 0
#         fi
#     else
#         echo 'Success: FTP Server was not installed.'
#         return 0
#     fi
# }

remove_http_server() {
    # 2.2.9 Ensure HTTP server is not installed
    echo 'Checking if HTTP server is installed...'
    if dpkg -s apache2 >/dev/null 2>&1; then
        echo 'HTTP server is installed. Removing...'
        apt-get remove --purge apache2 -y
        apt-get autoremove -y
        apt-get autoclean -y
        if dpkg -s apache2 >/dev/null 2>&1; then
            echo 'Error: Unable to remove HTTP server.'
            return 1
        else
            echo 'Success: HTTP server has been removed.'
            return 0
        fi
    else
        echo 'Success: HTTP server was not installed.'
        return 0
    fi
}

remove_imap_server() {
    # 2.2.10 Ensure IMAP server is not installed
    echo 'Checking if IMAP server is installed...'
    if dpkg -s dovecot-imapd >/dev/null 2>&1; then
        echo 'IMAP server is installed. Removing...'
        apt-get remove --purge dovecot-imapd -y
        apt-get autoremove -y
        apt-get autoclean -y
        if dpkg -s dovecot-imapd >/dev/null 2>&1; then
            echo 'Error: Unable to remove IMAP server.'
            return 1
        else
            echo 'Success: IMAP server has been removed.'
            return 0
        fi
    else
        echo 'Success: IMAP server was not installed.'
        return 0
    fi
}

remove_pop3_server() {
    # 2.2.10 Ensure POP3 server is not installed
    echo 'Checking if POP3 server is installed...'
    if dpkg -s dovecot-pop3d >/dev/null 2>&1; then
        echo 'POP3 server is installed. Removing...'
        apt-get remove --purge dovecot-pop3d -y
        apt-get autoremove -y
        apt-get autoclean -y
        if dpkg -s dovecot-pop3d >/dev/null 2>&1; then
            echo 'Error: Unable to remove POP3 server.'
            return 1
        else
            echo 'Success: POP3 server has been removed.'
            return 0
        fi
    else
        echo 'Success: POP3 server was not installed.'
        return 0
    fi
}

remove_samba() {
    # 2.2.11 Ensure Samba is not installed
    echo 'Checking if Samba is installed...'
    if dpkg -s samba >/dev/null 2>&1; then
        echo 'Samba is installed. Removing...'
        apt-get remove --purge samba -y
        apt-get autoremove -y
        apt-get autoclean -y
        if dpkg -s samba >/dev/null 2>&1; then
            echo 'Error: Unable to remove Samba.'
            return 1
        else
            echo 'Success: Samba has been removed.'
            return 0
        fi
    else
        echo 'Success: Samba was not installed.'
        return 0
    fi
}

remove_http_proxy_server() {
    # 2.2.12 Ensure HTTP Proxy Server is not installed
    echo 'Checking if HTTP Proxy Server is installed...'
    if dpkg -s squid >/dev/null 2>&1; then
        echo 'HTTP Proxy Server is installed. Removing...'
        apt-get remove --purge squid -y
        apt-get autoremove -y
        apt-get autoclean -y
        if dpkg -s squid >/dev/null 2>&1; then
            echo 'Error: Unable to remove HTTP Proxy Server.'
            return 1
        else
            echo 'Success: HTTP Proxy Server has been removed.'
            return 0
        fi
    else
        echo 'Success: HTTP Proxy Server was not installed.'
        return 0
    fi
}

remove_snmp_server() {
    # 2.2.13 Ensure SNMP Server is not installed
    echo 'Checking if SNMP Server is installed...'
    if dpkg -s snmpd >/dev/null 2>&1; then
        echo 'SNMP Server is installed. Removing...'
        apt-get remove --purge snmpd -y
        apt-get autoremove -y
        apt-get autoclean -y
        if dpkg -s snmpd >/dev/null 2>&1; then
            echo 'Error: Unable to remove SNMP Server.'
            return 1
        else
            echo 'Success: SNMP Server has been removed.'
            return 0
        fi
    else
        echo 'Success: SNMP Server was not installed.'
        return 0
    fi
}

remove_nis_server() {
    # 2.2.14 Ensure NIS Server is not installed
    echo 'Checking if NIS Server is installed...'
    if dpkg -s nis >/dev/null 2>&1; then
        echo 'NIS Server is installed. Removing...'
        apt-get remove --purge nis -y
        apt-get autoremove -y
        apt-get autoclean -y
        if dpkg -s nis >/dev/null 2>&1; then
            echo 'Error: Unable to remove NIS Server.'
            return 1
        else
            echo 'Success: NIS Server has been removed.'
            return 0
        fi
    else
        echo 'Success: NIS Server was not installed.'
        return 0
    fi
}

configure_mail_transfer_agent() {
    # 2.2.15 Ensure mail transfer agent is configured for local-only mode
    echo 'Checking if mail transfer agent is installed...'
    if dpkg -s postfix >/dev/null 2>&1; then
        echo 'Mail transfer agent is installed. Checking if it is configured for local-only mode...'
        if grep -q "^inet_interfaces\s*=\s*localhost" /etc/postfix/main.cf; then
            echo 'Mail transfer agent is already configured for local-only mode.'
            return 0
        else
            echo 'Configuring mail transfer agent for local-only mode...'
            sed -i 's/^inet_interfaces.*/inet_interfaces = localhost/' /etc/postfix/main.cf
            systemctl reload postfix
            if grep -q "^inet_interfaces\s*=\s*localhost" /etc/postfix/main.cf; then
                echo 'Success: Mail transfer agent has been configured for local-only mode.'
                return 0
            else
                echo 'Error: Unable to configure mail transfer agent for local-only mode.'
                return 1
            fi
        fi
    else
        echo 'Success: Mail transfer agent is not installed.'
        return 0
    fi
}

mask_rsync_service() {
    # 2.2.16 Ensure rsync service is either not installed or masked
    echo 'Checking if rsync is installed...'
    if dpkg -s rsync >/dev/null 2>&1; then
        echo 'rsync is installed. Masking the service...'
        systemctl mask rsync
        if systemctl is-enabled rsync >/dev/null 2>&1; then
            systemctl disable rsync
        fi
        echo 'Success: rsync service has been masked.'
        return 0
    else
        echo 'Success: rsync is not installed.'
        return 0
    fi
}

special_purpose_services() {
    # 2.2 Special Purpose Services
    echo 'THIS SCRIPT IS NOW GOING TO REMOVE THE FOLLOWING SERVICES:
    X Window System
    Avahi Server
    CUPS
    DHCP Server
    LDAP Server
    NFS
    DNS Server
    HTTP Server
    IMAP Server
    POP3 Server
    Samba
    HTTP Proxy Server
    SNMP Server
    NIS Server
    IT WILL ALSO CONFIGURE THE FOLLOWING:
    Mail Transfer Agent
    Mask rsync service'
    read -p "Press enter to continue or ctrl+c to cancel."
    remove_x_window_system
    remove_avahi_server
    remove_cups
    remove_dhcp_server
    remove_ldap_server
    remove_nfs
    remove_dns_server
    remove_http_server
    remove_imap_server
    remove_pop3_server
    remove_samba
    remove_http_proxy_server
    remove_snmp_server
    remove_nis_server
    configure_mail_transfer_agent
    mask_rsync_service
}

special_purpose_services

remove_nis_client() {
    # 2.3.1 Ensure NIS Client is not installed
    echo 'Checking if NIS Client is installed...'
    if dpkg -s nis >/dev/null 2>&1; then
        echo 'NIS Client is installed. Removing NIS Client...'
        apt-get remove -y nis
        if dpkg -s nis >/dev/null 2>&1; then
            echo 'Error: Unable to remove NIS Client.'
            return 1
        else
            echo 'Success: NIS Client has been removed.'
            return 0
        fi
    else
        echo 'Success: NIS Client was not installed.'
        return 0
    fi
}

remove_rsh_client() {
    # 2.3.2 Ensure rsh client is not installed
    echo 'Checking if rsh client is installed...'
    if dpkg -s rsh-client >/dev/null 2>&1; then
        echo 'rsh client is installed. Removing rsh client...'
        apt-get remove -y rsh-client
        if dpkg -s rsh-client >/dev/null 2>&1; then
            echo 'Error: Unable to remove rsh client.'
            return 1
        else
            echo 'Success: rsh client has been removed.'
            return 0
        fi
    else
        echo 'Success: rsh client was not installed.'
        return 0
    fi
}

remove_talk_client() {
    # 2.3.3 Ensure talk client is not installed
    echo 'Checking if talk client is installed...'
    if dpkg -s talk >/dev/null 2>&1; then
        echo 'talk client is installed. Removing talk client...'
        apt-get remove -y talk
        if dpkg -s talk >/dev/null 2>&1; then
            echo 'Error: Unable to remove talk client.'
            return 1
        else
            echo 'Success: talk client has been removed.'
            return 0
        fi
    else
        echo 'Success: talk client was not installed.'
        return 0
    fi
}

remove_telnet_client() {
    # 2.3.4 Ensure telnet client is not installed
    echo 'Checking if telnet client is installed...'
    if dpkg -s telnet >/dev/null 2>&1; then
        echo 'telnet client is installed. Removing telnet client...'
        apt-get remove -y telnet
        if dpkg -s telnet >/dev/null 2>&1; then
            echo 'Error: Unable to remove telnet client.'
            return 1
        else
            echo 'Success: telnet client has been removed.'
            return 0
        fi
    else
        echo 'Success: telnet client was not installed.'
        return 0
    fi
}

remove_ldap_client() {
    # 2.3.5 Ensure LDAP client is not installed
    echo 'Checking if LDAP client is installed...'
    if dpkg -s ldap-utils >/dev/null 2>&1; then
        echo 'LDAP client is installed. Removing LDAP client...'
        apt-get remove -y ldap-utils
        if dpkg -s ldap-utils >/dev/null 2>&1; then
            echo 'Error: Unable to remove LDAP client.'
            return 1
        else
            echo 'Success: LDAP client has been removed.'
            return 0
        fi
    else
        echo 'Success: LDAP client was not installed.'
        return 0
    fi
}

remove_rpc() {
    # 2.3.6 Ensure RPC is not installed
    echo 'Checking if RPC is installed...'
    if dpkg -s rpcbind >/dev/null 2>&1; then
        echo 'RPC is installed. Removing RPC...'
        apt-get remove -y rpcbind
        if dpkg -s rpcbind >/dev/null 2>&1; then
            echo 'Error: Unable to remove RPC.'
            return 1
        else
            echo 'Success: RPC has been removed.'
            return 0
        fi
    else
        echo 'Success: RPC was not installed.'
        return 0
    fi
}

service_clients() {
    # 2.3 Service Clients
    echo 'THIS SCRIPT IS NOW GOING TO REMOVE THE FOLLOWING SERVICE CLIENTS:
    NIS Client
    rsh client
    talk client
    telnet client
    LDAP client
    RPC'
    read -p "Press enter to continue or ctrl+c to cancel."
    remove_nis_client
    remove_rsh_client
    remove_talk_client
    remove_telnet_client
    remove_ldap_client
    remove_rpc
}

service_clients
