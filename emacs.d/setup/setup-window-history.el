;; Setup window history

(defvar window-history/saved-window)

(defun window-history/helm-past-ring-candidates ()
  (let ((ring (window-parameter window-history/saved-window 'window-history/past-ring)))
    (cl-loop with markers = (ring-elements ring)
             for marker in markers
             for m = (helm-global-mark-ring-format-buffer marker)
             collect (cons m marker) into res
             finally return res)))

(defun window-history/helm-past-ring-default-action (candidate)
  (let ((target (copy-marker candidate)))
    (helm-aif (marker-buffer candidate)
        (progn
          (switch-to-buffer it)
          (helm-log-run-hook 'helm-goto-line-before-hook)
          (helm-match-line-cleanup)
          (with-helm-current-buffer
            (unless helm-yank-point (setq helm-yank-point (point))))
          (helm-goto-char target)
          (helm-highlight-current-line))
      (error "Marker points to no buffer"))))

(defvar window-history/helm-source-past-ring
  (helm-build-sync-source "Window History Past Ring"
    :candidates #'window-history/helm-past-ring-candidates
    :action '(("Goto line" . window-history/helm-past-ring-default-action))
    :persistent-help "Goto this location"
    :group 'helm-ring))

(defun helm-window-history ()
  (interactive)
  (let ((window-history/saved-window (selected-window)))
    (helm :sources #'window-history/helm-source-past-ring
         :resume 'noresume
         :buffer "*helm window history*")))

(defmacro window-history/--without-advice (body)
  `(progn
     (remove-hook 'buffer-list-update-hook #'window-history/push)
     (advice-remove 'push-mark #'window-history/push)
     (advice-remove 'set-mark #'window-history/push)
     ,body
     (add-hook 'buffer-list-update-hook #'window-history/push)
     (advice-add 'push-mark :before #'window-history/push)
     (advice-add 'set-mark :before #'window-history/push)))

(defun window-history/reset-past-ring ()
  (let* ((window (selected-window))
         (new-ring (make-ring 20)))
    (set-window-parameter window 'window-history/past-ring new-ring)))

(defun window-history/push (&rest e)
  (interactive)
  (window-history/--without-advice
   (let ((inhibit-message t))
     (let* ((window (selected-window))
            (push-ring (or (window-parameter window 'window-history/past-ring)
                           (make-ring 20)))
            (marker (point-marker)))
       (when (or (ring-empty-p push-ring)
                 (not (equal (ring-ref push-ring 0) marker)))
         (ring-insert push-ring marker)
         (set-window-parameter window 'window-history/past-ring push-ring))))))

(defun window-history/back ()
  (interactive)
  (window-history/--without-advice
   (let* ((inhibit-message t)
          (window (selected-window))
          (push-ring (window-parameter window 'window-history/past-ring)))
     (if (and push-ring (not (ring-empty-p push-ring)))
         (let ((position (ring-remove push-ring 0)))

           ;; Find the most recent location that isn't the current one
           (while (and (not (ring-empty-p push-ring))
                       (equal position (point-marker)))
             (setq position (ring-remove push-ring 0)))

           (if (not (equal position (point-marker)))
               (progn
                 (unless (equal (current-buffer) (marker-buffer position))
                   (switch-to-buffer (marker-buffer position)))
                 (goto-char position)

                 ;; TODO: avoid recentering when jumping nearby
                 (recenter)))
           (set-window-parameter window 'window-history/past-ring push-ring))))))

;; There is no good hook for this, so try to advice the relevant functions
(advice-add 'push-mark :before #'window-history/push)
(advice-add 'set-mark :before #'window-history/push)

;; Also hook the buffer list change, so we can go back if a command
;; takes us somewhere else.
(add-hook 'buffer-list-update-hook #'window-history/push)

(provide 'setup-window-history)
