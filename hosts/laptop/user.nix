{ config, lib, inputs, ...}:
{
    imports = [ ../../modules/default.nix ];
    config.modules = {
        # gui
        firefox.enable = true;
        foot.enable = true;
        eww.enable = true;
        dunst.enable = true;
        hyprland.enable = true;
        wofi.enable = true;
        vivado.enable = true;

        # cli
        nvim.enable = true;
        zsh.enable = true;
        git.enable = true;
        # system
        xdg.enable = true;
        packages.enable = true;
    };
}
