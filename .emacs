(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)


(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
;; add dumb jump from list-packages

(global-set-key [f4] 'compile)
(setq visible-bell t) 
(global-set-key (kbd "C-k") 'kill-whole-line)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extented-command)
;; smex can be installed from list-packages (MELPA)

(setq line-number-mode t)

(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(ido-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("16e7c7811fd8f1bc45d17af9677ea3bd8e028fce2dd4f6fa5e6535dea07067b1" default))
 '(package-selected-packages '(gh-md dumb-jump magit gruber-darker-theme smex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq backup-directory-alist '(("." . "~/.emacs_saves")))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(global-set-key [f12] 'gh-md-render-buffer)

(defun markdown_render_on_save ()
  "Run markdown render every time a .md file is saved"
    (when (and (stringp buffer-file-name)
             (string= (file-name-extension buffer-file-name) "md"))
    (gh-md-render-buffer)))

(add-hook 'after-save-hook 'markdown_render_on_save)


(require 'ansi-color)
(defun my/ansi-colorize-buffer ()
  (let ((buffer-read-only nil))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook 'my/ansi-colorize-buffer)
