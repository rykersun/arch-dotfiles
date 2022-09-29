DEVICE_NAME="$(ls /sys/class/net | grep enp)"
sed -i "s/DEVICE_NAME/$DEVICE_NAME/g" wired.ini
