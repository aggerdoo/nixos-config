{ inputs, ... }:

{
  imports = [
    ./fonts.nix
    ./nh.nix
    ./filemanager.nix
    ./pipewire.nix
    ./networking.nix
  ];
}
