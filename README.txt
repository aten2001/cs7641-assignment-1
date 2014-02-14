To be able to run this code you will need JRuby which is easily downloaded via

http://www.jruby.org/download

I have also contained it as a zip file under /vendor. The easiest way to install jruby for this tool is to run ./bin/setup_jruby.sh which will extract and load the jruby script into the $PATH.

On top of JRuby I have attached all of the R code that created the graphics and a Makefile that helps make different things.

Each of the algorithms I have split up into classes (J48Tree, SVM, AdaBoost, NeuralNetwork, KNearestNeighbor). These are all Ruby classes and all use the same API (for the most part).

For instance if you would like to build a classifier using the J48Tree

```ruby
instances = CSVFile.load('./data/wine_data/wine_data.csv', 'above_average')
j48 = J48Tree.new(instances)
j48.build!
```

On top of that I included in a module called CrossValidation that will run by default a 10 fold cross validation and return a hash. When I ran the analysis I used bin/build.rb to run all of them or singly you can do jruby bin/build.rb AdaBoost or whatever class you want to run. The only exception is NeuralNetworks which uses a 5-fold cross validation.

J48Tree has the added method of save_graph! which will save the .dot file created from the tree.

To do the graphing I used R since it's the easiest to use and to make all of the charts just run make charts.
