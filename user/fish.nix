{ inputs, pkgs, lib, ... }:

let

myAliases = {
  ls = "eza --icons -l -T -L=1";
  cat = "bat";
  htop = "btop";
  fd = "fd -Lu";
  gitfetch = "onefetch";
  nfc = "nix flake check";
  nrs = "nixos-rebuild switch --flake .";
  nh = "nh os switch .";
};

in

{
  programs.bash = {
    enableCompletion = true;
    shellAliases = myAliases;
  };

  programs.fish = {
    enable = true;
    shellAliases = myAliases;
    generateCompletions = true;
    loginShellInit = ''
      if test -z "WAYLAND_DISPLAY"; and test "XDG_VTNR" = "1"
        exec niri-session
      end
    '';
    interactiveShellInit = ''
      set -g theme_nerd_fonts yes
      set fish_greeting # Disable greeting
      set -U tide_style lean
      set -U tide_prompt_char_character "❯"
      set -U tide_left_prompt_items pwd git newline character
      if not set -p SSH_AUTH_SOCK
          eval (ssh-agent -c)
          set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
          set -Ux SSG_AGENT_PID $SSH_AGENT_PID
      end
    '';
    plugins = with pkgs.fishPlugins; [
      {
        name = "tide"; src = pkgs.fishPlugins.tide.src;
      }
    ];
  };

  home.packages = with pkgs; [
    #fishPlugins.pure
    fishPlugins.tide
    fishPlugins.grc
    fishPlugins.fzf
    fishPlugins.git-abbr
    grc
    eza
    bat
    fd
    btop
    direnv
    nix-direnv
    onefetch
    fastfetch
  ];
}
