##
## @file    Makefile
## @brief   Makefile for SBML Level 2 specification documents
## @author  Stefan Hoops
## @author  Michael Hucka
## 
## $Id: Makefile 9599 2009-06-09 17:10:36Z mhucka $
## $HeadURL: https://sbml.svn.sf.net/svnroot/sbml/trunk/specifications/sbml-level-3/version-1/core/spec/Makefile $
##
##<!---------------------------------------------------------------------------
## This file is part of the SBML project.  Please visit http://sbml.org for 
## more information about SBML and the latest version of the specification.
##----------------------------------------------------------------------- -->*/

SBML_PROJECT=../

SBML_TEX=$(SBML_PROJECT)/tex
SBML_BIB=$(SBML_PROJECT)/bib

SBML_TEXINPUTS    = .:$(SBML_TEX)//:$(TEXINPUTS)
SBML_BIBINPUTS    = .:$(SBML_BIB)/:$(BIBINPUTS)

MAIN_FILE = main
MATHML_SCHEMA = ../mathml-schema/sbml-mathml.xsd

default: pdf

# create a colored pdf (default)
pdf color: 
	TEXINPUTS=$(SBML_TEXINPUTS) pdflatex "\input{$(MAIN_FILE)}"
	make bib
	TEXINPUTS=$(SBML_TEXINPUTS) pdflatex "\input{$(MAIN_FILE)}"
	TEXINPUTS=$(SBML_TEXINPUTS) pdflatex "\input{$(MAIN_FILE)}"
	TEXINPUTS=$(SBML_TEXINPUTS) pdflatex "\input{$(MAIN_FILE)}"

# crate a gray scale pdf
gray: 
	TEXINPUTS=$(SBML_TEXINPUTS) \
        pdflatex "\newcommand\UseOption{grayscale}\input{$(MAIN_FILE)}"
# create the bibliography
bib:
	BIBINPUTS=$(SBML_BIBINPUTS) \
        bibtex $(MAIN_FILE)

# create html
html: 
	TEXINPUTS=$(SBML_TEXINPUTS) \
	/usr/local/tth_exe/tth -L $(MAIN_FILE).tex

dvi: 
	TEXINPUTS=$(SBML_TEXINPUTS) \
	latex "\input{$(MAIN_FILE)}"

ps:	dvi
	TEXINPUTS=$(SBML_TEXINPUTS) \
	dvips -D 600 -o $(MAIN_FILE).ps $(MAIN_FILE).dvi

# Stupid \input{...} in LaTeX can't handle dashes in file names!
# Argh!  So we have to do this bletcherous hack.


clean:
	-rm -f mathml.xsd *.aux *.bbl *.blg *.log *.out *.toc
