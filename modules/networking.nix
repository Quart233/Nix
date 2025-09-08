{ config, ... }:
{
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.extraConfig = ''
    ctrl_interface=/run/wpa_supplicant
    ctrl_interface_group=wheel
    update_config=1
  '';
  networking.wireless.networks."Starbucks" = {
    auth = ''
      key_mgmt=NONE
    '';
  };

  # Configure network proxy if necessary
  networking.proxy.default = "http://127.0.0.1:2080";
  networking.proxy.noProxy = "127.0.0.1,static.wiwide.com,wiportal.wiwide.com,wihome.wiwide.com,starbucks.com.cn";

  networking.extraHosts =
  ''
    1.1.1.1  cloudflare.com
  '';
}