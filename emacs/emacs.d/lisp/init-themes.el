; color theme
(require-package 'color-theme-solarized)
(load-theme 'solarized 1)
(setq solarized-termcolors 256)

(require 'faces)

(set-face-attribute 'default nil
    :foundry "apple"
		:family "DejaVu_Sans_Mono")

(provide 'init-themes)
