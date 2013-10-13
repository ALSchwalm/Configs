(add-to-list 'load-path "~/.emacs.d/")

;; pakages
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  )
  
(setq delete-by-moving-to-trash t)

(require 'better-defaults)

;; linux style indents
(setq c-default-style "linux"
      c-basic-offset 4)
	  
;; don't let the cursor go into minibuffer prompt
(setq minibuffer-prompt-properties (quote 
	(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt)))
               
;; flyspell mode for spell checking everywhere
(add-hook 'org-mode-hook 'turn-on-flyspell 'append)

;;Put backups/autosave in temp directory        
(setq backup-directory-alist
    `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
    `((".*" ,temporary-file-directory t)))

;; Set browse-kill-ring defaults
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; copy/past/undo hotkeys
(cua-mode t)

;; remove bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; show column and line number
(column-number-mode 1)
(global-linum-mode 1)

;; trunkate long lines rather than wrapping
(set-default 'truncate-lines t)

;; re-indent on newline
(define-key global-map (kbd "RET") 'newline-and-indent)


;; auto-complete setup
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)

(add-to-list 'load-path "~/.emacs.d//helm")
(require 'helm-config)

;; Add basic delete word method
(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))

;; Stop delete word at newlines
(defun whitespace-backward-delete-word ()
  (interactive)
  (if (bolp)
      (backward-delete-char 1)
    (if (string-match "^\\s-+$" (buffer-substring (point-at-bol) (point)))
        (delete-region (point-at-bol) (point))
      (backward-delete-word 1))))

;; Load theme
(require 'solarized-dark-theme)

;; Highlight current line
(global-hl-line-mode)

(global-set-key [C-backspace] 'whitespace-backward-delete-word)
(global-set-key (kbd "M-n") 'scroll-up)
(global-set-key (kbd "M-p") 'scroll-down)
(global-set-key [C-tab] 'other-window)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(inhibit-startup-screen t)
 '(mouse-wheel-scroll-amount (quote (1 ((shift) . 1))))
 '(org-startup-indented t)
 '(initial-scratch-message
 
 ";; This buffer is for notes you don't want to save, and for Lisp evaluation.

 ")
 '(scroll-conservatively 1000))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(region ((t (:background "tan" :foreground "gtk_selection_fg_color"))))
 )
