# File name   : Makefile
# Description : Makefile for sbml document
# Author(s)   : Michael Hucka <mhucka@cds.caltech.edu>
# Organization: CDS, Caltech
# Language    : Make
# Created     : 2000-10-17
# Revision    : $Revision$
# $Id$

BASENAME = sbml-level-1

default: dvi

dvi:;
	-@/bin/rm -f $(BASENAME).toc $(BASENAME).aux
	latex $(BASENAME).tex
	bibtex $(BASENAME)
	latex $(BASENAME).tex
	latex $(BASENAME).tex
	latex $(BASENAME).tex

ps: dvi
	dvips -o $(BASENAME).ps $(BASENAME)

pdf:;
	make eps
	-@/bin/rm -f $(BASENAME).toc $(BASENAME).aux
	pdflatex $(BASENAME).tex
	bibtex $(BASENAME)
	pdflatex $(BASENAME).tex
	pdflatex $(BASENAME).tex
	pdflatex $(BASENAME).tex
	pdflatex $(BASENAME).tex

eps:;
	@(for i in *.eps; do echo "converting $$i to PDF"; epstopdf $$i; done)

html:;
	latex2html -white -split +0 -show_section_numbers -image_type gif \
		   -no_navigation -local_icons -discard \
		   -mkdir -dir html $(BASENAME)
