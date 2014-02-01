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

;;----------------------------------------------------------------------
;; ELPA
;;----------------------------------------------------------------------
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")))
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(require 'popup)


;;----------------------------------------------------------------------
;; Interactively Do Things
;;----------------------------------------------------------------------
(require 'ido)
(ido-mode t)

;;
;; linum
;;
(global-linum-mode 1)

(require 'ein)

;;----------------------------------------------------------------------
;; el-get
;;----------------------------------------------------------------------
;
;(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;
;(unless (require 'el-get nil 'noerror)
;  (with-current-buffer
;      (url-retrieve-synchronously
;       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;    (let (el-get-master-branch)
;      (goto-char (point-max))
;      (eval-print-last-sexp))))
;
;(el-get 'sync)

;;----------------------------------------------------------------------
;; jedi
;;----------------------------------------------------------------------
;(add-hook 'python-mode-hook 'jedi:setup)
;(setq jedi:setup-keys t)                      ; optional
;(setq jedi:complete-on-dot t)                 ; optional

(add-to-list 'load-path "~/.emacs.d/autocomplete")
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

(add-to-list 'load-path "~/.emacs.d/jedi")
(require 'jedi)


;;----------------------------------------------------------------------
;; Fill Column Indicator
;;----------------------------------------------------------------------
(require 'fill-column-indicator)
(define-globalized-minor-mode
  global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)
(setq-default fci-rule-column 78)

;;----------------------------------------------------------------------
;; Python
;;----------------------------------------------------------------------
(setq py-install-directory "~/.emacs.d/python-mode")
(add-to-list 'load-path py-install-directory)
(require 'python-mode)

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
(setq py-smart-indentation t)

;;----------------------------------------------------------------------
;; Miscellaneous
;;---------------------------------------------------------------------
; specify the fringe width for windows -- this sets both the left and
; right fringes to 10
(require 'fringe)
(fringe-mode 10)

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


