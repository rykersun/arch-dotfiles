# 前言

這篇文章會慢慢寫，我會盡量把每個步驟要注意的事情都記錄清楚，也希望能夠幫助到正在看這篇文章的你。

# 安裝 Linux 之前需要知道的事情

首先，Linux 沒有 C 槽跟 D 槽，但是有以下幾個常見的分區。

## non-UEFI
* swap
* root
* home

## UEFI
* ESP Partition
* swap
* root
* home

目前大部分的電腦都有 UEFI，只有少部分比較老的電腦沒有 UEFI。

# 製作 Arch Linux Live USB

安裝任何 Linux 之前都應該要先製作它的 Live USB。

## Windows

可以使用 [Rufus](https://rufus.ie/zh_TW/) 製作

## Mac/Linux

可以使用 [Etcher](https://www.balena.io/etcher/) 製作

# BIOS 注意事項

到 BIOS 設定以下兩件事情

* 停用安全啟動 (Disable Secure Boot)
* 開機順序設定成優先使用 USB 開機

# 進入 Arch Installer

OK，現在終於可以正式開始安裝了，以下的安裝順序建議不要跳過，如果一步一步照著做，應該不會有問題。

# 調整字體

如果你覺得安裝程式的字體太小，可以使用這個指令將字體調大。

```
setfont ter-132n
```

# 確認是否有 UEFI

如果這個位置存在，就代表有 UEFI。

```
ls /sys/firmware/efi/efivars
```

這個步驟將決定之後是否要建立 ESP Partition。

# Swap 要多大?

這要看你的 RAM 有多大，使用這個指令可以查看 RAM 的大小。

```
free -th
```

如果你的 RAM <= 2GB，那你的 swap 大小應該是 RAM * 2。
如果你的 RAM > 2GB，那你的 swap 大小應該是 RAM + 2。

e.g. 我的筆電 RAM 是 8GB，那我的 swap 大小應該是 8 + 2 = 10GB。

# 建立分區

使用 `cfdisk` 這個指令來建立分區。

```
cfdisk device
```

## non-UEFI

建立以下分區。

|  Name   | Size  | Type  |
|  ----  | ----  | ----  |
| swap  | RAM + 2 | Linux swap |
| root  | >=20GB | Linux root (x86-64) |
| home  | 自由決定 | Linux home |

設定完記得要 Write && Quit。

## UEFI

建立以下分區。

|  Name   | Size  | Type  |
|  ----  | ----  | ----  |
| ESP Partition  | 512MB | EFI System |
| swap  | RAM + 2 | Linux swap |
| root  | >=20GB | Linux root (x86-64) |
| home  | 自由決定 | Linux home |

設定完記得要 Write && Quit。

# 設定分區格式

接下來要設定分區的格式，假設分區的代號如下。

|  Name   | Device  |
|  ----  | ----  |
| ESP Partition  | /dev/sda1 |
| swap  | /dev/sda2 |
| root  | /dev/sda3 |
| home  | /dev/sdb1 |

## 指令

```
mkfs.vfat /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sdb1
```

## 補充

> mkfs.vfat 會自動設定分區的格式，當分區 >= 512MB 的時候會設定成 fat32

## non-UEFI 設定分區格式

如果是 non-UEFI 的話，只需要設定 swap、root 跟 home 就好 **(省略 mkfs.vfat)**

# mount

non-UEFI 不需要建立 `/boot/efi`

## non-UEFI

步驟如下。

* mount root 到 `/mnt`
* 在 `/mnt` 上建立 `/home`
* mount home 到 `/mnt/home`

### 指令

```
mount /dev/sda3 /mnt
mkdir /mnt/home
mount /dev/sdb1 /mnt/home
```

## UEFI

步驟如下。

* mount root 到 `/mnt`
* 在 `/mnt` 上建立 `/boot/efi`
* mount ESP Partition 到 `/mnt/boot/efi`
* 在 `/mnt` 上建立 `/home`
* mount home 到 `/mnt/home`

### 指令

```
mount /dev/sda3 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
mkdir /mnt/home
mount /dev/sdb1 /mnt/home
```

# 網路設定

建議還是使用有線網路安裝。

## 有線網路

不用設定，使用這個指令可以測試網路。

```
ping google.com
```

如果有 64 bytes from google.com 就表示網路沒問題。

## 無線網路

使用 `iwctl` 來設定無線網路

```
iwctl
device list
station device_name scan
station device_name get-networks
station device_name connect SSID
```

# 時間設定

使用 `timedatectl` 來設定時間

```
timedatectl set-ntp true
timedatectl set-timezone Asia/Taipei
```

# 安裝 Linux

使用 `pacstrap` 來安裝 Linux 到 /mnt

```
pacstrap /mnt base linux linux-firmware
```

# 建立 fstab

```
genfstab -U /mnt >> /mnt/etc/fstab
```

# change root 到系統

使用 `arch-chroot` 到系統。

```
arch-chroot /mnt
```

如果 prompt 變成全白，就代表已經在剛剛安裝的系統上了。

# 設定語言

```
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "zh_TW.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
```

執行 locale-gen

```
locale-gen
```

# 設定 hostname

幫你的 Arch Linux 取一個名字。

```
echo rykersun-arch > /etc/hostname
```

# 建立 hosts

```
touch /etc/hosts
```

## 安裝 vim

使用 `pacman` 來安裝 vim

```
pacman -S vim
```

## 編輯 hosts

用 vim 開啟 `/etc/hosts` 並輸入以下內容

```
127.0.0.1    localhost
::1          localhost
127.0.0.1    rykersun-arch
```

### 注意

> rykersun-arch 要改成剛剛設定的 hostname

如果不想使用 vim，也可以直接用 nano 編輯。

# 設定 root 密碼

使用 `passwd` 來設定 root 密碼。

```
passwd
```

輸入的密碼不會顯示在螢幕上，輸入完直接 Enter 就好。

# 安裝 grub

non-UEFI 與 UEFI 的安裝方法不同。

## non-UEFI

首先使用 `pacman` 安裝 `grub` 跟 `os-prober`。

```
pacman -S grub
```

執行 os-prober 來偵測其他的作業系統。

```
os-prober
```

安裝 grub **(只要指定磁碟就好，不需要加數字)**。

```
grub-install /dev/sda
```

接下來使用 vim 開啟 `/etc/default/grub` 並將以下這行取消註解。

```
#GRUB_DISABLE_OS_PROBER=false
```

最後使用這個指令來生成 grub config 檔。

```
grub-mkconfig -o /boot/grub/grub.cfg
```

這樣就完成了。

## UEFI

首先使用 `pacman` 安裝 `grub`、`efibootmgr` 跟 `os-prober`。

```
pacman -S grub efibootmgr os-prober
```

執行 os-prober 來偵測其他的作業系統。

```
os-prober
```

安裝 grub。

```
grub-install --target=x86_64-efi --bootloader-id=ARCH_GRUB --efi-directory=/boot/efi
```

接下來使用 vim 開啟 `/etc/default/grub` 並將以下這行取消註解。

```
#GRUB_DISABLE_OS_PROBER=false
```

最後使用這個指令來生成 grub config 檔。

```
grub-mkconfig -o /boot/grub/grub.cfg
```

這樣就完成了。

# 設定使用者

使用 `pacman` 安裝 sudo。

```
pacman -S sudo
```

使用這個指令建立使用者 sun。

```
useradd -m sun
```

## 注意

> 把 sun 改成你的使用者名稱

使用 `passwd` 設定使用者的密碼。

```
passwd sun
```

設定群組。

```
usermod -aG wheel,audio,video,storage sun
```

## 注意

> 請用逗號隔開，不要輸入空白鍵。

編輯 visudo。

```
visudo
```

將下面這行取消註解。

```
# %wheel ALL=(ALL) ALL
```

# 安裝 NetworkManager

使用 `pacman` 安裝 NetworkManager。

```
pacman -S networkmanager
```

啟用 NetworkManager.service

```
systemctl enable NetworkManager
```

# 安裝顯示卡驅動程式

## Nvidia (Open Source)

```
sudo pacman -S xf86-video-nouveau
```

## Nvidia (Proprietary)

```
sudo pacman -S nvidia nvidia-utils
```

恭喜你，這樣就安裝完成了。

# 最後的步驟

首先離開 arch-chroot。

```
exit
```

接下來 umount `/mnt`

```
umount -l /mnt
```

最後重新啟動。

```
reboot
```

## 注意

> 重開機的時候別忘了拔出 USB，才不會又進入到安裝程式。

# nmcli 無線網路設定

如果是使用無線網路的話，可以透過以下指令來連接網路。

```
nmcli radio wifi
nmcli radio on
nmcli device wifi list
nmcli device wifi connect --ask SSID
```

# 測試筆記

後來測試這篇文章的內容發現時間和 grub 有點小問題

以下紀錄如何排除問題

## 時間

建議再打一次以下指令來確保時間沒有問題

```
timedatectl set-ntp true
timedatectl set-timezone Asia/Taipei
```

## Grub

後來發現 os-prober 似乎沒有偵測到其他的作業系統

於是我就在重新打了以下的指令 (步驟跟之前一樣)

> 請確保已經修改過 /etc/default/grub

```
sudo os-prober

sudo grub-mkconfig -o /boot/grub/grub.cfg
```

All right, you are good to go.

# 安裝完要做的事情

這邊整理了一些安裝完要做的事情。

## 安裝桌面環境

### gnome

```
sudo pacman -S xorg gnome
```

enable gdm

```
sudo systemctl enable gdm
```

reboot

```
sudo reboot
```

### i3

安裝 i3。

```
sudo pacman -S xorg i3 dmenu xorg-xinit
```

i3 可以選擇 i3-gaps **(視窗之間有縫隙)**。

安裝 pulseaudio。

```
sudo pacman -S pulseaudio
```

建立 .xinitrc

```
cp /etc/X11/xinit/xinitrc ~/.xinitrc
```

刪除最後五行並加入以下內容。

```
exec i3
```

這樣下次登入 tty 的時候只要執行 `startx` 就會啟動 i3 了。

### display manager

這邊推薦 ly 或是 lightdm

ly

> ly 需從 AUR 安裝, 可以參考後面的 yay

```
sudo pacman -S ly
```

enable ly

```
sudo systemctl enable ly
```

lightdm

這個的話就不用從 AUR 安裝了, 直接 pacman 就可

```
sudo pacman -S lightdm lightdm-gtk-greeter
```

enable

```
sudo systemctl enable lightdm
```

這樣重開機之後應該就會看到登入畫面了 (極度醜陋)

> 我之後還會整理一篇完整設定 i3 的文章, 敬請期待!

### i3 炫耀圖

![](https://static.coderbridge.com/img/rykersun/6a58a829757e40009bd8695d6cc2b498.png)

![](https://static.coderbridge.com/img/rykersun/69a95af54bd74e8b9129f0772a4f49ed.png)

## 中文字體出現一堆 "口口口"

### gnome

如果你發現中文字體像下面這樣無法正常顯示，就代表沒有安裝中文字體。

![](https://static.coderbridge.com/img/rykersun/4e09c6ccf41c4a55a69dbc784b676805.png)

安裝 `noto-fonts`, `noto-fonts-cjk`, `noto-fonts-emoji-git`, `gnome-tweaks`。

```
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji-git gnome-tweaks
```

之後使用 tweaks 把字體更改成 `cjk tc bold` 應該就解決了。

![](https://static.coderbridge.com/img/rykersun/5d4642cabf1e4598b302c79e9e1309a2.png)

## 輸入法

安裝 fcitx5 輸入法。

```
sudo pacman -S fcitx5 fcitx5-im fcitx5-chinese-addons fcitx5-configtool fcitx5-chewing
```

打開 fcitx5-configtool 並加入注音。

![](https://static.coderbridge.com/img/rykersun/bad5ecbcee12429bbb92e9fef687d833.png)

修改 environment

```
sudo vim /etc/environment
```

加入以下內容

```
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
```

## 安裝 bash 自動補齊

```
sudo pacman -S bash-completion
```

## 安裝 yay

首先安裝 `base-devel` 與 `git`。

```
sudo pacman -S base-devel git
```

clone `yay-bin` from AUR

```
git clone https://aur.archlinux.org/yay-bin.git
```

install `yay-bin`

```
cd yay-bin/

makepkg -si
```

# 分享全新乾淨的 Arch Linux

這邊附上全新乾淨的 Arch Linux 照片。

![](https://static.coderbridge.com/img/rykersun/5a52e96913704b23ab766323a5892de2.png)

# 參考資料

* https://hackmd.io/@PIFOPlfSS3W_CehLxS3hBQ/r1xrYth9V
* https://jute.pw/linux/fcitx5-with-chewing-on-linux/
* https://itsfoss.com/install-arch-linux/
* https://wiki.archlinux.org/title/installation_guide
