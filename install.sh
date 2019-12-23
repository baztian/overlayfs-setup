#!/bin/sh -x
set -e

# Backup
cp -v /boot/cmdline.txt /boot/cmdline.txt-orig
cp -v /etc/fstab /etc/fstab-orig

# Install scripts
cp -v utils/mount_overlay /utils/rootro /usr/local/bin/
ln -vs rootro /usr/local/bin/rootrw
cp -v services/saveoverlays /etc/init.d/
cp -v services/syncoverlayfs.service /etc/systemd/system/
sudo systemctl daemon-reload
systemctl enable syncoverlayfs.service

# Stop using swap
dphys-swapfile swapoff
dphys-swapfile uninstall
update-rc.d dphys-swapfile disable
systemctl disable dphys-swapfile

systemctl disable fake-hwclock.service
systemctl stop fake-hwclock.service
mv -v /etc/fake-hwclock.data /var/log/fake-hwclock.data
ln -vs /var/log/fake-hwclock.data /etc/fake-hwclock.data

# Setup fuse
apt install fuse lsof

# Change boot command line
...

