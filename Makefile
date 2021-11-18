LMK = pdflatex

BASE_DIR = $(shell pwd)

OUT_DIR = "$(shell pwd)/out"
OUT_VERBALI = "${OUT_DIR}/verbali"

STUDIO_F = "${BASE_DIR}/src/studio_capitolati/studio_capitolati.tex"
SCELTA_F = "${BASE_DIR}/src/scelta_capitolato/scelta_capitolato.tex"
NORME_P_F = "${BASE_DIR}/src/norme_progetto/norme_progetto.tex"
IMPEGNI_F = "${BASE_DIR}/src/impegni/impegni.tex"
GLOASSARIO_F = "${BASE_DIR}/src/glossario/glossario.tex"
VERBALI_FILES = $(shell find $(BASE_DIR)/src/verbali/verbale_* -name 'verbale_*.tex')

all: dirs studio_capitolati scelta impegni norme_progetto glossario verbali

dirs:
	mkdir -p $(OUT_DIR)
	mkdir -p $(OUT_VERBALI)

impegni:
	@echo "Impegni: $(IMPEGNI_F)";
	@cd "$(shell dirname $(IMPEGNI_F))" ; \
	$(LMK) $(shell basename $(IMPEGNI_F)) > /dev/null;
	mv "$(shell dirname $(IMPEGNI_F))/$(shell basename $(IMPEGNI_F) .tex).pdf" $(OUT_DIR)

norme_progetto:
	@echo "Norme Progetto: $(NORME_P_F)";
	@cd "$(shell dirname $(NORME_P_F))" ; \
	$(LMK) $(shell basename $(NORME_P_F)) > /dev/null;
	mv "$(shell dirname $(NORME_P_F))/$(shell basename $(NORME_P_F) .tex).pdf" $(OUT_DIR)

studio_capitolati:
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
	@echo "Glossario: $(GLOASSARIO_F)";
	@cd "$(shell dirname $(GLOASSARIO_F))"; \
	$(LMK) $(shell basename $(GLOASSARIO_F)) > /dev/null ; \
	makeglossaries glossario; \
	$(LMK) $(shell basename $(GLOASSARIO_F)) > /dev/null ; \
	cp "$(shell basename $(GLOASSARIO_F) .tex).pdf" $(OUT_DIR); 

scelta:
	@echo "Scelta Capitolato: $(SCELTA_F)";
	@cd "$(shell dirname $(SCELTA_F))" ; \
	$(LMK) $(shell basename $(SCELTA_F)) > /dev/null;
	mv "$(shell dirname $(SCELTA_F))/$(shell basename $(SCELTA_F) .tex).pdf" $(OUT_DIR)

gh-pages: all gh-pages-only

gh-pages-only:
	git checkout gh-pages
	mkdir -p verbali/
	cp -r out/* ./
	ls verbali/verbale_* -w 1 > verbali/list
	git add .
	git commit -m "updated gh-pages"
	git push
	git checkout dev

.PHONY: $(VERBALI_FILES)
