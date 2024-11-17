#!/bin/bash

# Clear User Caches
echo "Clearing user caches..."
rm -rf ~/Library/Caches/*

# Clear System Caches (SIP-protected areas are skipped)
echo "Clearing system caches..."
sudo rm -rf /Library/Caches/* 2>/dev/null || echo "Skipped SIP-protected caches."

# Clear Logs
echo "Clearing logs..."
rm -rf ~/Library/Logs/*
sudo rm -rf /var/log/* 2>/dev/null || echo "Skipped SIP-protected logs."

# Remove Temporary Files (Handles SIP restrictions)
echo "Removing temporary files..."
sudo rm -rf /private/var/folders/* 2>/dev/null || echo "Skipped SIP-protected temporary files."

# Flush DNS Cache
echo "Flushing DNS cache..."
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

# Clean Application Saved States
echo "Clearing saved states for applications..."
rm -rf ~/Library/Saved\ Application\ State/*

# Run macOS Maintenance Scripts
echo "Running macOS maintenance scripts..."
sudo periodic daily weekly monthly

# Restart Finder and Dock
echo "Restarting Finder and Dock..."
killall Finder
killall Dock

echo "Cleanup completed! You may consider restarting your Mac for further optimization."
