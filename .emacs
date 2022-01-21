(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes '(tango-dark))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(doom-themes magit ein jedi epc virtualenvwrapper pyvenv python-environment pydoc python-mode markdown-mode websocket request dash ctable fill-column-indicator auto-complete popup el-get))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; List of all packages I want installed
(setq package-list '(el-get popup auto-complete fill-column-indicator
		     ctable dash request websocket markdown-mode
		     python-mode pydoc python-environment pyvenv
		     virtualenvwrapper
		     epc s jedi ein magit doom-themes
		     f s use-package emacsql emacsql-sqlite magit-section org org-roam
		     ))

;;----------------------------------------------------------------------
;; ELPA
;;----------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(when (not (file-directory-p "~/.emacs.d/elpa"))
  (message "Creating ~/.emacs.d/elpa")
  (make-directory "~/.emacs.d/elpa"))

;; Add all subdirectories of ~/.emacs.d/elpa to load-path
(let ((default-directory  "~/.emacs.d/elpa/"))
  (normal-top-level-add-subdirs-to-load-path))

(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; Install any package from package-list that isn't installed
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'popup)

;;----------------------------------------------------------------------
;; Interactively Do Things
;;----------------------------------------------------------------------
(require 'ido)
(ido-mode t)

(global-linum-mode 1)
(electric-indent-mode nil)

;;----------------------------------------------------------------------
;; Python
;;----------------------------------------------------------------------
;(setq py-install-directory "~/.emacs.d/python-mode")
;(add-to-list 'load-path py-install-directory)
(require 'python)
;(require 'python-mode)

; use IPython
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
; use the wx backend, for both mayavi and matplotlib
(setq py-python-command-args
  '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
(setq py-force-py-shell-name-p t)

; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
(setq py-split-windows-on-execute-p t)
; try to automagically figure out indentation
;(setq py-smart-indentation t)

;(require 'virtualenvwrapper)
(require 'python-environment)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
;; Used by virtualenvwrapper.el
(setq venv-location (expand-file-name "~/.virtualenvs"))
;; Used python-environment.el and by extend jedi.el
(setq python-environment-directory venv-location)

(require 'auto-complete)
;(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

;;----------------------------------------------------------------------
;; jedi
;;----------------------------------------------------------------------
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

(require 'ein)
(setq ein:use-auto-complete t)
(setq ein:use-smartrep t)

;;----------------------------------------------------------------------
;; git
;;----------------------------------------------------------------------
;(require 'git)

;;----------------------------------------------------------------------
;; Fill Column Indicator
;;----------------------------------------------------------------------
(require 'fill-column-indicator)
(define-globalized-minor-mode
  global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)
(setq-default fci-rule-column 78)

;;----------------------------------------------------------------------
;; Miscellaneous
;;---------------------------------------------------------------------
; specify the fringe width for windows -- this sets both the left and
; right fringes to 10
;(require 'fringe)
;(fringe-mode 10)

; lines which are exactly as wide as the window (not counting the
; final newline character) are not continued. Instead, when point is
; at the end of the line, the cursor appears in the right fringe.
(setq overflow-newline-into-fringe t)

; each line of text gets one line on the screen (i.e., text will run
; off the left instead of wrapping around onto a new line)
(setq truncate-lines t)
; truncate lines even in partial-width windows
(setq truncate-partial-width-windows t)

;; display line and column number in the bottom bar
(line-number-mode 1)
(column-number-mode 1)

;; Initial window size
(add-to-list 'default-frame-alist '(width . 82))
(add-to-list 'default-frame-alist '(height . 40))

;; Window scrolling
(global-set-key "\M-n"  (lambda () (interactive) (scroll-up   1)) )
(global-set-key "\M-p"  (lambda () (interactive) (scroll-down 1)) )

;; emacs functions for GMU dissertation
(add-hook 'LaTeX-mode-hook (lambda () (load "latex-functions")))

;;----------------------------------------------------------------------
;; Aliases
;;----------------------------------------------------------------------
(defalias 'einls 'ein:notebooklist-open)

(setq linum-format "%4d \u2502")

(menu-bar-mode -1)

;;----------------------------------------------------------------------
;; org-mode config
;;----------------------------------------------------------------------
(setq org-agenda-files '("~/org"))

(setq org-todo-keywords
      '((sequence "TODO(t)" "IN-PROGRESS(i)" "BLOCKED" "|" "DONE(d)")
        (sequence "|" "CANCELED(c)")))

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c C-l") 'org-insert-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-default-notes-file "~/org/notes.org")

(setq org-agenda-sorting-strategy
    '((agenda ts-uppriority-down time-up category-keep)
      (todo ts-down priority-down time-up category-keep)
      (tags priority-down category-keep)
      (search category-keep)))

(setq org-capture-templates
      '(("t" "Todo" entry  (file"~/org/tasks.org")
         "* TODO %? %t\n" :prepend t)
	("j" "Journal" entry (file+olp+datetree "~/org/journal.org")
	 "* %<%R: >%? %^g\n%t")))
(define-key global-map (kbd "C-c j")
  (lambda () (interactive) (org-capture nil "j")))
(define-key global-map (kbd "C-c t")
  (lambda () (interactive) (org-capture nil "t")))
(setq org-startup-with-inline-images t)

;;----------------------------------------------------------------------
;; org-roam
;;----------------------------------------------------------------------
(setq roam-home (expand-file-name "~/org-roam"))
(load (expand-file-name "~/.emacs.d/roam-init"))
;(org-roam-db-autosync-mode)
(setq org-roam-graph-viewer "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")
(require 'org-roam-protocol)

;;----------------------------------------------------------------------
;; magit
;;----------------------------------------------------------------------
(global-set-key (kbd "C-c g") 'magit-status)

;;----------------------------------------------------------------------
;; Theme
;;----------------------------------------------------------------------
(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
(load-theme 'doom-dark+ t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)
;; or for treemacs users
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

;;----------------------------------------------------------------------
;; Miscellaneous functions
;;----------------------------------------------------------------------
(load (expand-file-name "~/.emacs.d/my-functions"))

(global-set-key "\C-c\C-i" 'my-insert-file-name)
