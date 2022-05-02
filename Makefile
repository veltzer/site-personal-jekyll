##############
# parameters #
##############
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1

########
# code #
########
ALL:=
SOURCE_FOLDER:=blog
DESTINATION_FOLDER:=docs
SOURCES:=$(shell find $(SOURCE_FOLDER) -type f)
STAMP_FILE:=build.stamp

ALL+=$(STAMP_FILE)

# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	@true

$(STAMP_FILE): $(SOURCES) Makefile
	$(info doing $@)
	$(Q)jekyll build --source $(SOURCE_FOLDER) --destination $(DESTINATION_FOLDER)
	$(Q)rm -f docs/feed.xml
	$(Q)touch $(STAMP_FILE)

.PHONY: clean
clean:
	$(info doing $@)
	$(Q)rm -rf $(TOOLS) $(STAMP_FILE) $(DESTINATION_FOLDER)

.PHONY: clean_hard
clean_hard:
	$(info doing $@)
	$(Q)git clean -qffxd

.PHONY: new
new:
	$(info doing $@)
	$(Q)jekyll new blog
