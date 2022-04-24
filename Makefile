##############
# parameters #
##############
DO_TOOLS:=1

########
# code #
########
SOURCE_FOLDER:=blog
DESTINATION_FOLDER:=docs
SOURCES:=$(shell find $(SOURCE_FOLDER) -type f)
STAMP_FILE:=build.stamp
TOOLS=tools.stamp

ifeq ($(DO_TOOLS),1)
.EXTRA_PREREQS+=$(TOOLS)
endif

#########
# rules #
#########
.PHONY: all
all: $(STAMP_FILE)
	@true

$(TOOLS):
	@gem install jekyll

$(STAMP_FILE): $(SOURCES) Makefile
	@jekyll build --source $(SOURCE_FOLDER) --destination $(DESTINATION_FOLDER)
	@touch $(STAMP_FILE)

.PHONY: clean
clean:
	rm -rf $(STAMP_FILE) $(DESTINATION_FOLDER)

.PHONY: new
new:
	jekyll new blog
