# File name   : Makefile
# Description : Makefile for SBML FAQ document
# Author(s)   : Michael Hucka <mhucka@cds.caltech.edu>
# Organization: CDS, Caltech
# Language    : Make
# Created     : 2003-07-27
# Revision    : $Id$
# $Source$

BASENAME    = sbml-faq

HTML_DIR    = html
HTML_EXTRAS = sbml-faq-green-dot.gif

.PHONY: html

default: dvi

dvi:;
	-@/bin/rm -f $(BASENAME).toc $(BASENAME).aux
	latex $(BASENAME).tex
#	bibtex $(BASENAME)
#	latex $(BASENAME).tex
	latex $(BASENAME).tex
	latex $(BASENAME).tex

ps: dvi
	dvips -o $(BASENAME).ps $(BASENAME)

pdf:;
#	make eps
	-@/bin/rm -f $(BASENAME).toc $(BASENAME).aux
	pdflatex $(BASENAME).tex
#	bibtex $(BASENAME)
#	pdflatex $(BASENAME).tex
#	pdflatex $(BASENAME).tex
	pdflatex $(BASENAME).tex
	pdflatex $(BASENAME).tex

eps:;
	@(for i in *.eps; do echo "epstopdf $$i"; epstopdf $$i; done)

sbmlfaq.perl:
	ln -s ../../project/tex/sbmlfaq.perl

# The perl line below replaces the title of the web page produced by 
# latex2html.  I don't know why the -t flag to latex2html doesn't seem
# to have an effect, so this is a hack to get around the problem.

html: sbmlfaq.perl
	/bin/rm -rf $(HTML_DIR)
	/bin/mkdir $(HTML_DIR)
	/bin/cp $(HTML_EXTRAS) $(HTML_DIR)
	latex2html -white -split +0 -show_section_numbers -image_type gif \
		   -no_navigation -local_icons -discard -antialias \
		   -short_extn -discard \
		   -t "SBML Frequently Asked Questions" \
		   -mkdir -dir "html" -prefix "sbml-faq-" $(BASENAME)
	perl -pi -e 's/<TITLE>Contents<\/TITLE>/<TITLE>SBML Frequently Asked Questions<\/TITLE>/' $(HTML_DIR)/$(BASENAME).htm
