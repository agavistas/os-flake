{ config, inputs, pkgs, ... }:

{
  hm.programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraConfig = ''
                (setq inferior-lisp-program "${pkgs.sbcl}/bin/sbcl")
                (add-to-list 'custom-theme-load-path "${pkgs.runCommand "base16-emacs" {} ''
mkdir $out; cp ${config.scheme inputs.base16-emacs} $out/base16-${config.scheme.scheme-name}-theme.el''}")
                (load-theme 'base16-${config.scheme.scheme-name}) 
                (load-file "${./init.el}")
    '';

    extraPackages = epkgs: with epkgs; [
      auctex
      base16-theme
      cdlatex
      multiple-cursors
      nix-mode
      pdf-tools
      slime      
    ];
  };
}
