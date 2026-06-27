{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "aggerdoo";
        email = "smcklaus@gmail.com";
        signinKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOVDyR8ufOan2q+adt/RlS6wvtNBsXirP+5kS25a5Vgt";
      };

      init.defaultBranch = "main";
      core.editor = "helix";
    };
  };  
}
