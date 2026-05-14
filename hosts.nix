{ inputs }:

let
  specialArgs = {
    inherit inputs;
    baseVars = {
      username = "agave";
    };
  };
in
{
  nixbox = inputs.nixpkgs.lib.nixosSystem {
    modules = [ 
      ./base
      ./desktop
      ./bootloader/systemd-boot.nix
      ./hosts/x86_64-linux/nixbox/hardware-configuration.nix
      ./disks/btrfs-luks.nix
      inputs.disko.nixosModules.disko

      inputs.base16.nixosModule
      { scheme = "${themes/sample.yaml}"; }
    ];
    specialArgs = specialArgs // {
      hostVars = {
        hostname = "nixbox";
        stateVersion = "25.11";

        display = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };
      };
    };
  };
}

