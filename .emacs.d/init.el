;; Startup

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(desktop-save-mode 1)
(condition-case err
    (load-theme 'alex-spolsky t)
  (error (message "Failed to load the alex-spolsky theme: %s" err)))
(setq backup-directory-alist
      (list (cons "." (expand-file-name "backup" user-emacs-directory))))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/backup/\\1" t)))

;; Editor window
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode)
(setq-default require-final-newline t)
(setq column-number-mode t)
(setq-default show-trailing-whitespace t)
(setq-default indent-tabs-mode nil)
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

;; Ensure Emacs prefers UTF8 as a file encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)
(set-selection-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

(global-set-key (kbd "C-S-SPC") 'cycle-spacing)

;; Packages
(require 'cask "/usr/local/Cellar/cask/0.8.0/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

;; OS X
(when (eq system-type 'darwin)
  (setq exec-path (append "/usr/local/bin" exec-path))
  (setq ispell-program-name "/usr/local/bin/aspell")
  (setq default-input-method "MacOSX")
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil)
  (setq mac-allow-anti-aliasing t)
  (setq mac-command-key-is-meta t)
  ;; Add the following to your init file to have packages installed by Homebrew
  ;; added to your load-path:
  (let ((default-directory "/usr/local/share/emacs/site-lisp/"))
    (normal-top-level-add-subdirs-to-load-path)))

;; Helm
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(helm-mode 1)
;; Press Command-p for fuzzy find in project
(global-set-key (kbd "M-p") 'helm-projectile)

;; EDTS
(add-to-list 'exec-path "/Users/alexander.korling/src/klarna/otp-bin/install/R15B03-1/bin")
(add-hook 'after-init-hook 'my-after-init-hook)
(defun my-after-init-hook ()
  (require 'edts-start))

;; Auto complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
             "~/.emacs.d/.cask/25.1.1/elpa/auto-complete-20160827.649/dict")
(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

;; Ruby
(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("ruby" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode)
(show-smartparens-global-mode t)
(sp-with-modes '(rhtml-mode)
               (sp-local-pair "<" ">")
               (sp-local-pair "<%" "%>"))

(require 'rubocop)

;; Projectile
(require 'grizzl)
(projectile-global-mode)
(setq projectile-enable-caching nil)
(setq projectile-completion-system 'grizzl)

;; Press Command-å for fuzzy switch buffer
(global-set-key (kbd "M-å") 'projectile-switch-to-buffer)

;; Dash
(global-set-key "\C-cd" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)

;; Org
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; Ensure Emacs prefers UTF8 as a file encoding
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(defadvice find-file (before make-directory-maybe (filename &optional wildcards) activate)
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir)))))

(setq org-agenda-files (list "~/Dropbox/org_mode/work.org"
                             "~/Dropbox/org_mode/personal.org"
                             "~/Dropbox/org_mode/Wunderlist.org"))

;; Wunderlist
(require 'org-wunderlist)
(setq org-wunderlist-client-id "dd1aab12346b68eee52e"
      org-wunderlist-token "88f58910f3a0c2bf521e14122f2377a0690932e840b06b9d8cbe48e76013"
      org-wunderlist-file  "~/Dropbox/org_mode/Wunderlist.org"
      org-wunderlist-dir "~/Dropbox/org_mode/org-wunderlist/")

;; Everything else
(require 'alchemist)

;; default font
(set-face-attribute 'default nil :family "Menlo")

;; font for all unicode characters
(set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)

(defadvice find-file (before make-directory-maybe (filename &optional wildcards) activate)
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir)))))

(defun now ()
  "Insert string for the current time formatted like '2:34 PM'."
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%a %d %b %H:%M:%S")))

(require 'multiple-cursors)

;; Custom variables

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("2e5f6682c363402b0025b353ecec380ad55fef1e5918fde394796ab9c7ef9621" "e56ee322c8907feab796a1fb808ceadaab5caba5494a50ee83a13091d5b1a10c" "eb73d1b604135b94fe309af73a6f5a5ae8ec01f31de7631ddfab24ebee1c23ca" default)))
 '(desktop-save-mode t)
 '(inhibit-startup-screen t)
 '(linum-format " %3i ")
 '(markdown-command "multimarkdown")
 '(markdown-preview-style
   "http://thomasf.github.io/solarized-css/solarized-light.min.css")
 '(ruby-insert-encoding-magic-comment nil)
 '(safe-local-variable-values
   (quote
    ((projectile-enable-caching . t)
     (allout-layout . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)

(dir-locals-set-class-variables 'kred-dir
   '((nil . ((projectile-enable-caching . t)))))

(dir-locals-set-directory-class
   "/Users/alexander.korling/src/kred" 'kred-dir)
