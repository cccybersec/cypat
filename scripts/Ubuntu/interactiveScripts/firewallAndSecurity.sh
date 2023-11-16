#!/bin/bash

# Function to allow incoming traffic for a specific port
function allow_incoming_traffic() {
    sudo ufw allow $1
    echo "Incoming traffic allowed for port $1"
}

# Function to deny incoming traffic for a specific port
function deny_incoming_traffic() {
    sudo ufw deny $1
    echo "Incoming traffic denied for port $1"
}

# Function to allow outgoing traffic for a specific port
function allow_outgoing_traffic() {
    sudo ufw allow out $1
    echo "Outgoing traffic allowed for port $1"
}

# Function to deny outgoing traffic for a specific port
function deny_outgoing_traffic() {
    sudo ufw deny out $1
    echo "Outgoing traffic denied for port $1"
}

# Function to display the current firewall rules and status
function display_firewall_status() {
    sudo ufw status verbose
}

# Function to check for open ports on the system and display a list of services associated with those ports
function check_open_ports() {
    sudo netstat -tuln | awk '{print $4}' | awk -F ":" '{print $NF}' | sort -u | while read port; do
        service=$(sudo lsof -i :$port | awk '{print $1}' | tail -n 1)
        echo "Port $port is open and is associated with the $service service"
    done
}

# Function to monitor and display active network connections
function monitor_network_connections() {
    sudo watch -n 1 netstat -tan
}

# Function to check the system's SELinux or AppArmor status and, if applicable, configure its settings
function check_selinux_apparmor() {
    if [ -f /etc/selinux/config ]; then
        echo "SELinux is installed on this system"
        sudo cat /etc/selinux/config
        sudo setenforce 1
    fi
    if [ -f /etc/apparmor/parser.conf ]; then
        echo "AppArmor is installed on this system"
        sudo aa-status
        sudo aa-enforce /etc/apparmor.d/*
    fi
    if [ ! -f /etc/selinux/config ] && [ ! -f /etc/apparmor/parser.conf ]; then
        echo "Neither SELinux nor AppArmor is installed on this system"
        sudo apt install selinux-utils apparmor-utils
    fi
}

# Main menu
while true; do
    echo "Please select an option:"
    echo "1. Allow incoming traffic for a specific port"
    echo "2. Deny incoming traffic for a specific port"
    echo "3. Allow outgoing traffic for a specific port"
    echo "4. Deny outgoing traffic for a specific port"
    echo "5. Display current firewall rules and status"
    echo "6. Check for open ports and associated services"
    echo "7. Monitor active network connections"
    echo "8. Check SELinux or AppArmor status"
    echo "9. Exit"
    read -p "Enter your choice: " choice

    case $choice in
    1)
        read -p "Enter the port number: " port
        allow_incoming_traffic $port
        ;;
    2)
        read -p "Enter the port number: " port
        deny_incoming_traffic $port
        ;;
    3)
        read -p "Enter the port number: " port
        allow_outgoing_traffic $port
        ;;
    4)
        read -p "Enter the port number: " port
        deny_outgoing_traffic $port
        ;;
    5) display_firewall_status ;;
    6) check_open_ports ;;
    7) monitor_network_connections ;;
    8) check_selinux_apparmor ;;
    9) exit ;;
    *) echo "Invalid choice. Please try again." ;;
    esac
done
