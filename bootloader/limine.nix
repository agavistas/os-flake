{ pkgs, ... }:

{
  boot.loader.limine = {
    enable = true;
    secureBoot = {
      enable = true;
      autoGenerateKeys = true;
      autoEnrollKeys.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
  
