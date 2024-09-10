#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root!" >&2
    exit 1
fi

# Define the file containing the list of usernames
USERFILE="userlist.txt"

# Check if the userlist file exists
if [ ! -f "$USERFILE" ]; then
    echo "User list file ($USERFILE) not found!" >&2
    exit 1
fi

# Loop through each line in the file (each username)
while IFS= read -r username; do
    # Check if user already exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists. Skipping."
    else
        # Create the user
        useradd -m "$username"
        if [ $? -eq 0 ]; then
            echo "User $username has been added to the system."

            # Set an initial password (change 'Password123' to any default password)
            echo "$username:Password123" | chpasswd

            # Force the user to change their password on first login
            passwd --expire "$username"
        else
            echo "Failed to create user $username."
        fi
    fi
done < "$USERFILE"

echo "User creation process is complete."
