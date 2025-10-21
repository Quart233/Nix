{ config, lib, pkgs, ... }:

{
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;

  # DWM Status
  services.dwm-status.enable = true;
  services.dwm-status.order = ["time" "battery"];

  # Compositor
  services.picom.enable = true;
  services.picom.backend = "xrender";
  services.picom.vSync = true;

  environment.systemPackages = with pkgs; [
    # WM Utils
    st
    rofi
    scrot
    dmenu
    picom
    dwm-status

    # Terminal Patches
    # (st.overrideAttrs (oldAttrs: rec {
    #   patches = [
    #     (fetchpatch {
    #      url = "https://st.suckless.org/patches/scrollback/st-scrollback-0.9.2.diff";
    #      sha256 = "sha256-ZypvRONAHS//wnZjivmqpWIqZlKTqAQ0Q8DhQpZVaqU=";
    #     })
    #   ];
    # }))
  ];
}