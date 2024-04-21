{  inputs, lib, config, pkgs, ... }:
with lib;
let
    cfg = config.modules.nvim;
in {
    options.modules.nvim = { enable = mkEnableOption "nvim"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            inputs.nixvim.packages."x86_64-linux".default
        ];
    };
}
