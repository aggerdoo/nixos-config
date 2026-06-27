{ pkgs, inputs, niri,  ... }:

{
  imports = [
    inputs.niri.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    #package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
  }; 
  

  #nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  
}
