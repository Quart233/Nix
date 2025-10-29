# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix # Include the results of the hardware scan.
      ./modules/networking.nix

      # WM Backlight & Inputs
      ./modules/dwm.nix

      # Preferences (post-install)
      ./modules/i18n.nix

      # Advanced (post-install)
      ./modules/snapper.nix
      ./modules/podman.nix
    ];

  # Define your hostname.
  networking.hostName = "ThinkpadX1";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kuaizi = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # OpenSSH
  services.openssh.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "quiet" "splash" "systemd.swap=0" ]; # Disable GPT swap generator.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    fish
    neovim
    pciutils
  ];

  # nix
  # nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channel/store" ];
  # nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05"; # Did you read the comment?
}
