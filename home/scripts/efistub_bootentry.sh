#!/bin/bash

# My boot is mounted as: /dev/sda1 -> /boot/efi
# The path on -l parameter is relative to boot mount point.
# So on my system the file would be in: /boot/efi/EFI/arch/vmlinuz-linux
# If yours is different, change it

# Use blkid to find the UUID of your root partition.

# Use the systemd service files to automatically copy this stuff to
# boot partition. When your boot is mounted different from mine,
# fix the paths in the files.
# https://github.com/janhieber/dotfiles/tree/master/root/etc/systemd/system

# If you have a Intel CPU, install intel-ucode! Otherwise remove
# it from the cmdline below.

efibootmgr -d /dev/sda \
  -p 1 -c -L "Arch Linux EFISTUB" \
  -l /EFI/arch/vmlinuz-linux \
  -u "root=UUID=4d4167d6-761e-4b5b-b92b-a803a7c95258 rw initrd=/EFI/arch/intel-ucode.img initrd=/EFI/arch/initramfs-linux.img" 

