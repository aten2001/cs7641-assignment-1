assignment_output = docs/assignment.html
all: latex ;
	echo 'Finished build'
markdown:
	markdown ASSIGNMENT.md > $(assignment_output) 
charts:
	r < ./lib/charts.r --vanilla
latex:
	pdflatex kirkmj-analysis.latex
preview: latex ;
	open kirkmj-analysis.pdf
preview_charts: charts ;
	open assets/*.png
clean:
	rm $(assignment_output) 
	find . -name kirkmj\* | grep -v latex | xargs rm
