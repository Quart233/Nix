# Create subvolumes
btrfs su cr /mnt/@
btrfs su cr /mnt/@nix
btrfs su cr /mnt/@nix-snapshots
btrfs su cr /mnt/@home
btrfs su cr /mnt/@home-snapshots

# Create Mount Points
mkdir -p /mnt
mkdir -p /mnt/nix
mkdir -p /mnt/nix/.snapshots
mkdir -p /mnt/home
mkdir -p /mnt/home/.snapshots

# Mounts
mount -o noatime,subvol=@ /dev/nvme0n1p3 /mnt
mount -o noatime,subvol=@nix,compression=ZSTD /dev/nvme0n1p3 /mnt/nix
mount -o noatime,subvol=@nix-snapshots,compression=ZSTD /dev/nvme0n1p3 /mnt/nix/.snapshots
mount -o noatime,subvol=@home,compression=ZSTD /dev/nvme0n1p3 /mnt/home
mount -o noatime,subvol=@home-snapshots /dev/nvme0n1p3 /mnt/home/.snapshots