{ pkgs, ... }:

{
  hm.programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraConfig = ''
                (add-to-list 'custom-theme-load-path "${./assets/emacs/themes}")
                (setq inferior-lisp-program "${pkgs.sbcl}/bin/sbcl")
                (load-file "${./assets/emacs/init.el}")
    '';

    extraPackages = epkgs: with epkgs; [
      auctex
      cdlatex
      multiple-cursors
      nix-mode
      pdf-tools
      slime      
    ];
  };
}
