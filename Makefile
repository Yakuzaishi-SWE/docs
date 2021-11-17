BASE_DIR = $(shell pwd)
OUT_DIR = $(shell pwd)/out
OUT_VERBALI = ${OUT_DIR}/verbali

STUDIO_F = "${BASE_DIR}/src/studio_fattibilita/studio_fattibilita.tex"
VERBALI_FILES = $(shell find $(BASE_DIR)/src/verbali/verbale_* -name 'verbale_*.tex')

all: dirs studio_di_fattibilita verbali clean

studio_di_fattibilita:
	@echo "Studio di Fattibilita: $(STUDIO_F)";
	@cd "$(shell dirname $(STUDIO_F))" ; \
	pdflatex -output-directory ${OUT_DIR} $(shell basename $(STUDIO_F)) > /dev/null

verbali: $(VERBALI_FILES)

$(VERBALI_FILES):
	@echo "Verbale: $@";
	@cd "$(shell dirname $@)" ; \
	pdflatex $(shell basename $@) > /dev/null; \
	mv "$(shell basename $@ .tex).pdf" $(OUT_VERBALI);

clean:
	@echo "cleaning aux files";
	@rm -f ${OUT_DIR}/*.aux ${OUT_DIR}/*.log ${OUT_DIR}/*.out ${OUT_DIR}/*.toc
	@rm -f ${OUT_VERBALI}/*.aux ${OUT_VERBALI}/*.log ${OUT_VERBALI}/*.out ${OUT_VERBALI}/*.toc

dirs:
	mkdir -p $(OUT_DIR)
	mkdir -p $(OUT_VERBALI)

gh-pages: all
	git checkout gh-pages
	mkdir -p docs
	mkdir -p docs/verbali/
	cp -r out/* docs/
	git add docs/
	git commit -m "updated gh-pages"
	git push

.PHONY: $(VERBALI_FILES)
