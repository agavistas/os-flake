{ baseVars, pkgs, ... }:

{
  programs.zsh.enable = true;
  hm.programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      nrs = "nixos-rebuild switch --flake /home/${baseVars.username}/nix --sudo";
    };
  };
}
