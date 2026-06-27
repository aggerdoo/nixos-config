{ inputs, pkgs, ... }:

{
  imports = [
    inputs.dms.nixosModules.dank-material-shell
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

  environment.systemPackages = with pkgs; [
    matugen
  ];
}
