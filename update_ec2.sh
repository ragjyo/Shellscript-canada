#!/bin/bash

# Update the package list and upgrade installed packages
echo "Starting system update..."

# Detect the Linux distribution and run the appropriate update commands
if [ -f /etc/debian_version ]; then
    # For Ubuntu or Debian-based distributions
    echo "Detected Ubuntu/Debian system. Running apt update."
    sudo apt update -y && sudo apt upgrade -y
elif [ -f /etc/redhat-release ]; then
    # For Amazon Linux, RedHat, or CentOS distributions
    echo "Detected RedHat/CentOS system. Running yum update."
    sudo yum update -y
else
    echo "Unsupported Linux distribution."
    exit 1
fi

# Optionally, reboot if required
if [ -f /var/run/reboot-required ]; then
    echo "Reboot required. Rebooting now..."
    sudo reboot
else
    echo "No reboot required."
fi

echo "System update completed."

give permissions to execute the scripts
chmod +x update_ec2.sh

add the script in bashrc
nano ~/.bashrc  # For Ubuntu/Debian systems
~/update_ec2.sh
