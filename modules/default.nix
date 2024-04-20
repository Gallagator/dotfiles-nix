{ inputs, pkgs, config, ... }:

{
    nixpkgs.config.allowUnfree = true;
    home.stateVersion = "22.11";
    imports = [
        # gui
        ./firefox
        ./foot
        ./eww
        ./dunst
        ./hyprland
        ./wofi
        ./vivado

        # cli
        ./nvim
        ./zsh
        ./git
        ./gpg
        ./direnv

        # system
        ./xdg
	    ./packages
    ];
}
