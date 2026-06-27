{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    qbittorrent-enhanced
  ];
  
  services.qbittorrent = {
    enable = true;
  };
}
