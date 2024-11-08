(load-theme 'doom-Iosvkem t)
;;(load-theme 'deeper-blue)
;;(load-theme 'tango-dark)

;;font
(set-face-attribute 'default nil :font "Iosevka Nerd Font" :height 180)

;;line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;;scroll offset
(setq scroll-margin 8
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)
