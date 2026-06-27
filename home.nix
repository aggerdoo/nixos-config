{ config, pkgs, unstable, inputs, ... }:

{
  home.username = "alan";
  home.homeDirectory = "/home/alan";

  imports = [
    ./user/default.nix
    #inputs.zen-browser.homeModules.twilight
    inputs.walker.homeManagerModules.default
  ];

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.packages = with pkgs; [
    zip xz unzip p7zip #archive apps
    eza fzf
    file
    which
    tree
    gawk
    btop iftop
    sysstat
    lm_sensors
    pciutils
    usbutils
    umu-launcher
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = "";
  };

  #programs.ssh = {
  # enable = true;
  #  enableDefaultConfig = false;
  #  settings."*" = {};
  #  extraConfig= ''
  #    Host github.com
  #    AddKeysToAgent yes
  #    IdentityFile ~/.ssh/id_ed25519
  #  '';  
  #};

  programs.walker = {
    enable = true;
    runAsService = true;
  };

  home.stateVersion = "26.05";
}
