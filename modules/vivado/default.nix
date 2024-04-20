{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.vivado;

in {
    options.modules.vivado = { enable = mkEnableOption "vivado"; };
    config = mkIf cfg.enable {
        # home.packages = with pkgs; [
        #     nur.repos.lschuermann.vivado-2022_2
        # ];
    };
}
