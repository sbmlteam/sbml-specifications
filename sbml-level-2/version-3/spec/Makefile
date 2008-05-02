SBML_PROJECT=../../../../project

SBML_TEX=$(SBML_PROJECT)/tex
SBML_BIB=$(SBML_PROJECT)/bib

SBML_TEXINPUTS    = .:$(SBML_TEX)//:$(TEXINPUTS)
SBML_BIBINPUTS    = .:$(SBML_BIB)/:$(BIBINPUTS)

all: color

# create a colored pdf (default)
color:
	TEXINPUTS=$(SBML_TEXINPUTS) \
	pdflatex "\input{sbml-level-2-version-3}"

# crate a gray scale pdf
gray:
	TEXINPUTS=$(SBML_TEXINPUTS) \
        pdflatex "\newcommand\UseOption{grayscale}\input{sbml-level-2-version-3}"
# create the bibliography
bib:
	BIBINPUTS=$(SBML_BIBINPUTS) \
        bibtex sbml-level-2-version-3

# create html
html:
	TEXINPUTS=$(SBML_TEXINPUTS) \
	/usr/local/tth_exe/tth -L sbml-level-2-version-3.tex

dvi:
	TEXINPUTS=$(SBML_TEXINPUTS) \
	latex "\input{sbml-level-2-version-3}"

ps:	dvi
	TEXINPUTS=$(SBML_TEXINPUTS) \
	dvips -D 600 -o sbml-level-2-version-3.ps sbml-level-2-version-3.dvi
