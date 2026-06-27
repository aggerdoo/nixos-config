{ config, pkgs, ... }:

{
  fonts = {
   enableDefaultPackages = true;
   packages = with pkgs; [
     nerd-fonts.hack
     nerd-fonts.hurmit
     nerd-fonts.fira-code
     nerd-fonts.symbols-only
     nerd-fonts.monofur
     nerd-fonts.inconsolata
     meslo-lgs-nf
     material-symbols
     material-icons
     lexend
     (google-fonts.override { fonts = [ "DMSans" ]; })
   ];

   fontDir.enable = true;
   fontconfig = {
     enable = true;
     defaultFonts = {
       serif = [ "DM Sans" ];
       sansSerif = [ "inconsolata" ];
       monospace = [ "monofur" ];
     };
   };
  };
}
