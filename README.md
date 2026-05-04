current install process:

```bash
git clone https://github.com/agavistas/os-flake
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount os-flake/hosts/{your host of choice}
nixos-install --flake .#{your host of choice}
```
