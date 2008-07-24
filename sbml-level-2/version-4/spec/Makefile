##
## @file    Makefile
## @brief   Makefile for SBML Level 2 specification documents
## @author  Stefan Hoops
## @author  Michael Hucka
## 
## $Id$
## $HeadURL$
##
##<!---------------------------------------------------------------------------
## This file is part of the SBML project.  Please visit http://sbml.org for 
## more information about SBML and the latest version of the specification.
##----------------------------------------------------------------------- -->*/

SBML_PROJECT=../../../../project

SBML_TEX=$(SBML_PROJECT)/tex
SBML_BIB=$(SBML_PROJECT)/bib

SBML_TEXINPUTS    = .:$(SBML_TEX)//:$(TEXINPUTS)
SBML_BIBINPUTS    = .:$(SBML_BIB)/:$(BIBINPUTS)

MAIN_FILE = sbml-level-2-version-4
MATHML_SCHEMA = ../../../sbml-mathml/sbml-mathml.xsd

default: pdf

# create a colored pdf (default)
pdf color: mathml.xsd
	TEXINPUTS=$(SBML_TEXINPUTS) pdflatex "\input{$(MAIN_FILE)}"
	make bib
	TEXINPUTS=$(SBML_TEXINPUTS) pdflatex "\input{$(MAIN_FILE)}"
	TEXINPUTS=$(SBML_TEXINPUTS) pdflatex "\input{$(MAIN_FILE)}"
	TEXINPUTS=$(SBML_TEXINPUTS) pdflatex "\input{$(MAIN_FILE)}"

# crate a gray scale pdf
gray: mathml.xsd
	TEXINPUTS=$(SBML_TEXINPUTS) \
        pdflatex "\newcommand\UseOption{grayscale}\input{$(MAIN_FILE)}"
# create the bibliography
bib:
	BIBINPUTS=$(SBML_BIBINPUTS) \
        bibtex $(MAIN_FILE)

# create html
html: mathml.xsd
	TEXINPUTS=$(SBML_TEXINPUTS) \
	/usr/local/tth_exe/tth -L $(MAIN_FILE).tex

dvi: mathml.xsd
	TEXINPUTS=$(SBML_TEXINPUTS) \
	latex "\input{$(MAIN_FILE)}"

ps:	dvi
	TEXINPUTS=$(SBML_TEXINPUTS) \
	dvips -D 600 -o $(MAIN_FILE).ps $(MAIN_FILE).dvi

# Stupid \input{...} in LaTeX can't handle dashes in file names!
# Argh!  So we have to do this bletcherous hack.

mathml.xsd: $(MATHML_SCHEMA)
	ln -s $(MATHML_SCHEMA) mathml.xsd
