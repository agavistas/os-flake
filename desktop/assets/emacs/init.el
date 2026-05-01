;; Disable unnecessary GUI bits
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)

;; Multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;; Move backups so they don't collide with repositories
(setq backup-directory-alist '(("." . "~/emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;; Enable necessary GUI bits
(add-hook 'lisp-mode-hook (lambda nil (push (cons "nil" 8709) prettify-symbols-alist)
			    (prettify-symbols-mode)
			    (keymap-local-set "S-s-<0x10081247>" "l a m b d a")))
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'prettify-symbols-mode)

;; Tell SLIME to use sbcl

;; Prevent Dired from opening a trillion buffers
(setf dired-kill-when-opening-new-dired-buffer t)

;; Load badwolf custom-theme
(load-theme 'badwolf t)

(custom-set-variables
 ;; Enable relative line numbers
 '(display-line-numbers-type (quote relative))
 ;; Enable nicer gdb UI
 '(gdb-many-windows t)
 ;; Set AuCTeX to use internal PDF viewing through the pdf-tools package
 '(TeX-source-correlate-mode t)
 '(TeX-view-program-selection
   '(((output-dvi has-no-display-manager) "dvi2tty")
     ((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi")
     (output-pdf "PDF Tools") (output-html "xdg-open")))
 ;; Add Work Schedule
 '(org-agenda-files
   '("~/Documents/org/schedule.org" "~/Documents/org/events.org")))

;; Necessary for pdf-tools
(add-hook 'LaTeX-mode-hook #'pdf-tools-install)
;; Auto-update PDF view on LaTeX compile
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
(setq TeX-save-query nil)
;; Enable cdlatex when editing files with AuCTeX
(add-hook 'LaTeX-mode-hook #'turn-on-cdlatex)

;; Org mode testing
;; This is primarily intended to service my note-taking
(setq org-startup-indented t)
(setq org-html-validation-link nil)
(setq org-highlight-latex-and-related '(latex script entities))
(add-hook 'org-mode-hook #'turn-on-org-cdlatex)

;; Display my agenda
(setq inhibit-splash-screen t)
(org-agenda-list)
(delete-other-windows)

