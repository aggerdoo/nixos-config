{ config, lib, pkgs, ... }:

let
  cfg = config.modules.gaming.optimization;
in
{
  options.modules.gaming.optimization = {
    enable = lib.mkEnableOption "Zen Kernel and Low-Latency Gaming Optimizations";
  };

  config = lib.mkIf cfg.enable {
    # 1. The Zen Kernel
    # Optimized for desktop responsiveness and gaming latency.
    boot.kernelPackages = pkgs.linuxPackages_zen;

    # 2. Virtual Memory Tweaks (CRITICAL for DX12)
    # Many DX12 games (Hogwarts Legacy, Star Citizen, Halo) crash
    # because the default memory map limit is too low. 
    # This matches the Steam Deck's default value.
    boot.kernel.sysctl = {
      "vm.max_map_count" = 2147483642; 
    };

    # 3. Kernel Boot Parameters
    # - split_lock_detect=off: Fixes performance drops in some games (e.g. God of War).
    # - clearcpuid=514: (Optional) Fixes some older games detecting "unknown CPU" on newer Ryzen.
    boot.kernelParams = [ "split_lock_detect=off" ];

    # 4. Vulkan & DX12 Tools
    # VKD3D translates DX12 -> Vulkan. It's built into Proton,
    # but having the library system-wide helps Lutris/Bottles.
    environment.systemPackages = with pkgs; [
      vulkan-tools  # Check status with 'vulkaninfo'
      vkd3d         # DX12->Vulkan translation lib
      vkd3d-proton  # The specific fork used by Steam (optional but good for debug)
    ];

    # 5. Environment Variables for Modern Vulkan
    environment.sessionVariables = {
      # Reduce stuttering by enabling the Graphics Pipeline Library (GPL)
      # Modern Mesa drivers enable this by default, but forcing it ensures 
      # it's active for older games/prefixes.
      RADV_PERFTEST = "gpl";

      # If you have a high-end AMD card, this can help DX12 performance
      # by not limiting the texture cache size.
      #RADV_TEX_ANISO = "16"; 
    };
  };
}
