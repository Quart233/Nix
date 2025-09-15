{ config, pkgs, ...}:

{
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enable = true;
    };
  };

  virtualisation.containers.storage.settings.storage = {
    driver = "btrfs";
    runroot = "/run/podman";
    graphroot =  "/var/lib/containers/storage";
  };

  environment.systemPackages = with pkgs; [
    # Container Tools
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    docker-compose # docker compose support.
  ];
}