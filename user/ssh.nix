{ config, pkgs, lib, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {};
    extraConfig = ''
      Host github.com
      AddKeysToAgent yes
      IdentityFile ~/.ssh/id_ed25519
      '';
  };
}
