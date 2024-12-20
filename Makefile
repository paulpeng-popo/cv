SOURCES = $(wildcard *.tex)
TARGETS = $(patsubst %.tex,%.pdf,$(SOURCES))
BUILD_DIR = build.nosync

# check if quiet is defined
ifdef quiet
SILENT = -silent
else
SILENT =
endif
# enable SILENT by `make quiet=1`

LATEXMK = latexmk
LATEXMKFLAGS = -xelatex -outdir=$(BUILD_DIR) $(SILENT)

.PHONY: all watch clean

all: $(TARGETS)

%.pdf: %.tex
	$(LATEXMK) $(LATEXMKFLAGS) $<
	cp $(BUILD_DIR)/$@ .

watch:
# first check if sources only contain one file
# if not, get input from user
	@if [ $(words $(SOURCES)) -ne 1 ]; then \
		echo "Multiple source files detected. Please specify the file to watch."; \
		echo "Available files: $(SOURCES)"; \
		read -p "File to watch: " file; \
	else \
		file=$(SOURCES); \
	fi; \
	echo "Watching $$file"; \
	$(LATEXMK) $(LATEXMKFLAGS) -pvc $$file

clean:
	$(LATEXMK) $(LATEXMKFLAGS) -C $(SOURCES)
	rm -rf $(BUILD_DIR)
	rm -f $(TARGETS)
