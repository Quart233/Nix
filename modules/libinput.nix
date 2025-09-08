{ config, lib, pkgs, ... }:

{
  # Swap trackpad left/right button.
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xinput}/bin/xinput set-button-map "TPPS/2 ALPS TrackPoint" 3 2 1
  '';

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.libinput.touchpad = {
    tapping = false;
    naturalScrolling = true;
  };
}
