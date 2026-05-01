{ pkgs, ... }:

{
  hm.home.packages = with pkgs; [
    swaybg
    fastfetch
    brightnessctl
    sbcl
  ];
}
