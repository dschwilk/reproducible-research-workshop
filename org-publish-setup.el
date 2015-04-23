(load "~/.emacs.d/init.el")  ;; brute force htmlize and font lock stuff 

(package-initialize)
(show-paren-mode 1)
(menu-bar-mode 0)

(require 'ess-site)
(require 'htmlize)
(require 'org)
;; to have things work correctly in batch-mode
(require 'font-lock)
(require 'cc-mode)
(require 'ox-org)
(c-after-font-lock-init)


(setq make-backup-files nil
      vc-handled-backends nil)

(setq org-export-default-language "en"
      org-publish-use-timestamps-flag t       ;; use t to avoid recompiling
      org-export-with-timestamps nil          ;; in ox-publish
      org-export-time-stamp-file nil          ;; Avoid unnecessary diffs
      org-export-with-section-numbers nil     ;; overwrite in files
      org-export-with-tags nil                ;; was 'not-in-toc
;; require braces to interpret  ^ and _
;;      org-export-with-sub-superscripts '{}
      org-latex-listings t                       ;; my default anyway
      org-html-head-include-default-style nil    ;; use custom stylesheet
      org-export-htmlize-output-type 'css
      org-startup-folded nil
      org-export-allow-bind-keywords t
      org-publish-list-skipped-files t
      org-export-babel-evaluate t
      org-confirm-babel-evaluate nil)


(setq org-html-preamble "<a name=\"top\" id=\"top\"></a>")
(setq org-html-postamble "
<div id=\"back-to-top\">
<a href=\"#top\">Back to top</a> | <a href=\"mailto:dylan.schwilk@ttu.edu\">E-mail Schwilk</a>
</div>"
)

(setq org-publish-project-alist
  '(("course-html" 
 :base-directory "./course-materials"
 :base-extension "org"
 :exclude "SETUP.+.org"   ;; exclude SETUPFILES
 :publishing-directory "./_site/"
 :recursive t
 :publishing-function org-html-publish-to-html
 :table-of-contents: nil
 :html-head "<link rel=\"stylesheet\" href=\"./styles/schwilk-org.css\" type=\"text/css\"/>"
 :html-preamble t
 :htmlized-source t
 :auto-postamble nil)
("course-static"
 :base-directory "./course-materials"
 :base-extension "css\\|js\\|png\\|pdf\\|jpg\\|gif\\|mp3\\|ogg\\|swf\\|R\\|csv\\|txt"
 :exclude "hw.+pdf\\|[0-9]+.+pdf\|_site.*"   ;; exclude homeworks and lecture slides
 :publishing-directory "./_site/"
 :recursive t
 :publishing-function org-publish-attachment)
("course" :components ("course-html" "course-static" ))))


;; command to publish
;;  emacs --batch -l org-publish-setup.el -f org-publish-all
