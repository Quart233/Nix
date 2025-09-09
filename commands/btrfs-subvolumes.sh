# Create subvolumes
btrfs su cr /mnt/@
btrfs su cr /mnt/@nix
btrfs su cr /mnt/@home
btrfs su cr /mnt/@snapshots

# Mounts
mount -o noatime,subvol=@ /dev/nvme0n1p3 /mnt
mount -o noatime,subvol=@nix,compression=ZSTD /dev/nvme0n1p3 /mnt/nix
mount -o noatime,subvol=@home /dev/nvme0n1p3 /mnt/home
mount -o noatime,subvol=@snapshots /dev/nvme0n1p3 /mnt/snapshots