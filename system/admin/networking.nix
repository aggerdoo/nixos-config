{ config, pkgs, lib, ... }:

{
  networking.networkmanager = {
    enable = lib.mkForce true;
  };

 networking.nameservers = [ "1.1.1.1" "8.8.8.8 "];

  networking.wireless = {
    enable = lib.mkForce false;
  };

  #networking.wireless.networks = {
  #  "ZZOOMM-EBADE5 FAST" = {
  #    psk = "Cyhuedvovan6";
  #  };
  #};

  networking.useDHCP = lib.mkDefault true;
}
