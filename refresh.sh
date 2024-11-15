#!/bin/bash

# Clear System and User Caches
echo "Clearing system and user caches..."
sudo rm -rf /Library/Caches/*
rm -rf ~/Library/Caches/*

# Clear System Logs
echo "Clearing system logs..."
sudo rm -rf /var/log/*
rm -rf ~/Library/Logs/*

# Remove Temporary Files
echo "Removing temporary files..."
sudo rm -rf /private/var/folders/*

# Flush DNS Cache
echo "Flushing DNS cache..."
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

# Clear Application Saved States
echo "Clearing saved states for applications..."
rm -rf ~/Library/Saved\ Application\ State/*

# Remove Old iOS Backups
echo "Removing old iOS backups..."
rm -rf ~/Library/Application\ Support/MobileSync/Backup/*

# Clean up Homebrew cache if installed
if command -v brew &> /dev/null
then
  echo "Cleaning up Homebrew cache..."
  brew cleanup -s
  rm -rf "$(brew --cache)"
fi

# Run macOS maintenance scripts
echo "Running macOS maintenance scripts..."
sudo periodic daily weekly monthly

# Restart Finder and Dock to free up memory
echo "Restarting Finder and Dock..."
killall Finder
killall Dock

echo "Cleanup completed! You may consider restarting your Mac for further optimization."