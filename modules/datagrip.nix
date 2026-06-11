{ config, lib, pkgs, ... }:

{
  users.users.kuaizi.packages = with pkgs; [
    (jetbrains.datagrip.overrideAttrs(oldAttrs: {
      version = "2025.2.4";
      src = fetchurl {
  	  url = "https://download.jetbrains.com/datagrip/datagrip-2025.2.4.tar.gz";
  	  sha256 = "0xl4f4i3ndbkxnlg3qmp7n88klxxn2rkbzh76lfwg50bqd7azl1p";
  	};
  	buildInputs = (oldAttrs.buildInputs or []) ++ [
        pkgs.libGL
        pkgs.fontconfig
        pkgs.xorg.libX11
      ];
    }))
  ];
}
