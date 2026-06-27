{ config, pkgs, lib, ... }:

{
  modules.gaming.steam = {
    enable = true;
    gamescope = true;
    gamemode = true;
  };

  modules.hardware.amd = {
    enable = true;
    enableLact = true;
  };

  modules.gaming.optimization.enable = true;
  
}
