{ config, pkgs, ... }:

{
  imports = [
   ./fish.nix
   ./wm/niri.nix
   ./wm/noctalia.nix
   #./zen-browser.nix
   ./gaming/default.nix
   ./xdg-user.nix
   ./git.nix
   ./ssh.nix
  ];
}
