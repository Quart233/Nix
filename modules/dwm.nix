{ config, lib, pkgs, ... }:

{
  services.xserver.desktopManager.runXdgAutostartIfNone = true;
  services.xserver.desktopManager.wallpaper.mode = "tile";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "kuaizi";

  # DWM package
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.dwm.package = pkgs.dwm.override {
    patches = with pkgs; [
      ../patches/dwm-backlight.diff
      ../patches/dwm-noborder-6.2.diff
    ];
  };

  # DWM Status
  services.dwm-status.enable = true;
  services.dwm-status.order = ["time" "battery"];

  # Compositor
  services.picom.enable = true;
  services.picom.backend = "xrender";
  services.picom.vSync = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.libinput.touchpad = {
    tapping = false;
    naturalScrolling = true;
  };

  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    QT_AUTO_SCREEN_SCALE_FACTOR = "0";
  };

  # Swap trackpad left/right button.
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xinput}/bin/xinput set-button-map "TPPS/2 Elan TrackPoint" 3 2 1
  '';
    # export QT_PLUGIN_PATH="${pkgs.kdePackages.fcitx5-qt}/lib/qt-6/plugins"
    # sleep 5 && ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode 37 = Alt_L" & # Control_L
    # sleep 5 && ${pkgs.xorg.xmodmap}/bin/xmodmap -e "keycode 64 = Control_L" & # Alt_L

  # Keyring
  # programs.seahorse.enable = true;
  # services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    # WM Utils
    st
    rofi
    scrot
    dmenu
    picom
    dwm-status
    brightnessctl

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
