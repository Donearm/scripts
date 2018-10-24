#!/bin/sh

# Restore the EFI boot menu after updating its version. Only the entries
# that I care, of course

EFIBOOTMGR=$(which efibootmgr)
DEV="/dev/sda"

$EFIBOOTMGR -c -g -d $DEV -p 1 -w -L "Windows8" -l '\EFI\Microsoft\Boot\bootmgfw.efi'
$EFIBOOTMGR -c -g -d $DEV -p 1 -w -L "rEFInd" -l '\EFI\refind\refind_x64.efi'
$EFIBOOTMGR -c -g -d $DEV -p 1 -w -L "Grub" -l '\EFI\arch_grub\grubx64_standalone.efi'

exit 0
