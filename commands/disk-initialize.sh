read -p "This will remove all data from disk (yes/no): " answer
if [ "$answer" = "yes" ]; then
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount modules/disko.nix
    mount | grep /mnt
else
    echo "Invalid input. Please enter 'yes' or 'no'."
    exit 0;
fi
