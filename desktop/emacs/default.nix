{ config, inputs, pkgs, ... }:

{
  hm.programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraConfig = 
    let themeFile = config.scheme inputs.base16-emacs;
    in ''
                (setq inferior-lisp-program "${pkgs.sbcl}/bin/sbcl")
                (add-to-list 'custom-theme-load-path "${
                  pkgs.runCommand "base16-emacs" {} ''mkdir $out; cp ${themeFile} $out/base16-${config.scheme.scheme-name}-theme.el''
                }")
                (custom-set-variables
                  '(base16-theme-distinct-fringe-background nil)
                  '(custom-safe-themes
                    '("${builtins.hashFile "sha256" themeFile}"))
                ) 
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
