#!/usr/bin/env bash

function fullinstallubuntu {
    # essential packages
    sudo apt-get install gcc tmux curl tar build-essential make cmake gdb -y
    # Window Manager
    sudo apt-get install bspwm sxhkd feh rofi polybar -y
    # Fonts etc.
    sudo apt-get install fonts-hack-ttf

    curl -L https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.tar.gz -o $HOME/nvim-linux64.tar.gz
    tar xzvf $HOME/nvim-linux64.tar.gz -C $HOME/nvim-linux64
    echo "export PATH=$PATH:$HOME/nvim-linux64/bin" >> $HOME/.bashrc
    rm -r $HOME/nvim-linux64.tar.gz

    # install rust things
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
    # Alacritty dependencies
    sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
    cargo install alacritty
    cargo install ripgrep
}

function fullinstallarch {
    # Yay
    sudo pacman -S --needed git base-devel;
    cd ~ && git clone https://aur.archlinux.org/yay.git;
    cd yay;
    makepkg -si;
    yay -Y --gendb;
    yay -Syu --devel;

    # DHCP daemon for internet
    yay -S dhcpcd
    sudo systemctl enable dhcpcd.service --now

    # ntp for time syncronisation
    yay -S ntp
    sudo systemctl enable ntpd.service --now
    timedatectl set-ntp 1

    # Essential tools
    yay -S gcc make cmake gdb

    # Window Manager
    yay -S lightdm lightdm-gtk-greeter xorg bspwm sxhkd feh rofi polybar
    # Other packages
    yay -S neovim alacritty firefox ttf-hack tmux bash-completion

    # Rust alternative tools https://zaiste.net/posts/shell-commands-rust/
    yay -S bat exa fd ripgrep bottom tealdear dust tokei
    #      cat ls find grep top tldr du wc

    # AUR packages
    yay -S as-tree-bin
}

mkdir -p /home/$USER/.config/

# Bash
mv ~/.bashrc ~/.bashrc.bak
ln -s /home/$USER/dotfiles/.bashrc /home/$USER/.bashrc
source /home/$USER/.bashrc

# Install software on arch
while getopts ":au" option; do
    case $option in
        a) fullinstallarch
           ;;
        u) fullinstallubuntu
           ;;
        :) ;;
        ?) ;;
    esac
done

# fzf
if [ ! -d '~/.fzf' ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi
rm /home/$USER/.fzf.bash
ln -s /home/$USER/dotfiles/fzf.bash /home/$USER/.fzf.bash

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

# Xprofile
ln -s /home/$USER/dotfiles/.xprofile /home/$USER/.xprofile

mkdir -p /home/$USER/.ipython/profile_default/
ln -s /home/$USER/dotfiles/ipython_config.py /home/$USER/.ipython/profile_default/ipython_config.py

