#!/bin/bash

# Update Flatpak
echo "Updating Flatpak..."
flatpak update -y

# Remove unused Flatpak
echo "Remove unused Flatpak..."
flatpak uninstall --unused

# Update DNF
echo "Updating DNF..."
pkexec dnf update -y

# Update bootctl
echo "Updating bootctl..."
pkexec bootctl update
pkexec kernel-install add $(uname -r) /lib/modules/$(uname -r)/vmlinuz


# Update fwupd
echo "Updating fwupd..."
systemctl unmask fwupd
systemctl start fwupd
fwupdmgr refresh
fwupdmgr get-devices 
fwupdmgr refresh --force
fwupdmgr get-updates 
fwupdmgr update -y

# Check if a reboot is required
if fwupdmgr get-updates | grep -q "reboot required"; then
    echo "A reboot is required for the updates to take effect."
    echo "Please reboot your system to complete the firmware update."
fi

echo "Stopping fwupd service..."
sudo systemctl stop fwupd
sudo systemctl mask fwupd

# Compacter les bases de données des navigateurs avec profile-cleaner
profile-cleaner f
profile-cleaner o


# Cleaning
echo "cleaning..."
pkexec dnf autoremove
pkexec dnf clean all
sudo bleachbit --preset -c
flatpak run io.github.giantpinkrobots.flatsweep
