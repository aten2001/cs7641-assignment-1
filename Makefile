assignment_output = docs/assignment.html
jruby_path = vendor/jruby-bin-1.7.10.tar.gz
all: latex ;
	echo 'Finished build'
markdown:
	markdown ASSIGNMENT.md > $(assignment_output) 
charts:
	r < ./lib/charts.r --vanilla
latex:
	pdflatex mkirk9-analysis.latex
preview: latex ;
	open mkirk9-analysis.pdf
preview_charts: charts ;
	open assets/*.png
clean:
	rm $(assignment_output) 
	find . -name mkirk9\* | grep -v latex | xargs rm
setup_jruby:
	./bin/setup_jruby.sh
	source ./bin/jruby_source.sh
