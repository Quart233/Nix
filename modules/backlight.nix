{ config, lib, pkgs, ... }:

{
  # Backlight
  services.xserver.videoDrivers = [ "intel" ];
  services.xserver.deviceSection = ''
    Option "Backlight" "intel_backlight"
  '';

  services.xserver.windowManager.dwm.package = pkgs.dwm.override {
    patches = with pkgs; [
      (fetchpatch {
        url = "https://dwm.suckless.org/patches/backlight/dwm-backlight-20241021-351084d.diff";
        hash = "sha256-ibUkz0M2bp5aYz0xLpwLNOBjyzb0WEkFBU8LPp/bdKU=";
      })
    ];
  };

  environment.systemPackages = with pkgs; [
    xorg.xbacklight
  ];
}
