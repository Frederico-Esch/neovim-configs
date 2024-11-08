(use-package flycheck)
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui)
(setq lsp-ui-sideline-show-enable t
      lsp-ui-sideline-show-diagnostics t
      lsp-ui-sideline-show-hover nil
      lsp-ui-sideline-delay .5

      lsp-ui-doc-show-with-cursor nil
      lsp-ui-doc-position 'at-point)

(use-package company
  :after lsp-mode
  :hook (prog-mode . company-mode)
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package tree-sitter-langs)
(use-package tree-sitter
  :init
  (global-tree-sitter-mode))

(use-package zig-mode)
(use-package platformio-mode)
;(use-package ccls)

;;language specific configs
(setq lsp-clients-clangd-args '("--header-insertion=never"))

;;hooks
;;tree-sitter hook
(add-hook 'tree-sitter-after-on-hook 'tree-sitter-hl-mode)

;;language hooks
;(defun lsp-and-platformio () (lsp-deferred) (platformio-conditionally-enable)) ;Teste

(add-hook 'c-mode-hook          (lambda () (lsp-deferred) (platformio-conditionally-enable) (hs-minor-mode)))
(add-hook 'c++-mode-hook        (lambda () (lsp-deferred) (platformio-conditionally-enable) (hs-minor-mode)))
(add-hook 'zig-mode-hook        'lsp-mode)
