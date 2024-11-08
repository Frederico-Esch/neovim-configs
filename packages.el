(require 'package)

(setq package-archives '(("melpa"        . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org"          . "https://orgmode.org/elpa/")
			 ("elpa"         . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))

(unless (package-installed-p 'use-package) (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package diminish)

(use-package magit)

(use-package counsel
  :diminish
  :bind ("M-x"     . counsel-M-x)
  ("C-x b"   . counsel-switch-buffer)
  ("C-x C-f" . 'counsel-find-file)
  :config
  (counsel-mode 1)
  (setq ivy-initial-inputs-alist nil))

(use-package ivy
  :diminish
  :config (ivy-mode 1)
  :bind (;;("C-s"   . swiper)
	 :map ivy-minibuffer-map
	      ("TAB" . ivy-next-line)
	      ("RET" . ivy-alt-done)))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package evil
  :diminish evil-mode
  :init 
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  (evil-mode))

(use-package evil-collection
 :after evil
 :config (setq evil-collection-mode-list '(dashboard dired ibuffer))
 (evil-collection-init))

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold   t
	doom-themes-enable-italic t)
  (doom-themes-org-config))

(use-package which-key
  :diminish
  :init (which-key-mode))

(use-package doom-modeline
  :diminish
  :init (doom-modeline-mode 1)
  :config
  (setq which-key-idle-delay 0.3))

(use-package surround
  :bind-keymap ("M-'" . surround-keymap))
