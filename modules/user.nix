{ config, lib, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kuaizi = {
    packages = with pkgs; [
      # Utillity
      pv
      duf
      tree
      tmux
      ncdu
      fastfetch

      # Browser
      brave

      # Kubernetes
      k9s
      kubectl

      # Developer
      deno
      vscode
      zed-editor # Build from source.

      # Knowlege Base
      obsidian

      # Hardware Tools
      htop
      btop
      hwloc
      nvme-cli
      powertop
      nvtopPackages.amd
    ];
  };

  # nixpkgs
  nixpkgs.config.allowUnfree = true;
}
