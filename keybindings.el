(use-package general
  :config
  (general-evil-setup)

  (general-create-definer mybindings/leader-key
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (mybindings/leader-key
   "b"   '(:ignore t             :which-key "Buffers")
   "bb"  '(counsel-switch-buffer :which-key "Switch Buffer")
   "bl"  '(list-buffers          :which-key "List Buffer")
   "bd"  '(kill-current-buffer   :which-key "Kill Buffer")

   "w"   '(:ignore t         :which-key "Window")
   "wq"  '(evil-quit         :which-key "Kill Window")
   "wl"  '(evil-window-right :which-key "Right Window")
   "wk"  '(evil-window-up    :which-key "Up Window")
   "wj"  '(evil-window-down  :which-key "Down Window")
   "wh"  '(evil-window-left  :which-key "Left Window")

   "f"  '(:ignore t         :which-key "Files")
   "ff" '(counsel-find-file :which-key "Find File")
   "fg" '(counsel-git       :which-key "Find File in git")

   "c"  '(:ignore t                    :which-key "Code")
   "ca" '(lsp-execute-code-action      :which-key "Code Action")
   "ce" '(lsp-ui-flycheck-list         :which-key "Diagnostics")
   "cd" '(lsp-ui-peek-find-definitions :which-key "Find Definition")
   "ch" '(lsp-ui-doc-toggle            :which-key "Show Doc")
   "cf" '(lsp-ui-doc-focus-frame       :which-key "Focus Doc")
   "cr" '(lsp-rename                   :which-key "Rename")

   "r"  '(:ignore t  :which-key "Rename")
   "rn" '(lsp-rename :which-key "Rename")

   "e"  '(lsp-ui-flycheck-list :which-key "Diagnostics")

   "g"  '(magit-status :which-key "Fugitive | Magit")

   "m" '(counsel-evil-marks :which-key "Evil Marks")

   "l" '(counsel-rg :which-key "Live Grep in Files")
   
   "x" '(counsel-M-x :which-key "Exec (M-x)"))

  (general-def evil-normal-state-map "C-q" 'evil-visual-block)
  (general-def evil-normal-state-map "S-w" 'evil-quit)
  (general-def evil-normal-state-map "S-k" 'lsp-ui-doc-toggle)
  (general-def evil-normal-state-map "T" (lambda () (interactive)
					   (let ((w (split-window-vertically 35)))
					     (select-window w)
					     (eshell)))))
