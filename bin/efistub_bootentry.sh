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

NAME='Arch Linux EFISTUB'
DRIVE='/dev/sda'
BOOTPART=1
KERNEL='/vmlinuz-linux'
ROOT='/dev/mapper/cryptoroot'
#RESUME='/dev/mapper/cryptoswap'
INITRD1='/intel-ucode.img'
INITRD2='/initramfs-linux.img'
PARAMS='rw quiet'

# looking for old entry
OLD=$(efibootmgr | grep "$NAME" | cut -d' ' -f1 | sed -e 's/*//' -e 's/Boot//')
if [[ ${#OLD} -eq 4 ]]; then
  echo "== found old entry, deleting: $OLD"
  efibootmgr -b $OLD -B > /dev/null
fi

# building opts
ARGS=''
ARGS="$ARGS cryptdevice=UUID=005905ff-273c-4a3a-9ed5-b2b6f2d0d71b:cryptoroot:allow-discards"
[[ ${#ROOT} -gt 2 ]] && ARGS="$ARGS root=$ROOT"
[[ ${#RESUME} -gt 2 ]] && ARGS="$ARGS resume=$RESUME"
[[ ${#INITRD1} -gt 2 ]] && ARGS="$ARGS initrd=$INITRD1"
[[ ${#INITRD2} -gt 2 ]] && ARGS="$ARGS initrd=$INITRD2"
[[ ${#PARAMS} -gt 2 ]] && ARGS="$ARGS $PARAMS"

# creating entry
efibootmgr -d $DRIVE -p $BOOTPART \
  -c -L "$NAME" -l "$KERNEL" -u "$ARGS"

