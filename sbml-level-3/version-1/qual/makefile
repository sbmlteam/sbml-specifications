BASE=SBML-L3-qual-specification_0.1

$(BASE).pdf: $(BASE).tex UML_diagram_qual.pdf
	pdflatex $(BASE).tex 
	pdflatex $(BASE).tex 

UML_diagram_qual.pdf: UML_diagram_qual.svg
	convert UML_diagram_qual.svg UML_diagram_qual.pdf

.PHONY: clean
clean:
	rm $(BASE).pdf $(BASE).out $(BASE).log $(BASE).aux UML_diagram_qual.pdf
