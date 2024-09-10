#!/bin/bash

# Variables
LOGFILE="/var/log/syslog.1"       # Path to the log file you want to back up
BACKUP_DIR="/backup"            # Path to the directory where you want to save the backup
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")  # Timestamp to append to the backup file for uniqueness
BACKUP_FILE="${BACKUP_DIR}/syslog_${TIMESTAMP}.gz"  # Full path of the compressed backup file

# Check if backup directory exists, if not, create it
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Backup directory does not exist. Creating it..."
    mkdir -p "$BACKUP_DIR"
fi

# Check if the log file exists
if [ -f "$LOGFILE" ]; then
    # Compress the log file and move it to the backup directory
    echo "Compressing and backing up the log file..."
    gzip -c "$LOGFILE" > "$BACKUP_FILE"
    
    # Check if the compression was successful
    if [ $? -eq 0 ]; then
        # Delete the original log file
        echo "Deleting the original log file..."
        rm "$LOGFILE"
        echo "Backup complete! Log file has been saved as $BACKUP_FILE"
    else
        echo "Error: Failed to compress the log file."
    fi
else
    echo "Log file $LOGFILE does not exist."
fi
