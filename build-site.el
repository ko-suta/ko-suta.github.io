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

;; Install dependencies
(package-install 'htmlize)
(package-install 'ox-tufte)

;; Load the publishing system
(require 'ox-publish)
(require 'ox-tufte)

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "<link rel=\"stylesheet\" href=\"https://github.com/edwardtufte/tufte-css/blob/c0a7db6a5de4e089b7234d0b93569f9ed71e0f46/tufte.css\" />"


;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "Website"
             :recursive t
             :base-directory "./content"
             :publishing-directory "./public"
	     :publishing-function 'org-html-publish-to-html
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc t                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil)))    ;; Don't include time stamp in file

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
