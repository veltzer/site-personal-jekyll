##############
# parameters #
##############
# do you want to do tools?
DO_TOOLS:=1
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1

########
# code #
########
SOURCE_FOLDER:=blog
DESTINATION_FOLDER:=docs
SOURCES:=$(shell find $(SOURCE_FOLDER) -type f)
STAMP_FILE:=build.stamp
TOOLS=tools.stamp

# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

ifeq ($(DO_TOOLS),1)
.EXTRA_PREREQS+=$(TOOLS)
endif # DO_TOOLS

#########
# rules #
#########
.PHONY: all
all: $(TOOLS) $(STAMP_FILE)
	@true

$(TOOLS):
	$(info doing $@)
	$(Q)xargs -a packages.txt sudo apt-get install
	$(Q)bundle install --local
	$(Q)touch $@
# $(Q)gem install jekyll

$(STAMP_FILE): $(SOURCES) Makefile
	$(info doing $@)
	$(Q)jekyll build --source $(SOURCE_FOLDER) --destination $(DESTINATION_FOLDER)
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
