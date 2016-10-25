(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tango-dark)))
 '(inhibit-startup-screen t)
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
		     epc s jedi ein))

;;----------------------------------------------------------------------
;; ELPA
;;----------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

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
(electric-indent-mode 1)

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

