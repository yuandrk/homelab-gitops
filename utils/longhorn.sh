#!/bin/bash

# Update package list and upgrade installed packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install necessary packages
sudo apt-get install -y bash curl util-linux grep gawk blkid open-iscsi

# Ensure the iscsid daemon is running
sudo systemctl enable iscsid
sudo systemctl start iscsid

# Verify installations
echo "Verifying installations..."
for cmd in bash curl findmnt grep awk blkid iscsiadm; do
    if ! command -v $cmd &> /dev/null; then
        echo "$cmd could not be found"
    else
        echo "$cmd is installed"
    fi
done

# Check the status of the iscsid daemon
echo "Checking iscsid status..."
sudo systemctl status iscsid | grep "Active: active (running)"
if [ $? -eq 0 ]; then
    echo "iscsid is running"
else
    echo "iscsid is not running. Please check the service status."
fi

echo "Node preparation is complete."
