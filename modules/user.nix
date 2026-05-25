{ config, lib, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kuaizi = {
    packages = with pkgs; [
      # Utillity
      pv
      duf
      tree
      tmux
      ncdu
      fastfetch

      # Browser
      brave

      # Kubernetes
      k9s
      kubectl

      # Developer
      deno
      vscode
      zed-editor # Build from source.

      # Jetbrains
      (jetbrains.datagrip.overrideAttrs (oldAttrs: {
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

      # Hardware Tools
      htop
      btop
      hwloc
      nvme-cli
      powertop
      nvtopPackages.amd
    ];
  };

  # nixpkgs
  nixpkgs.config.allowUnfree = true;
}
