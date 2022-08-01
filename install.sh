mkdir -p /home/$USER/.config/

# Install software on arch
while getopts ":a" option; do
    case $option in
        a) fullinstall();;
    esac
done

function fullinstall() {
    # Yay
    sudo pacman -S --needed git base-devel;
    cd ~ && git clone https://aur.archlinux.org/yay.git;
    cd yay;
    makepkg -si;
    yay -Y --gendb;
    yay -Syu --devel;

    # DHCP daemon for internet
    yay -S dhcpcd
    sudo systemctl enable dhcpcd --now
    # Window Manager
    yay -S lightdm lightdm-gtk-greeter xorg bspwm sxhkd feh rofi polybar
    # Other packages
    yay -S neovim alacritty firefox ttf-hack tmux
}

# Neovim
rm /home/$USER/.config/nvim
ln -s /home/$USER/dotfiles/nvim /home/$USER/.config/nvim

# Window Manager bspwm
rm /home/$USER/.config/bspwm
ln -s /home/$USER/dotfiles/bspwm /home/$USER/.config/bspwm
rm /home/$USER/.config/sxhkd
ln -s /home/$USER/dotfiles/sxhkd /home/$USER/.config/sxhkd
rm /home/$USER/.config/rofi
ln -s /home/$USER/dotfiles/rofi /home/$USER/.config/rofi
rm /home/$USER/.config/polybar
ln -s /home/$USER/dotfiles/polybar /home/$USER/.config/polybar

# Alacritty
rm /home/$USER/.config/alacritty
ln -s /home/$USER/dotfiles/alacritty /home/$USER/.config/alacritty

# Tmux
ln -s /home/$USER/dotfiles/.tmux.conf /home/$USER/.tmux.conf
rm /home/$USER/.tmux
ln -s /home/$USER/dotfiles/tmux /home/$USER/.tmux
cd ~/.tmux && git submodule init && git submodule update && cd -
tmux source-file /home/$USER/.tmux.conf

# Bash
mv ~/.bashrc ~/.bashrc.bak
ln -s /home/$USER/dotfiles/.bashrc /home/$USER/.bashrc
source /home/$USER/.bashrc

# Xprofile
ln -s /home/$USER/dotfiles/.xprofile /home/$USER/.xprofile
