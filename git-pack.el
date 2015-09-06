;;; git-pack.el --- Git configuration

;;; Commentary:

;;; Code:

(use-package fullframe)

(use-package magit
  :config
  (custom-set-variables '(magit-auto-revert-mode nil)
                        '(magit-last-seen-setup-instructions "1.4.0")
                        '(magit-push-always-verify "PP"))

  (use-package fullframe
    :config
    (fullframe magit-status magit-mode-quit-window 'kill-on-quit)))

(use-package git-gutter
  :init
  (add-hook 'prog-mode-hook 'git-gutter-mode)

  (custom-set-variables
   '(git-gutter:modified-sign " ") ;; two space
   '(git-gutter:added-sign "+")    ;; multiple character is OK
   '(git-gutter:deleted-sign "-")
   '(git-gutter:lighter " GG")
   '(git-gutter:disabled-modes '(org-mode)))

  (set-face-background 'git-gutter:modified "blue") ;; background color
  (set-face-foreground 'git-gutter:added "green")
  (set-face-foreground 'git-gutter:deleted "red"))

(defvar git-pack-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c g s") 'git-gutter:stage-hunk)
    (define-key map (kbd "C-c g g") 'git-gutter:toggle)
    (define-key map (kbd "C-c g p") 'git-gutter:previous-hunk)
    (define-key map (kbd "C-c g n") 'git-gutter:next-hunk)
    (define-key map (kbd "C-c g d") 'git-gutter:popup-hunk)
    (define-key map (kbd "C-c g r") 'git-gutter:revert-hunk)
    map)
  "Keymap for git-pack mode.")

(define-minor-mode git-pack-mode
  "Minor mode to consolidate git-pack extensions.

\\{git-pack-mode-map}"
  :lighter " γ"
  :keymap git-pack-mode-map)

(define-globalized-minor-mode global-git-pack-mode git-pack-mode git-pack-on)

(defun git-pack-on ()
  "Turn on `git-pack-mode'."
  (git-pack-mode +1))

(global-git-pack-mode)

(provide 'git-pack)
;;; git-pack ends here
