# File name   : Makefile
# Description : Makefile for notation document
# Author(s)   : Michael Hucka <mhucka@cds.caltech.edu>
# Organization: CDS, Caltech
# Language    : Make
# Created     : 2001-01-03
# Revision    : $Id$
# $Source: /Users/mhucka/projects/sysbio/sbml/current-cvs/specifications/notation/version-1/Makefile,v $

BASENAME = notation

default: dvi

dvi:;
	-@/bin/rm -f $(BASENAME).toc $(BASENAME).aux
	latex $(BASENAME).tex
	latex $(BASENAME).tex
	latex $(BASENAME).tex

pdf:;
	make eps
	-@/bin/rm -f $(BASENAME).toc $(BASENAME).aux
	pdflatex $(BASENAME).tex
	pdflatex $(BASENAME).tex
	pdflatex $(BASENAME).tex

eps:;
	@(for i in *.eps; do echo "epstopdf $$i"; epstopdf $$i; done)

html: $(BASENAME).tex
	latex2html -white -split +0 -show_section_numbers -image_type gif \
		   -no_navigation -local_icons -discard \
		   -mkdir -dir html $(BASENAME)
