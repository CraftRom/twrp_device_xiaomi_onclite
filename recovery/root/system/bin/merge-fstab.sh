#!/system/bin/sh

echo >> /system/etc/recovery.fstab
cat /system/etc/recovery.fstab.device >> /system/etc/recovery.fstab
