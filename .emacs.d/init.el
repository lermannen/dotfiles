(require 'cask "/usr/local/Cellar/cask/0.7.4/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(setq default-input-method "MacOSX")
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil)
  (setq mac-allow-anti-aliasing t)
  (setq mac-command-key-is-meta t))

;;Add the following to your init file to have packages installed by Homebrew added to your load-path:
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(global-linum-mode)
(scroll-bar-mode -1)

(add-to-list 'exec-path "/Users/alexander.korling/src/klarna/otp-bin/install/R15B03-1/bin")

(setq-default require-final-newline t)
(setq column-number-mode t)
(setq-default show-trailing-whitespace t)
(setq-default indent-tabs-mode nil)
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

(condition-case err
    (load-theme 'alex-spolsky t)
  (error (message "Failed to load the alex-spolsky theme: %s" err)))

(add-hook 'after-init-hook 'my-after-init-hook)
(defun my-after-init-hook ()
  (require 'edts-start))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("eb73d1b604135b94fe309af73a6f5a5ae8ec01f31de7631ddfab24ebee1c23ca" default)))
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(safe-local-variable-values (quote ((allout-layout . t))))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
	     "~/.emacs.d/.cask/24.5.1/elpa/auto-complete-20150618.1949/dict")
(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

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

(require 'grizzl)
(projectile-global-mode)
(setq projectile-enable-caching nil)
(setq projectile-completion-system 'grizzl)
;; Press Command-p for fuzzy find in project
(global-set-key (kbd "M-p") 'projectile-find-file)
;; Press Command-å for fuzzy switch buffer
(global-set-key (kbd "M-å") 'projectile-switch-to-buffer)

(require 'rubocop)
(desktop-save-mode 1)

(setq backup-directory-alist
      (list (cons "." (expand-file-name "backup" user-emacs-directory))))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/backup/\\1" t)))

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

(require 'alchemist)

;; default font
(set-face-attribute 'default nil :family "Menlo")

;; font for all unicode characters
(set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)
;; Menlo
