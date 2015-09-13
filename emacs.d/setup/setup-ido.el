;; ido/flx/ido-ubiquitous
(req-package ido
  :init (ido-mode t)
  :config
  (progn
    (setq ido-enable-prefix nil
          ido-enable-flex-matching t
          ido-case-fold nil
          ido-auto-merge-work-directories-length -1
          ido-use-filename-at-point nil
          ido-use-faces nil
          ido-max-prospects 10)

    (defun ido-define-keys()
      (define-key ido-completion-map (kbd "C-f") 'ido-enter-find-file))
    (add-hook 'ido-setup-hook 'ido-define-keys)))

(req-package flx-ido
  :init (flx-ido-mode t))

(req-package ido-vertical-mode
  :init (ido-vertical-mode)
  :config (progn
            (setq ido-vertical-define-keys 'C-n-C-p-up-and-down)))


(req-package ido-ubiquitous
  :init (ido-ubiquitous-mode t))

(provide 'setup-ido)
