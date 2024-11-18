#!/bin/bash

# SSH_PASSWORD requirement check
: ${SSH_PASSWORD:?"Error: SSH_PASSWORD environment variable is required."}

# Set the password for the root user
echo "root:$SSH_PASSWORD" | chpasswd
echo "Password for root user set"

# Start the SSH server
echo "Starting SSH server..."
exec /usr/sbin/sshd -D
