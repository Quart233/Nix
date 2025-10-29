{ config, lib, pkgs, ... }:

{
  zramSwap.enable = true;

  zramSwap = {
    algorithm = "zstd";
    memoryPercent = 25;  # Use up to 25% of RAM
    priority = 100;      # Prefer over disk swap
    writebackDevice = "/dev/nvme0n1p2";
  };

  swapDevices = lib.mkForce []; # Disable swap
  # swapDevices = lib.mkForce [{ device = "/dev/nvme0n1p2"; priority = 10; }]; # Low priority than zRAM.
  boot.kernelParams = [ "quiet" "splash" "systemd.swap=0" ]; # Disable GPT swap generator.
}
