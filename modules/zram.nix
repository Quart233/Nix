{ config, lib, pkgs, ... }:

{
  zramSwap.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 75;  # Use up to 75% of RAM
    numDevices = 8;      # For a num-core system
    priority = 150;      # Prefer over disk swap
    writebackDevice = "/dev/nvme0n1p2";  # Backing block device (unformatted)
  };

  swapDevices = [{
    device = "/dev/nvme0n1p2";
    options = [ "discard" ];  # Or "discard=once" for one-time trim
  }];

  boot.kernel.sysctl."vm.swappiness" = 10;  # Or 1 for minimal swapping

  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.compressor=lz4"  # Or zstd
    "zswap.max_pool_percent=20"  # Limit to 20% RAM
    "zswap.shrinker_enabled=1"   # Proactive shrinking
  ];
}