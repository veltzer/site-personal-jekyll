##############
# parameters #
##############
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1
# run jekyll?
DO_JEKYLL:=0

########
# code #
########
ALL:=
SOURCE_FOLDER:=blog
DESTINATION_FOLDER:=docs
SOURCES:=$(shell find $(SOURCE_FOLDER) -type f)
STAMP_FILE:=build.stamp

ifeq ($(DO_JEKYLL),1)
ALL+=$(STAMP_FILE)
endif # DO_JEKYLL

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
	$(Q)rm -rf $(STAMP_FILE) $(DESTINATION_FOLDER)

.PHONY: clean_hard
clean_hard:
	$(info doing $@)
	$(Q)git clean -qffxd

.PHONY: new
new:
	$(info doing $@)
	$(Q)jekyll new blog

##########
# alldep #
##########
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP
