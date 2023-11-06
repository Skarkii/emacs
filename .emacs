(load "~/.emacs.d/custom-commands/load-commands.el")


(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)



(require 'ansi-color)
(defun my/ansi-colorize-buffer ()
  (let ((buffer-read-only nil))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook 'my/ansi-colorize-buffer)


(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(add-to-list 'package-archives
             '("elpa" . "https://elpa.gnu.org/packages/"))

(global-set-key (kbd "M-x") 'smex)

(global-set-key [f4] 'compile)

(defun move-cursor-down ()
  "Move the cursor down by a specified number of lines."
  (interactive)
  (let ((lines (read-from-minibuffer "Move down by how many lines? ")))
    (if (string-match-p "\\`\\(?:-?[0-9]+\\)\\'" lines)
        (next-line (string-to-number lines))
      (message "Please enter a number."))))

(defun move-cursor-up ()
  "Move the cursor up by a specified number of lines."
  (interactive)
  (let ((lines (read-from-minibuffer "Move up by how many lines? ")))
    (if (string-match-p "\\`\\(?:-?[0-9]+\\)\\'" lines)
        (previous-line (string-to-number lines))
      (message "Please enter a number."))))

(global-set-key (kbd "M-n") 'move-cursor-down)
(global-set-key (kbd "M-p") 'move-cursor-up)

(global-set-key (kbd "C-x C-o") 'ff-find-other-file)

(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "C-c C-c") 'mc/edit-lines)
  (global-set-key (kbd "C-c C-n") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-c C-p") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-a") 'mc/mark-all-like-this))

(setq inhibit-startup-screen t)

(setq line-number-mode t)

(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(ido-mode 1)
(ido-everywhere 1)

(menu-bar-mode 0)
(tool-bar-mode 0)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("dccf4a8f1aaf5f24d2ab63af1aa75fd9d535c83377f8e26380162e888be0c6a9" "16e7c7811fd8f1bc45d17af9677ea3bd8e028fce2dd4f6fa5e6535dea07067b1" default))
 '(package-selected-packages
   '(yasnippet-snippets yasnippet clang-format projectile doom-themes modus-themes smex multiple-cursors move-text magit lsp-ui lsp-ivy helm-lsp gruber-darker-theme gh-md function-args flycheck dumb-jump dap-mode company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-signature-help-doc-face ((t (:foreground "Your_Foreground_Color"))))
 '(lsp-signature-help-param-face ((t (:foreground "Your_Foreground_Color")))))

(setq backup-directory-alist '(("." . "~/.emacs_saves")))


;; Clangd formatter
(require 'clang-format)

(defun my-clang-format-buffer ()
  "Format the current buffer using clang-format for C and C++ files."
  (interactive)
  (when (and (executable-find "clang-format")
             (or (derived-mode-p 'c++-mode)
                 (derived-mode-p 'c-mode)))
    (clang-format-buffer)))


(defun my-clang-format-region-bad ()
  "Format the current buffer using clang-format for C and C++ files."
  (interactive)
  (when (executable-find "clang-format")
    (when (or (derived-mode-p 'c++-mode)
              (derived-mode-p 'c-mode)))
      (clang-format-region)))

(defun my-clang-format-region (s e)
  (interactive
  (if (use-region-p)
      (list (region-beginning) (region-end))
    (list (point) (point))))
  (clang-format-region s e))

(defun my-format-region-or-navigate-forward ()
  "Format the region if selected, or navigate forward."
  (interactive)
  (if (use-region-p)
      (call-interactively 'my-clang-format-region)
    
    (forward-char)))

(global-set-key (kbd "C-f") 'my-format-region-or-navigate-forward)
;;(add-hook 'before-save-hook 'my-clang-format-buffer)


;; LSP MODE
;; The path to lsp-mode needs to be added to load-path as well as the
;; path to the `clients' subdirectory.
(add-to-list 'load-path (expand-file-name "lib/lsp-mode" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lib/lsp-mode/clients" user-emacs-directory))


;; if you want to change prefix for lsp-mode keybindings.
;; (setq lsp-keymap-prefix "C-c l")

(setq lsp-headerline-breadcrumb-enable nil)

(global-set-key (kbd "C-x l") 'lsp-signature-activate)

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (XXX-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language


(require 'lsp-mode)
(add-hook 'c++-mode-hook #'lsp)

(setq lsp-clients-clangd-executable "clangd")
