(use-package org-roam
   :ensure t
   :init
   (setq org-roam-v2-ack t)
   :custom
   (org-roam-directory roam-home)
   (org-roam-completion-everywhere t)
   (org-roam-capture-templates
    '(("d" "default" plain
       "%?"
       :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
       :unnarrowed t)
      ("p" "project" plain
       (file "~/.emacs.d/roam-templates/project.org")
       :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: project")
       :unnarrowed t)
      ("s" "staff" plain
       (file "~/.emacs.d/roam-templates/staff.org")
       :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: person staff")
       :unnarrowed t))
    )
   :bind (("C-c n l" . org-roam-buffer-toggle)
	  ("C-c n f" . org-roam-node-find)
	  ("C-c n i" . org-roam-node-insert)
	  ("C-c n t" . org-roam-tag-add)
	  ("C-c n a" . org-roam-alias-add)
	  :map org-mode-map
	  ("C-M-i" . completion-at-point))
   :config
   (org-roam-setup))
