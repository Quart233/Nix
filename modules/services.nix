{ config, lib, pkgs, ... }:

{
  # OpenSSH
  services.openssh.enable = true;

  # Power Management
  services.upower.enable = true;
}
