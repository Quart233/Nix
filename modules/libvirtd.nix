{ config, pkgs, lib, NixVirt, ... }:

let
  # ... (keep btrfsUUID as-is)
  btrfsUUID = "7dc8a70b-59ec-4f60-a064-de313bb5e60c";

  # NEW: Use output from `uuidgen`
  poolUUID = "20cd011a-53d7-41c0-8d35-313eaba090da";
in
{
  # ----------------------------------------------------------------------
  # 1. Enable libvirt
  # ----------------------------------------------------------------------
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu = {
    package = pkgs.qemu_kvm;
    runAsRoot = true;
    swtpm.enable = true;
  };

  # ----------------------------------------------------------------------
  # 2. Mount the BTRFS subvolume where libvirt will keep images
  # ----------------------------------------------------------------------
  fileSystems."/var/lib/libvirt/btrfs-pool" = {
    device = "/dev/disk/by-uuid/${btrfsUUID}";
    fsType = "btrfs";
    options = [
      "subvol=@libvirt"      # subvolume you will create (see step 3)
      "compress=zstd"
      "noatime"
    ];
  };

  # ----------------------------------------------------------------------
  # 3. Declarative libvirt storage pool (uses NixVirt)
  # ----------------------------------------------------------------------
  virtualisation.libvirt.enable = true;
  virtualisation.libvirt.connections."qemu:///system".pools =
  [
    {
      # ... pool definition ...
      definition = NixVirt.lib.pool.writeXML {
        name = "btrfs-pool";
        uuid = poolUUID;
        type = "dir";  # Use "dir" for pre-mounted or "fs" for block.
        target.path = "/var/lib/libvirt/btrfs-pool";
      };
      active = true;
      restart = true;  # Restart if definition changes

      # ... volume definition ...
      volumes = [];
    }
  ];

  virtualisation.libvirt.connections."qemu:///system".networks =
  [
    {
      definition = NixVirt.lib.network.writeXML (NixVirt.lib.network.templates.bridge
        {
          uuid = "70b08691-28dc-4b47-90a1-45bbeac9ab5a";
          subnet_byte = 71;
        });
      active = true;
    }
  ];

  users.users.kuaizi.extraGroups = ["libvirtd"];
  environment.systemPackages = with pkgs; [
    virt-viewer
  ];
}
