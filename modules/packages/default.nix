{ pkgs, lib, config, ... }:

with lib;
let cfg = 
    config.modules.packages;
    screen = pkgs.writeShellScriptBin "screen" ''${builtins.readFile ./screen}'';
    bandw = pkgs.writeShellScriptBin "bandw" ''${builtins.readFile ./bandw}'';
    maintenance = pkgs.writeShellScriptBin "maintenance" ''${builtins.readFile ./maintenance}'';

in {
    options.modules.packages = { enable = mkEnableOption "packages"; };
    config = mkIf cfg.enable {
    	home.packages = with pkgs; [
            ripgrep ffmpeg tealdeer
            eza htop fzf
            pass gnupg bat
            unzip lowdown zk
            grim slurp slop
            imagemagick age libnotify
            git python3 lua zig sbt
            mpv firefox pqiv
            screen bandw maintenance
            wf-recorder anki-bin 
            discord zellij steam
            keepassxc obs-studio
            neofetch
            # chisel
            verilator bitwuzla
            cvc5 cvc4 verilog
            buildPackages.scala
            z3 gtkwave
            # apps
            musescore
        ];
    };
}
