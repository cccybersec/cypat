#!/bin/bash

# Function to check for available system updates and security patches
check_updates() {
    echo "Checking for available updates and patches..."
    sudo apt update
    sudo apt list --upgradable
}

# Function to automate the process of installing updates and patches
install_updates() {
    echo "Installing updates and patches..."
    sudo apt upgrade -y
    sudo apt full-upgrade
}

autoremove_packages() {
    echo "Removing unused packages..."
    sudo apt autoremove
}

# Function to schedule regular system updates
#schedule_updates() {
#    echo "Scheduling regular system updates using crontab..."
#    # Add a cron job to run the update script daily at 3am
#    (
#        crontab -l
#        echo "0 3 * * * /bin/bash /path/to/updates.sh"
#    ) | crontab -
#}

#! idk y this is here
# Function to generate and display a report of the update process
# generate_report() {
#    echo "Generating update report..."
#    # Save the output of the update command to a file
#    sudo apt upgrade -y >update_report.txt
#    # Display the contents of the file
#    cat update_report.txt
#}

# Main function to run the script
main() {
    check_updates
    install_updates
    autoremove_packages
    #    generate_report
    #    schedule_updates
}

# Call the main function
main
