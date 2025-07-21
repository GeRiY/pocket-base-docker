#!/bin/sh

# Create directories if they don't exist
mkdir -p pb_data
mkdir -p pb_hooks
mkdir -p pb_migrations

# Set permissions (owner can read/write/execute, others can read/execute)
chmod 755 pb_data
chmod 755 pb_hooks
chmod 755 pb_migrations

echo "Directories created and permissions set successfully:"
echo "- pb_data"
echo "- pb_hooks"
echo "- pb_migrations"