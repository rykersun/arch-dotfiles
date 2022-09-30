sudo timedatectl set-ntp true
sudo timedatectl set-timezone Asia/Taipei
sudo timedatectl set-local-rtc 1
sudo os-prober
sudo grub-mkconfig -o /boot/grub/grub.cfg
