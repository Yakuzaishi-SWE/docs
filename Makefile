BASE_DIR = $(shell pwd)
OUT_DIR = $(shell pwd)/out
OUT_VERBALI = ${OUT_DIR}/verbali

VERBALI_FILES = $(shell find $(BASE_DIR)/src/verbali -name 'verbale_*.tex')

all: studio_di_fattibilita verbali clean

studio_di_fattibilita: studio_di_fattibilita.pdf

studio_di_fattibilita.pdf:
	cd ${BASE_DIR}/src/studio_fattibilita/ ; \
	pdflatex -output-directory ${OUT_DIR} "studio_fattibilita.tex"

clean: outclean verbaliclean

outclean:
	rm -f ${OUT_DIR}/*.aux ${OUT_DIR}/*.log ${OUT_DIR}/*.out ${OUT_DIR}/*.toc

verbaliclean: 
	rm -f ${OUT_VERBALI}/*.aux ${OUT_VERBALI}/*.log ${OUT_VERBALI}/*.out ${OUT_VERBALI}/*.toc

verbali: $(VERBALI_FILES)

$(VERBALI_FILES): FORCE
	cd $(shell dirname $@); \
	pdflatex -output-directory ${OUT_VERBALI} $@

FORCE: