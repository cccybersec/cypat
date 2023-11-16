#!/bin/bash

# This script is used to manage user accounts on an Ubuntu system for a CyberPatriot competition.

# Function to create a new user account with a specified username and password.
create_user() {
    read -p "Enter the username: " username
    read -p "Enter the password: " password
    sudo useradd -m -p $(openssl passwd -1 $password) $username
    echo "User $username created successfully."
}

# Function to delete an existing user account based on a given username.
delete_user() {
    read -p "Enter the username to delete: " username
    sudo userdel -r $username
    echo "User $username deleted successfully."
}

# Function to list all user accounts on the system with their basic information.
list_users() {
    echo "List of all user accounts on the system:"
    echo "----------------------------------------"
    echo "USERNAME    USER ID    GROUP ID"
    echo "----------------------------------------"
    awk -F: '{printf "%-12s%-11s%s\n", $1, $3, $4}' /etc/passwd
}

# Main menu
while true; do
    echo "Select an option:"
    echo "1. Create a new user account"
    echo "2. Delete an existing user account"
    echo "3. List all user accounts"
    echo "4. Exit"
    read -p "Enter your choice: " choice
    case $choice in
    1) create_user ;;
    2) delete_user ;;
    3) list_users ;;
    4) exit ;;
    *) echo "Invalid choice. Please try again." ;;
    esac
done
