{
  description = "NixOS with libvirt + BTRFS storage pool";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.11";

    # ---- NixVirt (the module that lets you write pools/volumes in Nix) ----
    NixVirt = {
      url = "path:/etc/nixos/flakes/NixVirt";
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
          ./configuration.nix

          # ---- Import the NixVirt module ----
          NixVirt.nixosModules.default
        ];
      };
    };
}
