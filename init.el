;;; git-pack.el --- Git configuration

;;; Commentary:

;;; Code:

(install-packs '(magit
                 git-gutter))

(require 'magit)
;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

;; full screen magit-status
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(eval-after-load "magit"
  '(define-key magit-status-mode-map (kbd "q") 'magit-quit-session))

;; Git Gutter
(global-set-key (kbd "C-c g g") 'git-gutter:toggle)

;; Jump to next/previous diff
(global-set-key (kbd "C-c g p") 'git-gutter:previous-diff)
(global-set-key (kbd "C-c g n") 'git-gutter:next-diff)
(global-set-key (kbd "C-c g d") 'git-gutter:popup-diff)
(global-set-key (kbd "C-c g r") 'git-gutter:revert-hunk)


;;; git-pack ends here
