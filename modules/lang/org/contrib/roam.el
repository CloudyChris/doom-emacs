;;; lang/org/contrib/roam.el -*- lexical-binding: t; -*-
;;;###if (featurep! +roam)

(use-package! org-roam
  :after org
  :preface
  ;; Set this to nil so we can later detect whether the user has set a custom
  ;; directory for it, and default to `org-directory' if they haven't.
  (defvar org-roam-directory nil)
  :init
  (map! :after org
        :map org-mode-map
        :localleader
        :prefix ("m" . "org-roam")
        "b" #'org-roam-switch-to-buffer
        "f" #'org-roam-find-file
        "g" #'org-roam-graph-show
        "i" #'org-roam-insert
        "m" #'org-roam
        (:prefix ("d" . "by date")
          :desc "Arbitrary date" "d" #'org-roam-date
          :desc "Today"          "t" #'org-roam-today
          :desc "Tomorrow"       "m" #'org-roam-tomorrow
          :desc "Yesterday"      "y" #'org-roam-yesterday))
  :config
  (unless org-roam-directory
    (setq org-roam-directory org-directory))
  (org-roam-mode +1))


;; Since the org module lazy loads org-protocol (waits until an org URL is
;; detected), we can safely chain `org-roam-protocol' to it.
(use-package! org-roam-protocol
  :after org-protocol)


(use-package! company-org-roam
  :when (featurep! :completion company)
  :after org-roam
  :config
  (set-company-backend! 'org-mode '(company-org-roam company-yasnippet company-dabbrev)))
