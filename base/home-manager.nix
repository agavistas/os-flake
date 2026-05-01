{ lib, inputs, baseVars, hostVars, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" baseVars.username ])
  ];

  home-manager.useGlobalPkgs = true;

  hm = { pkgs, ...}: {
    programs.bash.enable = true;
    home.stateVersion = hostVars.stateVersion;
  };
}
