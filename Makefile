assignment_output = docs/assignment.html
markdown:
	markdown ASSIGNMENT.md > $(assignment_output) 
charts:
	r < ./lib/charts.r --vanilla
latex: charts ;
	pdflatex kirkmj-analysis.latex
preview: latex ;
	open kirkmj-analysis.pdf
clean:
	rm $(assignment_output) 
