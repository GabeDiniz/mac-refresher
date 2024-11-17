#!/bin/bash

# Notes
# 2>/dev/null - surpresses error messages

# Function to safely remove files/directories
safe_remove() {
  # Check if the file is a dir or a file
  if [ -d "$1" ] || [ -f "$1" ]; then
    # Attempt to remove the dir/file
    rm -rf "$1" 2>/dev/null || echo "Skipped protected location: $1"
  fi
}

# Clear User Caches
echo "Clearing user caches..."
for cache_dir in ~/Library/Caches/*; do
  safe_remove "$cache_dir"
done

# Clear System Caches (SIP-protected areas are skipped)
echo "Clearing system caches..."
sudo rm -rf /Library/Caches/* 2>/dev/null || echo "Skipped SIP-protected caches."

# Clear Logs
echo "Clearing logs..."
rm -rf ~/Library/Logs/* 2>/dev/null || echo "Skipped protected logs."
sudo rm -rf /var/log/* 2>/dev/null || echo "Skipped SIP-protected logs."

# Remove Temporary Files
echo "Removing temporary files..."
sudo rm -rf /private/var/folders/* 2>/dev/null || echo "Skipped SIP-protected temporary files."

# Flush DNS Cache
echo "Flushing DNS cache..."
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

# Clear Application Saved States
echo "Clearing saved states for applications..."
rm -rf ~/Library/Saved\ Application\ State/* 2>/dev/null || echo "Skipped protected saved states."

# Run macOS Maintenance Scripts
echo "Running macOS maintenance scripts..."
sudo periodic daily weekly monthly

# Restart Finder and Dock
echo "Restarting Finder and Dock..."
killall Finder
killall Dock

echo "Cleanup completed! You may consider restarting your Mac for further optimization."
