{ pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    quickshell
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      
    };
  };
}
