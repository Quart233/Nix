{
  description = "NixOS with libvirt + BTRFS storage pool";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.05";

    # ---- NixVirt (the module that lets you write pools/volumes in Nix) ----
    NixVirt = {
      url = "https://flakehub.com/f/AshleyYakeley/NixVirt/0.6.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, NixVirt, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs   = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.Z16 = nixpkgs.lib.nixosSystem {
        inherit system;

        # ---- Pass NixVirt as a special argument to modules ----
        specialArgs = { inherit NixVirt; };

        modules = [
          ./modules/libvirtd.nix

          # ---- Import the NixVirt module ----
          NixVirt.nixosModules.default
        ];
      };
    };
}
