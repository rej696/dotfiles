# Links for help:
# - https://github.com/nix-community/home-manager
# - https://search.nixos.org
# - https://nix-community.github.io/home-manager/
# - https://nixos.wiki/wiki/Home_Manager
# - https://mipmip.github.io/home-manager-option-search/
# - https://github.com/srid/nixos-config

# Installation commands
# sh <(https://nixos.org/nix/install) --no-daemon
# sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
# sudo nix-channel --update
# nix-shell '<home-manager>' -A install

{ config, pkgs, ... }:

let
    pkgsUnstable = import <nixpkgs-unstable> {};
in

{

    home.username = "rowan";
    home.homeDirectory = "/home/rowan";

    home.stateVersion = "22.11"; # FIXME

    programs.home-manager.enable = true;

    home.packages = [
        pkgs.fd
        pkgs.du-dust
        pkgs.tmux
        pkgs.make
        pkgs.hack-font
        pkgs.ripgrep
        pkgs.alacritty
        pkgs.neovim
        pkgs.tealdeer
        pkgs.gcc
        pkgs.curl
        pkgs.tar
        pkgs.gdb
        pkgs.rofi
        pkgs.bspwm
        pkgs.sxhkd
        pkgs.polybar
        pkgs.feh
    ];

    home.file."./.config/nvim/" = {
        source = ./dotfiles/nvim.lazy/;
        recursive = true;
    };
    
    home.file."./.config/alacritty/" = {
        source = ./dotfiles/alacritty/;
        recursive = true;
    };

    programs.fzf = {
        enable = true;
        enableBashIntegration = true;
    }

    programs.git = {
        # FIXME
        enable = false;
        userName = "rej696";
        userEmail = "55083730+rej696@users.noreply.github.com";
    }

}


