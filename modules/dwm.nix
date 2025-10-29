{ config, lib, pkgs, ... }:

{
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "kuaizi";

  # DWM package
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.dwm.package = pkgs.dwm.override {
    patches = with pkgs; [
      ../patches/dwm-backlight.diff
    ];
  };

  # DWM Status
  services.dwm-status.enable = true;
  services.dwm-status.order = ["time" "battery"];

  # Compositor
  services.picom.enable = true;
  services.picom.backend = "xrender";
  services.picom.vSync = true;

  # Backlight
  services.xserver.videoDrivers = [ "intel" ];
  services.xserver.deviceSection = ''
    Option "Backlight" "intel_backlight"
  '';

  environment.systemPackages = with pkgs; [
    # WM Utils
    st
    rofi
    scrot
    dmenu
    picom
    dwm-status
    xorg.xbacklight

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
