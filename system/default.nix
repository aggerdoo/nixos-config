{ inputs, ...}:

{
  imports = [
   ./admin/default.nix
   ./user/gaming/default.nix
   ./user/zen-browser.nix
   ./user/qbittorrent.nix
  ];
}
