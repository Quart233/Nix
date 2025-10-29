{ config, pkgs, lib, NixVirt, ... }:

let
  # ... (keep btrfsUUID as-is)
  btrfsUUID = "12345678-1234-1234-1234-123456789abc";  # Your real BTRFS UUID

  # NEW: Use output from `uuidgen`
  poolUUID = "f47ac10b-58cc-4372-a567-0e02b2c3d479";  # Paste here!
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
  virtualisation.libvirtd.qemu.ovmf = { # not needed in NixOS 25.11 since https://github.com/NixOS/nixpkgs/pull/421549
    enable = true;
    packages = [(pkgs.OVMF.override {
      secureBoot = true;
      tpmSupport = true;
    }).fd];
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
  virtualisation.libvirt = {
    enable = true;                     # activates NixVirt
    connections."qemu:///system" = {
      pools = [
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
          volumes = [
            {
              present = true;
              definition = NixVirt.lib.volume.writeXML {
                name = "vm-disk.qcow2";
                capacity = { count = 20; unit = "GiB"; };
                format.type = "qcow2";  # Recommended for VMs
              };
            }
          ];
        }
      ];
    };
  };

  users.users.kuaizi.extraGroups = ["libvirtd"];
}
