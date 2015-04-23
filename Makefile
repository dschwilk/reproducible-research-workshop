# Makefile for org-publish and for creating and pushing html to Github Pages
#

BUILD_DIR = _site
SRC_BRANCH = master
GH_PAGES_SOURCES = Makefile org-publish-setup.el course-materials
CLEANUP = lectures/*.pdf lectures/*.png

.PHONY: help clean html gh-pages

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  html       to make HTML using org-publish"
	@echo "  gh-pages   to create html files in gh-pages branch and push to GitHub"

clean:
	-rm -rf $(BUILD_DIR)/*

html:
	emacs --batch -l org-publish-setup.el -f org-publish-all
	@echo
	@echo "Build finished. The HTML pages are in $(BUILD_DIR)/html."

gh-pages:
	git checkout gh-pages
	# rm -rf $(BUILD_DIR)
	git checkout $(SRC_BRANCH) $(GH_PAGES_SOURCES)
	git reset HEAD
	make html
	rsync -avu $(BUILD_DIR)/  ./
	rm -rf $(GH_PAGES_SOURCES) $(BUILD_DIR) $(CLEANUP)
	git add -A
	git commit -m "Generated gh-pages for `git log $(SRC_BRANCH) -1 --pretty=short --abbrev-commit`" && git push origin gh-pages ; git checkout $(SRC_BRANCH)
	@echo
	@echo "Build finished. The HTML pages built in gh-pages branch."
