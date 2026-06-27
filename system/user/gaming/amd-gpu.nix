{ config, lib, pkgs, ... }:

let
  cfg = config.modules.hardware.amd;
in

{
  options.modules.hardware.amd = {
    enable = lib.mkEnableOption "AMD GPU optimization and drivers";

    enableLact = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable LACT for fan control";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };

    environment.systemPackages = lib.mkIf cfg.enableLact [ pkgs.lact ];

    systemd.services.lactd = lib.mkIf cfg.enableLact {
      description = "AMDGPU Control Daemon";
      enable = true;
      serviceConfig = {
        ExecStart = "${pkgs.lact}/bin/lact daemon";
      };
      wantedBy = [ "multi.user.target" ];
    };
  };
}
