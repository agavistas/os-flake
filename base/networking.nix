{ hostVars, ... }:

{
  networking = {
    networkmanager.enable = true;
    hostName = hostVars.hostname;
  };
}
