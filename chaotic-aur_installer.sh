FILE=/etc/pacman.conf

if grep -Fxq "[chaotic-aur]" $FILE; then
    # print erro message if chaotic-aur is already in /etc/pacman.conf
    echo "ERROR! chaotic-aur is already in your /etc/pacman.conf";
    echo "Quit."
else
    # Install chaotic-aur repo.
    sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key FBA220DFC880C036
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

    # Add chaotic-aur repo.
    sudo sh -c "echo [chaotic-aur] >> /etc/pacman.conf"
    sudo sh -c "echo Include = /etc/pacman.d/chaotic-mirrorlist >> /etc/pacman.conf"

    # Update pacman.
    sudo pacman -Syy
fi
