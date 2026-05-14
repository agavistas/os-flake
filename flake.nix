{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16.url = "github:SenchoPens/base16.nix";
    base16-emacs = {
      url = "github:tinted-theming/base16-emacs";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, disko, ... }: {
    nixosConfigurations = import ./hosts.nix { inherit inputs; };
  };
}

