;; this one is only for the proxy environment in KUT
(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|172.16.2.30\\)")
     ("http" . "proxy.noc.kochi-tech.ac.jp:3128")
     ("https" . "proxy.noc.kochi-tech.ac.jp:3128")))

;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(require 'ox-publish)

(use-package htmlize
  :ensure t)

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />"
      ;; org-html-head "<link rel=\"stylesheet\" href=\"./content/tufte.css\" />"
      ;; org-html-head-extra "<link rel=\"stylesheet\" href=\"./content/ox-tufte.css\" />"
      )

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "website:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc t                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil)))    ;; Don't include time stamp in file

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
