{ config, lib, pkgs, ... }:

{
  imports = [
    ./steam.nix
    ./steamii.nix
    ./amd-gpu.nix
    ./gaming-modules.nix
    ./gaming-optimization.nix
  ];
}
