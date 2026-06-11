{ config, pkgs, lib, NixVirt, ... }:

{
  virtualisation.libvirt.connections."qemu:///system".domains =
  [
    {
      definition = NixVirt.lib.domain.writeXML (
        let base = NixVirt.lib.domain.templates.windows {
          name = "win10-dgpu";
          uuid = "def734bb-e2ca-44ee-80f5-0ea0f2593aaa";
          memory = { count = 8; unit = "GiB"; };
          storage_vol = { pool = "btrfs-pool"; volume = "win10.qcow2"; };
          backing_vol = /home/kuaizi/VM-Storage/Base.qcow2;
          install_vol = /home/kuaizi/VM-Storage/SW_DVD9_WIN_ENT_LTSC_2021_64BIT_ChnSimp_MLF_X22-84402.iso;
          bridge_name = "virbr0";
          nvram_path = /home/kuaizi/VM-Storage/win10.nvram;
          virtio_net = true;
          virtio_drive = true;
          install_virtio = true;
        };
        in
        base // {
          devices = base.devices // {
            hostdev = (base.devices.hostdev or []) ++ [
              {
                type = "pci";
                managed = true;
                source = {
                  address = { domain = 0; bus = 3; slot = 0; function = 0; };
                };
              }
            ];
          };
        }
      );
    }
  ];
}
