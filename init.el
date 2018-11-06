;;; emacs init

;; basic-setup
(show-paren-mode t)
(setq show-paren-style 'expression)
(add-hook 'find-file-hook (lambda() (ruler-mode t)))
(add-hook
 'before-save-hook
 (lambda()
   (delete-trailing-whitespace)
   (when (not indent-tabs-mode) (untabify (point-min) (point-max))))
 )

;; theme-setup
(if (not (display-graphic-p))
    (if (member 'tango-dark-default-none (custom-available-themes))
	(load-theme 'tango-dark-default-none t)
      (load-theme 'tango-dark))
  (load-theme 'tango-dark)
  (tool-bar-mode 0)
  (add-hook 'find-file-hook (lambda() (linum-mode 1)))
  )

;; melpa-setup
(require 'package)
(add-to-list
 'package-archives
 '("melpa-stable" . "https://stable.melpa.org/packages/")
 )
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; el-get setup
(unless (package-installed-p 'el-get)
  (package-install 'el-get))
(when (package-installed-p 'el-get)
  (add-to-list
   'load-path (concat user-emacs-directory "el-get/el-get"))
  (require 'el-get)
  (add-to-list
   'el-get-recipe-path (concat user-emacs-directory "el-get-user/recipes"))
  (el-get 'sync)
  )

;; init.d
(add-to-list 'load-path (concat user-emacs-directory "init.d"))

(require 'company-setup)
(require 'ivy-setup); + swiper, counsel;

(when (package-installed-p 'el-get) (require 'projectile-setup));

;; cc-mode setup
(require 'cc-gtags-setup)
(require 'cc-irony-setup);
(add-hook 'c-mode-common-hook (lambda() (setq indent-tabs-mode nil)))

;; python-mode setup
(require 'python-setup);
