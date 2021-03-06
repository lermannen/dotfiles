;; Startup

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Packages
(when (eq system-type 'darwin)
  (require 'cask "/usr/local/Cellar/cask/0.8.4/cask.el"))
(when (eq system-type 'gnu/linux)
  (require 'cask "~/.cask/cask.el"))
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))


(global-unset-key (kbd "C-z"))
(when (eq system-type 'gnu/linux)
  (require 'iso-transl))

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

(setq last-paste-to-osx nil)

;; Enable Emacs to copy and paste properly from the terminal
;; https://emacs.stackexchange.com/questions/26471/how-to-avoid-double-m-y-with-system-clipboard-integration-in-the-terminal
(defun copy-from-osx ()
  (let ((copied-text (shell-command-to-string "pbpaste")))
    (unless (string= copied-text last-paste-to-osx)
      copied-text)))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc)))
  (setq last-paste-to-osx text))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;; Ensure Emacs prefers UTF8 as a file encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)
(set-selection-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

(global-set-key (kbd "C-S-SPC") 'cycle-spacing)

(add-to-list 'load-path "path/to/which-key.el")
(require 'which-key)
(which-key-mode)


(require 'powerline)
(powerline-default-theme)

;; Snippets
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20150415.244/")
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
        ))
(yas-global-mode 1)


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

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
;; EDTS
(add-to-list 'load-path "~/src/edts_rebar3/")
;(require 'edts-start)
;(edts-log-set-level 'debug)

(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "/Users/alexander.korling/.emacs.d/.cask/26.1/elpa/")
  (require 'use-package))

(use-package erlang
  :init
  (add-to-list 'load-path "/usr/local/lib/erlang/lib/tools-3.0/emacs")
  :mode
  ("\\.P\\'" . erlang-mode)
  ("\\.E\\'" . erlang-mode)
  ("\\.S\\'" . erlang-mode)
  :config
  (setq erlang-indent-level 2)
  (add-hook 'erlang-mode-hook
            (lambda ()
              (setq mode-name "erl"
                    erlang-compile-extra-opts '((i . "../include"))
                    erlang-root-dir "/usr/local/lib/erlang"
                    exec-path (cons "/usr/local/lib/erlang/bin" exec-path)
                    ))))

(use-package edts-start
  :init (setq edts-inhibit-package-check t))

;; (add-hook 'after-init-hook 'my-after-init-hook)
;; (defun my-after-init-hook ()
;;   (require 'edts-start))

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
(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)

(dir-locals-set-class-variables 'kred-dir
                                '((nil . ((projectile-enable-caching . t)))))

(dir-locals-set-directory-class "~/src/kred" 'kred-dir)

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
;;(set-face-attribute 'default nil :family "Menlo")

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
    ("1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" "9d9fda57c476672acd8c6efeb9dc801abea906634575ad2c7688d055878e69d6" "b4c13d25b1f9f66eb769e05889ee000f89d64b089f96851b6da643cee4fdab08" "b35a14c7d94c1f411890d45edfb9dc1bd61c5becd5c326790b51df6ebf60f402" "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "3a3de615f80a0e8706208f0a71bbcc7cc3816988f971b6d237223b6731f91605" "2e5f6682c363402b0025b353ecec380ad55fef1e5918fde394796ab9c7ef9621" "e56ee322c8907feab796a1fb808ceadaab5caba5494a50ee83a13091d5b1a10c" "eb73d1b604135b94fe309af73a6f5a5ae8ec01f31de7631ddfab24ebee1c23ca" default)))
 '(desktop-save-mode t)
 '(edts-inhibit-package-check -1)
 '(exec-path-from-shell-arguments (quote ("-l")))
 '(inhibit-startup-screen t)
 '(linum-format " %3i ")
 '(markdown-command "multimarkdown")
 '(markdown-preview-style
   "http://thomasf.github.io/solarized-css/solarized-light.min.css")
 '(package-selected-packages
   (quote
    (use-package ag alchemist auto-complete auto-highlight-symbol dash-at-point doom-themes edts enh-ruby-mode eproject erlang exec-path-from-shell grizzl helm-projectile markdown-preview-mode multiple-cursors org-wunderlist pallet powerline rainbow-delimiters rainbow-mode robe rubocop smartparens undo-tree which-key yasnippet)))
 '(ruby-insert-encoding-magic-comment nil)
 '(safe-local-variable-values
   (quote
    ((erlang-ident-level . 2)
     (projectile-enable-caching . t)
     (allout-layout . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
(put 'upcase-region 'disabled nil)

(defun diff-region ()
  "Select a region to compare"
  (interactive)
  (when (use-region-p) ; there is a region
    (let (buf)
      (setq buf (get-buffer-create "*Diff-regionA*"))
      (save-current-buffer
        (set-buffer buf)
        (erase-buffer))
      (append-to-buffer buf (region-beginning) (region-end))))
  (message "Now select other region to compare and run `diff-region-now`"))

(defun diff-region-now ()
  "Compare current region with region already selected by `diff-region`"
  (interactive)
  (when (use-region-p)
    (let (bufa bufb)
      (setq bufa (get-buffer-create "*Diff-regionA*"))
      (setq bufb (get-buffer-create "*Diff-regionB*"))
      (save-current-buffer
        (set-buffer bufb)
        (erase-buffer))
      (append-to-buffer bufb (region-beginning) (region-end))
      (ediff-buffers bufa bufb))))
