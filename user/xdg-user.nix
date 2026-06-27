{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    xdg-user-dirs
    xdg-user-dirs-gtk
  ];
  
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    
    # Use absolute paths and the correct singular 'download' option
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads"; 
    pictures = "${config.home.homeDirectory}/Documents/Pictures";
    music = "${config.home.homeDirectory}/Documents/Music";
  };
}
