#!/bin/bash

check_ipv6_enabled() {
    echo checking if IPv6 is enabled...
    if [ -f /proc/net/if_inet6 ]; then
        echo "IPv6 is enabled"
        return 0
    else
        echo "IPv6 is not enabled. Enabling IPv6..."
        sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0
        sudo sysctl -w net.ipv6.conf.default.disable_ipv6=0
        sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=0
        if [ $? -eq 0 ]; then
            echo "IPv6 enabled successfully"
            return 0
        else
            echo "Failed to enable IPv6"
            return 1
        fi
    fi
}

disable_wireless_interfaces() {
    echo "Checking if wireless interfaces are enabled..."
    if [ -n "$(ip link | grep wlan)" ]; then
        echo "Wireless interfaces found. Disabling..."
        sudo ip link set wlan0 down
        sudo ip link set wlan1 down
        if [ $? -eq 0 ]; then
            echo "Wireless interfaces disabled successfully"
            return 0
        else
            echo "Failed to disable wireless interfaces"
            return 1
        fi
    else
        echo "Success: No wireless interfaces found. Nothing to do."
        return 0
    fi
}

disable_packet_redirect_sending() {
    # 3.2.1 Ensure packet redirect sending is disabled
    echo "Disabling packet redirect sending..."
    sudo sysctl -w net.ipv4.conf.all.send_redirects=0
    sudo sysctl -w net.ipv4.conf.default.send_redirects=0
    if [ $? -eq 0 ]; then
        echo "Packet redirect sending disabled successfully"
        return 0
    else
        echo "Failed to disable packet redirect sending"
        return 1
    fi
}

disable_source_routed_packets() {
    # 3.3.1 Ensure source routed packets are not accepted
    echo "Disabling source routed packets..."
    sudo sysctl -w net.ipv4.conf.all.accept_source_route=0
    sudo sysctl -w net.ipv4.conf.default.accept_source_route=0
    if [ $? -eq 0 ]; then
        echo "Source routed packets disabled successfully"
        return 0
    else
        echo "Failed to disable source routed packets"
        return 1
    fi
}

network_parameters() {
    # 3.2 Network Parameters (Host Only)
    disable_packet_redirect_sending
    disable_source_routed_packets
}

network_parameters

disable_icmp_redirects() {
    # 3.3.2 Ensure ICMP redirects are not accepted
    echo "Disabling ICMP redirects..."
    sudo sysctl -w net.ipv4.conf.all.accept_redirects=0
    sudo sysctl -w net.ipv4.conf.default.accept_redirects=0
    if [ $? -eq 0 ]; then
        echo "ICMP redirects disabled successfully"
        return 0
    else
        echo "Failed to disable ICMP redirects"
        return 1
    fi
}

disable_secure_icmp_redirects() {
    # 3.3.3 Ensure secure ICMP redirects are not accepted
    echo "Disabling secure ICMP redirects..."
    sudo sysctl -w net.ipv4.conf.all.secure_redirects=0
    sudo sysctl -w net.ipv4.conf.default.secure_redirects=0
    if [ $? -eq 0 ]; then
        echo "Secure ICMP redirects disabled successfully"
        return 0
    else
        echo "Failed to disable secure ICMP redirects"
        return 1
    fi
}

enable_logging_of_suspicious_packets() {
    # 3.3.4 Ensure suspicious packets are logged
    echo "Enabling logging of suspicious packets..."
    sudo sysctl -w net.ipv4.conf.all.log_martians=1
    sudo sysctl -w net.ipv4.conf.default.log_martians=1
    if [ $? -eq 0 ]; then
        echo "Logging of suspicious packets enabled successfully"
        return 0
    else
        echo "Failed to enable logging of suspicious packets"
        return 1
    fi
}

ignore_broadcast_icmp_requests() {
    # 3.3.5 Ensure broadcast ICMP requests are ignored
    echo "Ignoring broadcast ICMP requests..."
    sudo sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
    if [ $? -eq 0 ]; then
        echo "Broadcast ICMP requests ignored successfully"
        return 0
    else
        echo "Failed to ignore broadcast ICMP requests"
        return 1
    fi
}

#! Skipped 3.3.6 Ensure bogus ICMP responses are ignored

enable_reverse_path_filtering() {
    # 3.3.7 Ensure Reverse Path Filtering is enabled
    echo "Enabling Reverse Path Filtering..."
    sudo sysctl -w net.ipv4.conf.all.rp_filter=1
    sudo sysctl -w net.ipv4.conf.default.rp_filter=1
    if [ $? -eq 0 ]; then
        echo "Reverse Path Filtering enabled successfully"
        return 0
    else
        echo "Failed to enable Reverse Path Filtering"
        return 1
    fi
}

enable_tcp_syn_cookies() {
    # 3.3.8 Ensure TCP SYN Cookies is enabled
    echo "Enabling TCP SYN Cookies..."
    sudo sysctl -w net.ipv4.tcp_syncookies=1
    if [ $? -eq 0 ]; then
        echo "TCP SYN Cookies enabled successfully"
        return 0
    else
        echo "Failed to enable TCP SYN Cookies"
        return 1
    fi
}

disable_ipv6_router_advertisements() {
    # 3.3.9 Ensure IPv6 router advertisements are not accepted
    echo "Disabling IPv6 router advertisements..."
    sudo sysctl -w net.ipv6.conf.all.accept_ra=0
    sudo sysctl -w net.ipv6.conf.default.accept_ra=0
    if [ $? -eq 0 ]; then
        echo "IPv6 router advertisements disabled successfully"
        return 0
    else
        echo "Failed to disable IPv6 router advertisements"
        return 1
    fi
}

network_parameters_host_and_router() {
    # 3.3 Network Parameters (Host and Router)
    disable_icmp_redirects
    disable_secure_icmp_redirects
    enable_logging_of_suspicious_packets
    ignore_broadcast_icmp_requests
    enable_reverse_path_filtering
    enable_tcp_syn_cookies
    disable_ipv6_router_advertisements
}

network_parameters_host_and_router

disable_dccp() {
    # 3.4.1 Ensure DCCP is disabled
    echo "Disabling DCCP..."
    sudo modprobe -n -v dccp | grep -E "install /bin/(true|false)" || echo "install dccp /bin/true" | sudo tee -a /etc/modprobe.d/CIS.conf
    sudo rmmod dccp
    if [ $? -eq 0 ]; then
        echo "DCCP disabled successfully"
        return 0
    else
        echo "Failed to disable DCCP"
        return 1
    fi
}

disable_sctp() {
    # 3.4.2 Ensure SCTP is disabled
    echo "Disabling SCTP..."
    sudo modprobe -n -v sctp | grep -E "install /bin/(true|false)" || echo "install sctp /bin/true" | sudo tee -a /etc/modprobe.d/CIS.conf
    sudo rmmod sctp
    if [ $? -eq 0 ]; then
        echo "SCTP disabled successfully"
        return 0
    else
        echo "Failed to disable SCTP"
        return 1
    fi
}

disable_rds() {
    # 3.4.3 Ensure RDS is disabled
    echo "Disabling RDS..."
    sudo modprobe -n -v rds | grep -E "install /bin/(true|false)" || echo "install rds /bin/true" | sudo tee -a /etc/modprobe.d/CIS.conf
    sudo rmmod rds
    if [ $? -eq 0 ]; then
        echo "RDS disabled successfully"
        return 0
    else
        echo "Failed to disable RDS"
        return 1
    fi
}

disable_tipc() {
    # 3.4.4 Ensure TIPC is disabled
    echo "Disabling TIPC..."
    sudo modprobe -n -v tipc | grep -E "install /bin/(true|false)" || echo "install tipc /bin/true" | sudo tee -a /etc/modprobe.d/CIS.conf
    sudo rmmod tipc
    if [ $? -eq 0 ]; then
        echo "TIPC disabled successfully"
        return 0
    else
        echo "Failed to disable TIPC"
        return 1
    fi
}

uncommon_network_protocols() {
    # 3.4 Uncommon Network Protocols
    disable_dccp
    disable_sctp
    disable_rds
    disable_tipc
}

uncommon_network_protocols

ensure_ufw_installed() {
    # 3.5.1.1 Ensure ufw is installed
    echo "Ensuring ufw is installed..."
    sudo apt-get install -y ufw
    if [ $? -eq 0 ]; then
        echo "ufw installed successfully"
        return 0
    else
        echo "Failed to install ufw"
        return 1
    fi
}

ensure_iptables_persistent_not_installed() {
    # 3.5.1.2 Ensure iptables-persistent is not installed with ufw
    echo "Ensuring iptables-persistent is not installed with ufw..."
    if dpkg -s iptables-persistent ufw | grep -E "Status:.*installed" >/dev/null; then
        sudo apt-get remove -y iptables-persistent
        echo "iptables-persistent removed successfully"
        return 0
    else
        echo "iptables-persistent is not installed with ufw"
        return 1
    fi
}

ensure_ufw_service_enabled() {
    # 3.5.1.3 Ensure ufw service is enabled
    echo "Ensuring ufw service is enabled..."
    sudo systemctl enable ufw
    if [ $? -eq 0 ]; then
        echo "ufw service enabled successfully"
        return 0
    else
        echo "Failed to enable ufw service"
        return 1
    fi
}

configure_ufw_loopback_traffic() {
    # 3.5.1.4 Ensure ufw loopback traffic is configured
    echo "Configuring ufw loopback traffic..."
    sudo ufw allow in on lo
    sudo ufw allow out on lo
    if [ $? -eq 0 ]; then
        echo "ufw loopback traffic configured successfully"
        return 0
    else
        echo "Failed to configure ufw loopback traffic"
        return 1
    fi
}

#! 3.5.1.5 is manual

ensure_ufw_firewall_rules_exist() {
    # 3.5.1.6 Ensure ufw firewall rules exist for all open ports
    echo "Ensuring ufw firewall rules exist for all open ports..."
    open_ports=$(sudo netstat -lnpt | awk '/^tcp/ {print $4}' | awk -F':' '{print $NF}' | sort -u)
    for port in $open_ports; do
        sudo ufw status | grep -q "$port/tcp" || sudo ufw allow "$port/tcp"
    done
    echo "ufw firewall rules configured successfully"
}

ensure_ufw_default_deny() {
    # 3.5.1.7 Ensure ufw default deny firewall policy
    echo "Ensuring ufw default deny firewall policy..."
    sudo ufw default deny incoming
    sudo ufw default deny outgoing
    if [ $? -eq 0 ]; then
        echo "ufw default deny firewall policy configured successfully"
        return 0
    else
        echo "Failed to configure ufw default deny firewall policy"
        return 1
    fi
}

configure_uncomplicated_firewall() {
    # 3.5.1 Uncomplicated Firewall Configuration
    ensure_ufw_installed
    ensure_iptables_persistent_not_installed
    ensure_ufw_service_enabled
    configure_ufw_loopback_traffic
    ensure_ufw_firewall_rules_exist
    ensure_ufw_default_deny
}

configure_uncomplicated_firewall

ensure_nftables_installed() {
    # 3.5.2.1 Ensure nftables is installed
    echo "Ensuring nftables is installed..."
    sudo apt-get install -y nftables
    if [ $? -eq 0 ]; then
        echo "nftables installed successfully"
        return 0
    else
        echo "Failed to install nftables"
        return 1
    fi
}

ensure_ufw_uninstalled_or_disabled_with_nftables() {
    # 3.5.2.2 Ensure ufw is uninstalled or disabled with nftables
    echo "Ensuring ufw is uninstalled or disabled with nftables..."
    if dpkg -s ufw | grep -E "Status:.*installed" >/dev/null; then
        sudo apt-get remove -y ufw
        echo "ufw removed successfully"
    fi
    if [ -f /etc/ufw/ufw.conf ]; then
        sudo sed -i 's/^ENABLED=yes/ENABLED=no/' /etc/ufw/ufw.conf
        echo "ufw disabled successfully"
    fi
    sudo systemctl stop ufw
    sudo systemctl disable ufw
    echo "ufw service stopped and disabled successfully"
}

#! 3.5.2.3 is manual

ensure_nftables_table_exists() {
    # 3.5.2.4 Ensure a nftables table exists
    echo "Ensuring a nftables table exists..."
    sudo nft add table inet filter
    if [ $? -eq 0 ]; then
        echo "nftables table created successfully"
        sudo nft list tables | grep -q "inet filter" && echo "nftables table exists"
        return 0
    else
        echo "Failed to create nftables table"
        return 1
    fi
}

ensure_nftables_base_chains_exist() {
    # 3.5.2.5 Ensure nftables base chains exist
    echo "Ensuring nftables base chains exist..."
    sudo nft add chain inet filter input { type filter hook input priority 0 \; }
    sudo nft add chain inet filter forward { type filter hook forward priority 0 \; }
    sudo nft add chain inet filter output { type filter hook output priority 0 \; }
    if [ $? -eq 0 ]; then
        echo "nftables base chains created successfully"
        return 0
    else
        echo "Failed to create nftables base chains"
        return 1
    fi
}

ensure_nftables_loopback_traffic() {
    # 3.5.2.6 Ensure nftables loopback traffic is configured
    echo "Ensuring nftables loopback traffic is configured..."
    sudo nft add rule inet filter input iif lo accept
    sudo nft add rule inet filter output oif lo accept
    if [ $? -eq 0 ]; then
        echo "nftables loopback traffic configured successfully"
        return 0
    else
        echo "Failed to configure nftables loopback traffic"
        return 1
    fi
}

#! Skip 3.5.2.7 Ensure nftables outbound and established connections are configured

ensure_nftables_default_deny() {
    # 3.5.2.8 Ensure nftables default deny firewall policy
    echo "Ensuring nftables default deny firewall policy..."
    sudo nft add rule inet filter input drop
    sudo nft add rule inet filter forward drop
    sudo nft add rule inet filter output drop
    if [ $? -eq 0 ]; then
        echo "nftables default deny firewall policy configured successfully"
        return 0
    else
        echo "Failed to configure nftables default deny firewall policy"
        return 1
    fi
}

ensure_nftables_service_enabled() {
    # 3.5.2.9 Ensure nftables service is enabled
    echo "Ensuring nftables service is enabled..."
    if sudo systemctl is-enabled nftables >/dev/null; then
        echo "nftables service is already enabled"
    else
        sudo systemctl enable nftables
        if sudo systemctl is-enabled nftables >/dev/null; then
            echo "nftables service enabled successfully"
        else
            echo "Failed to enable nftables service"
        fi
    fi
}

ensure_nftables_rules_permanent() {
    # 3.5.2.10 Ensure nftables rules are permanent
    echo "Ensuring nftables rules are permanent..."
    sudo nft list ruleset >/etc/nftables.conf
    if [ $? -eq 0 ]; then
        echo "nftables rules saved to /etc/nftables.conf"
        sudo systemctl enable nftables.service
        if [ $? -eq 0 ]; then
            echo "nftables service enabled at boot time"
            return 0
        else
            echo "Failed to enable nftables service at boot time"
            return 1
        fi
    else
        echo "Failed to save nftables rules to /etc/nftables.conf"
        return 1
    fi
}

configure_nftables() {
    # 3.5.2 Configure nftables
    ensure_nftables_installed
    ensure_ufw_uninstalled_or_disabled_with_nftables
    ensure_nftables_table_exists
    ensure_nftables_base_chains_exist
    ensure_nftables_loopback_traffic
    ensure_nftables_default_deny
    ensure_nftables_service_enabled
    ensure_nftables_rules_permanent
}

configure_nftables

ensure_iptables_installed() {
    # 3.5.3.1.1 Ensure iptables packages are installed
    echo "Ensuring iptables packages are installed..."
    sudo apt-get install -y iptables
    if [ $? -eq 0 ]; then
        echo "iptables packages installed successfully"
        return 0
    else
        echo "Failed to install iptables packages"
        return 1
    fi
}

# ensure_nftables_not_installed_with_iptables() {
#     # 3.5.3.1.2 Ensure nftables is not installed with iptables
#     echo "Ensuring nftables is not installed with iptables..."
#     if dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' nftables 2>/dev/null | grep -q "not-installed"; then
#         echo "nftables is not installed"
#         return 0
#     else
#         sudo apt purge nftables
#         if dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' nftables 2>/dev/null | grep -q "not-installed"; then
#             echo "nftables removed successfully"
#             return 0
#         else
#             echo "Failed to remove nftables"
#             return 1
#         fi
#     fi
# }

#! 3.5.3.1.2 and 3.5.3.1.3 don't make sense to me

configure_iptables() {
    # 3.5.3.1 Configure iptables software
    ensure_iptables_installed
    # ensure_nftables_not_installed_with_iptables
}

configure_iptables

ensure_ip6tables_installed() {
    # 3.5.3.3.1 Ensure ip6tables default deny firewall policy
    echo "Ensuring ip6tables is installed..."
    sudo apt-get install -y ip6tables
    if [ $? -eq 0 ]; then
        echo "ip6tables installed successfully"
    else
        echo "Failed to install ip6tables"
        return 1
    fi
}

configure_ip6tables_default_deny() {
    # 3.5.3.3.1 Ensure ip6tables default deny firewall policy
    echo "Configuring ip6tables..."
    sudo ip6tables -P INPUT DROP
    sudo ip6tables -P FORWARD DROP
    sudo ip6tables -P OUTPUT ACCEPT
    if [ $? -eq 0 ]; then
        echo "ip6tables default deny firewall policy configured successfully"
    else
        echo "Failed to configure ip6tables default deny firewall policy"
        return 1
    fi
}

configure_ip6tables_loopback_traffic() {
    # 3.5.3.3.2 Ensure ip6tables loopback traffic is configured
    echo "Configuring ip6tables loopback traffic..."
    sudo ip6tables -A INPUT -i lo -j ACCEPT
    sudo ip6tables -A OUTPUT -o lo -j ACCEPT
    if [ $? -eq 0 ]; then
        echo "ip6tables loopback traffic configured successfully"
    else
        echo "Failed to configure ip6tables loopback traffic"
        return 1
    fi
}

configure_ip6tables_open_ports() {
    # 3.5.3.3.4 Ensure ip6tables firewall rules exist for all open ports
    echo "Configuring ip6tables firewall rules for all open ports..."
    open_ports=$(netstat -ln6t | awk '/^tcp6/ {print $4}' | awk -F':' '{print $NF}' | sort -u)
    for port in $open_ports; do
        sudo ip6tables -A INPUT -p tcp --dport $port -j ACCEPT
        sudo ip6tables -A INPUT -p udp --dport $port -j ACCEPT
    done
    if [ $? -eq 0 ]; then
        echo "ip6tables firewall rules configured successfully for all open ports"
    else
        echo "Failed to configure ip6tables firewall rules for all open ports"
        return 1
    fi
}

configure_ipv6_ip6tables() {
    # 3.5.3.3 Configure IPv6 ip6tables
    configure_ip6tables_default_deny
    configure_ip6tables_loopback_traffic
    configure_ip6tables_open_ports
}

configure_ipv6_ip6tables
