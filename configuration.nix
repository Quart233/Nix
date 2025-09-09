# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/virtualisation.nix
      ./modules/networking.nix

      # Preferences
      ./modules/user.nix
      ./modules/i18n.nix
      ./modules/services.nix

      # Window Manager Inputs
      ./modules/dwm.nix
      ./modules/libinput.nix
      ./modules/backlight.nix
    ];

  # Define your hostname.
  networking.hostName = "ThinkpadX1";

  # OpenSSH
  services.openssh.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # VA-API
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    intel-compute-runtime
  ];

  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget
    curl
    fish
    neovim

    # Hardware Tools
    nvme
    btop
    acpi
    fastfetch
    smartmontools
  ];

  # nix
  # nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channel/store" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05"; # Did you read the comment?
}
