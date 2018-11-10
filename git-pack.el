;;; git-pack.el --- Git configuration

;;; Commentary:

;;; Code:

(require 'magit)
(require 'magit-extras) ;; C-n/C-p
(define-key magit-mode-map (kbd "C-n") 'next-line)
(define-key magit-mode-map (kbd "C-p") 'previous-line)

(require 'fullframe)
(fullframe magit-status magit-mode-quit-window 'kill-on-quit)

(require 'git-gutter)
(add-hook 'prog-mode-hook 'git-gutter-mode)

(custom-set-variables
 '(custom-set-variables '(magit-auto-revert-mode nil))
 '(git-gutter:modified-sign " ") ;; two space
 '(git-gutter:added-sign "+")    ;; multiple character is OK
 '(git-gutter:deleted-sign "-")
 '(git-gutter:lighter " GG")
 '(git-gutter:disabled-modes '(org-mode)))

(set-face-background 'git-gutter:modified "blue") ;; background color
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

(defvar git-pack-mode-map nil "Keymap for git-pack mode.")
;; Initialized empty to ease update later on
(setq git-pack-mode-map
      (let ((map (make-sparse-keymap)))
	(define-key map (kbd "C-c d s") 'git-gutter:stage-hunk)
	(define-key map (kbd "C-c d t") 'git-gutter:toggle)
	(define-key map (kbd "C-c d p") 'git-gutter:previous-hunk)
	(define-key map (kbd "C-c d n") 'git-gutter:next-hunk)
	(define-key map (kbd "C-c d d") 'git-gutter:popup-hunk)
	(define-key map (kbd "C-c d r") 'git-gutter:revert-hunk)
	(define-key map (kbd "C-c d g") 'magit-status)
	(define-key map (kbd "C-c g")   'magit-status)
	map))

(define-minor-mode git-pack-mode
  "Minor mode to consolidate git-pack extensions.

\\{git-pack-mode-map}"
  :lighter " γ"
  :keymap git-pack-mode-map
  :global t)

(define-globalized-minor-mode global-git-pack-mode git-pack-mode git-pack-on)

(defun git-pack-on ()
  "Turn on `git-pack-mode'."
  (git-pack-mode +1))

(provide 'git-pack)
;;; git-pack ends here
