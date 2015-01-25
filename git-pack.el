;;; git-pack.el --- Git configuration

;;; Commentary:

;;; Code:

(require 'install-packages-pack)
(install-packages-pack/install-packs '(magit
                                       git-gutter
                                       fullframe))

;; magit

(require 'magit)
(require 'fullframe)

(eval-after-load 'magit
  '(progn
     (fullframe magit-status magit-mode-quit-window)
     (define-key magit-status-mode-map (kbd "q") 'magit-mode-quit-window)))

;; git-pack

(require 'git-gutter)

(defvar git-pack-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c g s") 'git-gutter:stage-hunk)
    (define-key map (kbd "C-c g g") 'git-gutter:toggle)
    (define-key map (kbd "C-c g p") 'git-gutter:previous-diff)
    (define-key map (kbd "C-c g n") 'git-gutter:next-diff)
    (define-key map (kbd "C-c g d") 'git-gutter:popup-diff)
    (define-key map (kbd "C-c g r") 'git-gutter:revert-hunk)
    map)
  "Keymap for git-pack mode.")

(add-hook 'prog-mode-hook 'git-gutter-mode)

(custom-set-variables
 '(git-gutter:modified-sign " ") ;; two space
 '(git-gutter:added-sign "+")    ;; multiple character is OK
 '(git-gutter:deleted-sign "-")
 '(git-gutter:lighter " GG")
 '(git-gutter:disabled-modes '(org-mode)))

(set-face-background 'git-gutter:modified "blue") ;; background color
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

(define-minor-mode git-pack-mode
  "Minor mode to consolidate git-pack extensions.

\\{git-pack-mode-map}"
  :lighter " GP"
  :keymap git-pack-mode-map)

(define-globalized-minor-mode global-git-pack-mode git-pack-mode git-pack-on)

(defun git-pack-on ()
  "Turn on `git-pack-mode'."
  (git-pack-mode +1))

(global-git-pack-mode)

(provide 'git-pack)
;;; git-pack ends here
