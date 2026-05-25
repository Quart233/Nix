{ config, pkgs, ...}:

{
  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Input Method
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-nord
      kdePackages.fcitx5-qt
      kdePackages.fcitx5-configtool
      kdePackages.fcitx5-chinese-addons
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
     nerd-fonts.jetbrains-mono
     noto-fonts noto-fonts-cjk-sans
  ];
}
