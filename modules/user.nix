{ config, lib, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kuaizi = {
    packages = with pkgs; [
      # Utillity
      duf
      tmux
      ncdu
      snapper
      fastfetch

      # Browser
      brave

      # Kubernetes
      k9s
      kubectl

      # Developer
      deno
      vscode

      # Hardware Tools
      htop
      btop
      acpi
    ];
  };

  # nixpkgs
  nixpkgs.config.allowUnfree = true;
}
