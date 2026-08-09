{ config, pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
  };

  networking.wireless = {
    enable = true;
  };

  networking.wireless.networks = {
    "ZZOOMM-EBADE5 FAST" = {
      pskRaw = "Cyhuedvovan6";
    };
  };

  networking.useDHCP = lib.mkDefault true;
}
