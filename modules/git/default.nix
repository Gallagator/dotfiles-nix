{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.git;

in {
    options.modules.git = { enable = mkEnableOption "git"; };
    config = mkIf cfg.enable {
        programs.git = {
            enable = true;
            userName = "gallagator";
            userEmail = "liam.d.gallagher@protonmail.com";
            extraConfig = {
                init = { defaultBranch = "master"; };
                core = {
                    excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
                };
            };
        };
    };
}
