#!/bin/bash

# Function to monitor system logs for specific events or patterns and generate a report
monitor_logs() {
    # Check if log files exist
    if [ ! -f /var/log/syslog ] || [ ! -f /var/log/auth.log ]; then
        echo "Log files not found."
        return 1
    fi

    # Search for specific events or patterns in log files
    echo "Searching for specific events or patterns in log files..."
    echo "Events related to SSH:"
    grep -i "ssh" /var/log/syslog /var/log/auth.log
    echo "Events related to sudo:"
    grep -i "sudo" /var/log/syslog /var/log/auth.log
    echo "Events related to failed login attempts:"
    grep -i "failed" /var/log/syslog /var/log/auth.log
}

# Function to analyze logs to identify and report any suspicious activities or security events
analyze_logs() {
    # Check if log files exist
    if [ ! -f /var/log/syslog ] || [ ! -f /var/log/auth.log ]; then
        echo "Log files not found."
        return 1
    fi

    # Analyze log files for suspicious activities or security events
    echo "Analyzing log files for suspicious activities or security events..."
    echo "Suspicious activities related to SSH:"
    grep -i "authentication failure" /var/log/syslog /var/log/auth.log
    echo "Suspicious activities related to sudo:"
    grep -i "incorrect password attempts" /var/log/syslog /var/log/auth.log
    echo "Suspicious activities related to failed login attempts:"
    grep -i "invalid user" /var/log/syslog /var/log/auth.log
}

# Function to display the size and last modification date of log files
display_log_info() {
    # Check if log files exist
    if [ ! -f /var/log/syslog ] || [ ! -f /var/log/auth.log ]; then
        echo "Log files not found."
        return 1
    fi

    # Display size and last modification date of log files
    echo "Size and last modification date of log files:"
    ls -lh /var/log/syslog /var/log/auth.log
}

# Function to compress and archive log files to save disk space
compress_logs() {
    # Check if log files exist
    if [ ! -f /var/log/syslog ] || [ ! -f /var/log/auth.log ]; then
        echo "Log files not found."
        return 1
    fi

    # Compress and archive log files
    echo "Compressing and archiving log files..."
    tar -czvf log_archive.tar.gz /var/log/syslog /var/log/auth.log
    echo "Log files compressed and archived successfully."
}

# Main function to execute the script
main() {
    # Call functions to monitor logs, analyze logs, display log info, and compress logs
    monitor_logs
    analyze_logs
    display_log_info
    compress_logs
}

# Call main function
main
