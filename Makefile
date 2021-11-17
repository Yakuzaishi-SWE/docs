LMK = pdflatex

BASE_DIR = $(shell pwd)

OUT_DIR = $(shell pwd)/out
OUT_VERBALI = ${OUT_DIR}/verbali

STUDIO_F = "${BASE_DIR}/src/studio_capitolati/studio_capitolati.tex"
GLOASSARIO_F = "${BASE_DIR}/src/glossario/glossario.tex"
VERBALI_FILES = $(shell find $(BASE_DIR)/src/verbali/verbale_* -name 'verbale_*.tex')

all: dirs studio_di_fattibilita verbali clean

studio_di_fattibilita:
	@echo "Studio di Fattibilita: $(STUDIO_F)";
	@cd "$(shell dirname $(STUDIO_F))" ; \
	$(LMK) $(shell basename $(STUDIO_F)) > /dev/null;
	mv "$(shell dirname $(STUDIO_F))/$(shell basename $(STUDIO_F) .tex).pdf" $(OUT_DIR)


verbali: $(VERBALI_FILES)

$(VERBALI_FILES):
	@echo "Verbale: $@";
	@cd "$(shell dirname $@)" ; \
	$(LMK) $(shell basename $@) > /dev/null; \
	mv "$(shell basename $@ .tex).pdf" $(OUT_VERBALI);

glossario:
	@echo "Studio di Fattibilita: $(GLOASSARIO_F)";
	@cd "$(shell dirname $(GLOASSARIO_F))"; \
	$(LMK) $(shell basename $(GLOASSARIO_F)) > /dev/null ; \
	makeglossaries glossario; \
	$(LMK) $(shell basename $(GLOASSARIO_F)) > /dev/null ; \
	cp "$(shell basename $(GLOASSARIO_F) .tex).pdf" $(OUT_DIR); 

clean:
	@echo "cleaning aux files";
	@rm -f ${OUT_DIR}/*.aux ${OUT_DIR}/*.log ${OUT_DIR}/*.out ${OUT_DIR}/*.toc
	@rm -f ${OUT_VERBALI}/*.aux ${OUT_VERBALI}/*.log ${OUT_VERBALI}/*.out ${OUT_VERBALI}/*.toc

dirs:
	mkdir -p $(OUT_DIR)
	mkdir -p $(OUT_VERBALI)

gh-pages: all gh-pages-only

gh-pages-only:
	git checkout gh-pages
	mkdir -p docs
	mkdir -p docs/verbali/
	cp -r out/* docs/
	git add docs/
	git commit -m "updated gh-pages"
	git push
	git checkout dev

.PHONY: $(VERBALI_FILES)
