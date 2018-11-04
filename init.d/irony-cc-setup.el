;; irony-cc-setup

(unless (package-installed-p 'company-irony-c-headers)
  (package-install 'company-irony-c-headers)) ; prerequisite: irony
(unless (package-installed-p 'company-irony)
  (package-install 'company-irony))

(require 'cc-mode)
(require 'irony)
(require 'company-irony-c-headers)
(require 'company-irony)
(eval-after-load 'company
  '(add-to-list
    'company-backends
    '(company-irony-c-headers company-irony)))
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(unless (irony--find-server-executable)
  (call-interactively #'irony-install-server))
(provide 'irony-cc-setup)
