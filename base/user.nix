{ baseVars, pkgs, ... }:

{
  users.users.${baseVars.username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ ];
  };
}
