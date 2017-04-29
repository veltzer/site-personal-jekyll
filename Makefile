SOURCE_FOLDER:=blog
DESTINATION_FOLDER:=docs
SOURCES:=$(shell find $(SOURCE_FOLDER) -type f)
STAMP_FILE:=out/$(DESTINATION_FOLDER).stamp

.PHONY: all
all: $(STAMP_FILE)

$(STAMP_FILE): $(SOURCES) Makefile
	@jekyll build --source $(SOURCE_FOLDER) --destination $(DESTINATION_FOLDER)
	@touch $(STAMP_FILE)

.PHONY: clean
clean:
	rm -rf $(STAMP_FILE) $(DESTINATION_FOLDER)
