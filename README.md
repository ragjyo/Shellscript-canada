update_ec2.sh
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







Run the following command to make the script executable:
chmod +x update_ec2.sh



To ensure the script runs automatically after login, you can modify the .bashrc (for Ubuntu/Debian) or .bash_profile (for RedHat/CentOS) file of the user you use to login.
nano ~/.bashrc  # For Ubuntu/Debian systems



At the end of the file, add the following line to execute the update script automatically:
~/update_ec2.sh

        
