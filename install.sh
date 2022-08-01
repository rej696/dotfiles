mkdir -p /home/$USER/.config/

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
