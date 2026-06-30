{ config, pkgs, lib, ... }:

let
  cfg = config.modules.gaming.steam;
in
{
  options.modules.gaming.steam = {
    enable = lib.mkEnableOption "Steam and gaming optimizations";

    gamescope = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable gamescope support";
    };

    gamemode = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable gamemode to optimize system performance";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];

      gamescopeSession.enable = cfg.gamescope;
    };

    programs.gamemode = lib.mkIf cfg.gamemode {
      enable = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
        };
      };
    };

    programs.gamescope = lib.mkIf cfg.gamescope {
      enable = true;
      capSysNice = false;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      _JAVA_OPTIONS = "-Dawt.useSystemAAFonSettings=on -Dswing.aatext=true";
    };

    environment.systemPackages = with pkgs; [
      protonup-qt
      protontricks

      (writeShellScriptBin "steam-gamescope" ''
        exec gamescope -W 2560 -H 1440 -e --hide-cursor-delay 999999 -- steam -tenfoot
      '')
    ];
  };

}
