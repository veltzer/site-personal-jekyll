BLOG_FOLDER:=blog
SOURCES:=$(shell find $(BLOG_FOLDER) -type f)
STAMP_FILE:=out/docs.stamp


.PHONY: all
all: $(STAMP_FILE)

$(STAMP_FILE): $(SOURCES) Makefile
	@jekyll build --source $(BLOG_FOLDER) --destination docs
	@touch $(STAMP_FILE)
