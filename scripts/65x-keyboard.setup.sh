#!/bin/bash
echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode
echo "options hid_apple fnmode=0" | sudo tee /etc/modprobe.d/hid_apple.conf
echo 'install_items+=/etc/modprobe.d/hid_apple.conf' | sudo tee /etc/dracut.conf.d/hid_apple.conf
sudo dracut --force