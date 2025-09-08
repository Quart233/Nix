{ config, lib, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kuaizi = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      tmux
      ncdu
      duf
      yazi
      pwgen

      # Browser
      brave
      chromium

      # Kubernetes
      k9s
      lens
      kubectl
      kubernetes-helm

      # Remote
      rustdesk

      # Developer
      deno
      vscode
      sublime4
      sublime-merge
    ];
  };

  # nixpkgs
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];
}
