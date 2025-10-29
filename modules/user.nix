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
      kubectl

      # Developer
      deno
      vscode
      sublime-merge
    ];
  };

  # nixpkgs
  nixpkgs.config.allowUnfree = true;
}
