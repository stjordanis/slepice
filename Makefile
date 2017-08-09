RM=rm -f
TEX=pdflatex -interaction=nonstopmode
BIBTEX=bibtex
BIB=references.bib
COQDOC=coqdoc

TEX_DIR=tex/
SRC_DIR=src/
COQ_DIR=coq/
DOC_DIR=doc/
#MAIN=exquan-raw.tex
MAIN=exquan-nl.tex

META=$(SRC_DIR)fodtt-metavar.ott\
     $(SRC_DIR)fodttstar-metavar.ott

FODTT=$(SRC_DIR)fodtt-syntax.ott\
      $(SRC_DIR)fodtt-flas_both.ott\
      $(SRC_DIR)fodtt-typing.ott

FODTTSTAR=$(SRC_DIR)fodttstar-syntax.ott

FOHC=${SRC_DIR}fohc-metavar.ott\
     ${SRC_DIR}fohc-syntax.ott
    
TRANS=$(SRC_DIR)trans.ott


FODTTSTARLNL=$(SRC_DIR)fodttstar_lnl-syntax.ott

FODTTLNL=$(SRC_DIR)fodtt_lnl-syntax.ott\
         $(SRC_DIR)fodtt_lnl-typing.ott

#TRANSLNL=$(SRC_DIR)trans-lnl.ott

TERMINALS=$(SRC_DIR)terminals.ott



OTT=../ott/bin/ott

COQ=$(COQ_DIR)defns.v

.PHONY: clean veryclean

default: $(MAIN)

watch:	$(MAIN)
	latexmk -pdf -pvc $(MAIN)

pdf: $(MAIN)
	latexmk -pdf $(MAIN)

exquan-raw.tex: $(META) $(FODTTSTAR) $(FODTT) $(FOHC) $(TRANS) $(TERMINALS)
	$(OTT) \
	    -o $@ \
	    -o $(COQ_DIR)defns.v \
	    $(META) \
	    $(FODTTSTAR) \
	    $(FODTT) \
	    $(FOHC) \
	    $(TRANS) \
	    $(TERMINALS)

exquan-nl.tex: $(META) $(FODTT) $(FODTTSTAR) $(FODTTLNL) $(FODTTSTARLNL) $(TRANSLNL) $(TERMINALS)
	$(OTT) \
	    -tex_wrap true\
	    -tex_name_prefix fodtt \
	    -o $@ \
	    -o $(COQ_DIR)defns.v \
	    $(META) \
	    $(FODTTSTAR) \
	    $(FODTT) \
	    $(FODTTSTARLNL) \
	    $(FODTTLNL) \
	    $(TRANSLNL) \
	    $(TERMINALS)


coqdoc: $(COQ)
	$(COQDOC) --no-glob $(COQ) -d $(DOC_DIR)

#cleaning rules

clean:
	$(RM) *.aux *.xml *.bcf *.bbl *.blg *-blx.bib \
		*.log *.nav *.out *.vrb *.snm *.toc \
		X.tex *.bak *.pag *.fdb_latexmk *.fls \
		exquan-raw.tex exquan-nl.tex

veryclean: clean
	$(RM) *.pdf *.dvi

