{ inputs, pkgs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
    enableDynamicTheming = true;
    dgop.package = inputs.dgop.packages.${pkgs.stdenv.hostPlatform.system}.default;
    quickshell.package = pkgs.quickshell;
    niri = {
      enableKeybinds = true;
      enableSpawn = true;
    };
  };

  home.packages = with pkgs; [
    matugen
  ];
}
