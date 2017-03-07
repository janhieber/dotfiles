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

NAME='Arch Linux -ck EFISTUB'
DRIVE='/dev/sda'
BOOTPART=1
KERNEL='/EFI/arch/vmlinuz-linux-ck-haswell'
ROOT='UUID=4d4167d6-761e-4b5b-b92b-a803a7c95258'
RESUME='UUID=5c323946-60e1-4cfe-8e50-140a685f8648'
INITRD1='/EFI/arch/intel-ucode.img'
INITRD2='/EFI/arch/initramfs-linux-ck-haswell.img'
PARAMS='rw quiet'

# looking for old entry
OLD=$(efibootmgr | grep "$NAME" | cut -d' ' -f1 | sed -e 's/*//' -e 's/Boot//')
if [[ ${#OLD} -eq 4 ]]; then
  echo "== found old entry, deleting: $OLD"
  efibootmgr -b $OLD -B > /dev/null
fi

# building opts
ARGS=''
[[ ${#ROOT} -gt 2 ]] && ARGS="$ARGS root=$ROOT"
[[ ${#RESUME} -gt 2 ]] && ARGS="$ARGS resume=$RESUME"
[[ ${#INITRD1} -gt 2 ]] && ARGS="$ARGS initrd=$INITRD1"
[[ ${#INITRD2} -gt 2 ]] && ARGS="$ARGS initrd=$INITRD2"
[[ ${#PARAMS} -gt 2 ]] && ARGS="$ARGS $PARAMS"

# creating entry
efibootmgr -d $DRIVE -p $BOOTPART \
  -c -L "$NAME" -l "$KERNEL" -u "$ARGS"

