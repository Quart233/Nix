{
  # Enable Snapper for the subvolumes (adjust SUBVOLUME if needed)
  services.snapper.configs = {
    nix = {
      SUBVOLUME = "/nix";  # Path to the BTRFS subvolume to snapshot
      ALLOW_USERS = [ "kuaizi" ];  # Users allowed to manage snapshots (optional)
      TIMELINE_CREATE = false;  # Enable automatic timeline snapshots (e.g., hourly/daily)
      TIMELINE_CLEANUP = false;  # Enable automatic cleanup of old snapshots
      TIMELINE_MIN_AGE = "1800";  # Minimum age for cleanup (in seconds, e.g., 30 minutes)
      TIMELINE_LIMIT_HOURLY = "0";  # Keep 5 hourly snapshots
      TIMELINE_LIMIT_DAILY = "0";   # Keep 7 daily snapshots
      TIMELINE_LIMIT_WEEKLY = "0";  # Keep 0 weekly (adjust as needed)
      TIMELINE_LIMIT_MONTHLY = "0"; # Keep 0 monthly
      TIMELINE_LIMIT_YEARLY = "0";  # Keep 0 yearly
    };

    home = {
      SUBVOLUME = "/home";  # Path to the BTRFS subvolume to snapshot
      ALLOW_USERS = [ "kuaizi" ];  # Users allowed to manage snapshots (optional)
      TIMELINE_CREATE = false;  # Enable automatic timeline snapshots (e.g., hourly/daily)
      TIMELINE_CLEANUP = false;  # Enable automatic cleanup of old snapshots
      TIMELINE_MIN_AGE = "1800";  # Minimum age for cleanup (in seconds, e.g., 30 minutes)
      TIMELINE_LIMIT_HOURLY = "0";  # Keep 5 hourly snapshots
      TIMELINE_LIMIT_DAILY = "0";   # Keep 7 daily snapshots
      TIMELINE_LIMIT_WEEKLY = "0";  # Keep 0 weekly (adjust as needed)
      TIMELINE_LIMIT_MONTHLY = "0"; # Keep 0 monthly
      TIMELINE_LIMIT_YEARLY = "0";  # Keep 0 yearly
    };
  };

  # Optional: Global filters for what files to snapshot (exclude large/irrelevant dirs)
  services.snapper.filters = ''
    # Exclude .snapshots and other paths.
    .snapshots
  '';
}
