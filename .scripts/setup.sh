pacman -S alsa-plugins alsa-utils bison broadcom-wl-dkms bspwm cifs-utils compton conky ctags curl dkms dosfstools dunst fcron feh figlet filezilla firefox flac flex gimp gnupg gnutls grub gsimplecal gvim htop imagemagick iw keepassc linux-api-headers linux-firmware linux-headers linux-lts linux-lts-headers lm_sensors mesa mono mpv nodejs npm ntfs-3g openssh openssl pass pavucontrol pulseaudio pulseaudio-alsa pulseaudio-equalizer qtox ranger rofi rxvt-unicode rxvt-unicode-terminfo smbclient subversion sudo sxhkd terminus-font the_silver_searcher thunderbird toxcore unzip w3m wireless_tools wmctrl wpa_supplicant xclip xdg-utils xf86-input-libinput xf86-video-ati xf86-video-intel xf86-video-nouveau xf86-video-vesa xorg-server xorg-xinit zsh git

cd /tmp
mkdir aur-things
cd aur-things
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

yay -S gotwitch noto-fonts otf-overpass polybar skypeforlinux-bin spotify ttf-font-awesome

cd /tmp
mkdir new-home
cd new-home
git clone https://github.com/deluxo/dots
mv dots/* ~/

git clone --recursive -j8 git://github.com/Deluxo/vim.git
mkdir -p ~/.vim
mv vim/* ~/.vim/
ln -s $HOME/.vim/.vimrc $HOME/.vimrc

echo 'probably miserably failed, but hey, im done.'
