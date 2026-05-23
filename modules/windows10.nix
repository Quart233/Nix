{ config, pkgs, lib, NixVirt, ... }:

{
  virtualisation.libvirt.connections."qemu:///system".domains =
  [
    {
      definition = NixVirt.lib.domain.writeXML (NixVirt.lib.domain.templates.windows
      {
        name = "windows10-dgpu";
        uuid = "cc7439ed-36af-4696-a6f2-1f0c4474d87e";
        memory = { count = 16; unit = "GiB"; };
        vcpu = { count = 8; };

        # Add host device
        hostdevs = [
          {
            type = "pci";
            managed = true;
            source = {
              address = { domain = 0; bus = 3; slot = 0; function = 0; };
            };
          }
        ];

        # Add disk format override
        disks = [{
          device = "disk";
          type = "file";
          driver = { type = "raw"; };
          source = { file = "/var/lib/libvirt/btrfs-pool/Penguin.raw"; };
          target = { dev = "vda"; bus = "virtio"; };
        }];

        firmware = {
          loader = {
            path = "/run/libvirt/nix-ovmf/OVMF_CODE.fd";
            readonly = true;
          };
          nvram = {
            template = "/run/libvirt/nix-ovmf/OVMF_VARS.fd";
          };
        };

        features = {
          hyperv = true;           # Improve Windows performance
          kvmHidden = true;        # Hide KVM spec features
        };
      });
    }
  ];
}
