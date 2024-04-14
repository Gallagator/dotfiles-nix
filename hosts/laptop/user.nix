{ config, lib, inputs, ...}:
{
    imports = [ ../../modules/default.nix ];
    config.modules = {
        # gui
        firefox.enable = true;
        hyprland.enable = true;

        # cli
        nvim.enable = true;
        zsh.enable = true;
        git.enable = true;
        # system
        xdg.enable = true;
    };
}
