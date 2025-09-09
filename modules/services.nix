{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    upower
  ]

  # Power Management
  services.upower.enable = true;
}
