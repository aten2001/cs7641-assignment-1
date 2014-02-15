jruby_path = vendor/jruby-bin-1.7.10.tar.gz
all: charts latex clean zip ;
	echo 'Finished build'
charts:
	mkdir -p assets
	r < ./lib/charts.r --vanilla
	jruby bin/j48_dot.rb
	dot -Tpng ./assets/winequality.dot > ./assets/winequality_tree.png
	dot -Tpng ./assets/agaricus-lepiota.dot  > ./assets/mushroom_tree.png
latex:
	pdflatex mkirk9-analysis.latex
preview: latex ;
	open mkirk9-analysis.pdf
preview_charts: charts ;
	open assets/*.png
clean:
	find . -name mkirk9\* | grep -v latex | grep -v pdf |  xargs rm	
	rm -r assets
setup_jruby:
	./bin/setup_jruby.sh
	source ./bin/jruby_source.sh
zip:	
	tar -czvf ../mkirk9.tar.gz .
