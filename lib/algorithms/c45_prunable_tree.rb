java_import 'weka.classifiers.trees.j48.C45PruneableClassifierTree'
java_import 'weka.classifiers.trees.j48.C45ModelSelection'

class C45PruneableTree
  include CrossValidation

  def initialize(file, class_name)
    @instances = CSVFile.load(file)
    @instances.class = @instances.enumerate_attributes.detect {|a| a.name == class_name}
    @model_selection = C45ModelSelection.new(3, @instances)
    @classifier = C45PruneableClassifierTree.new(@model_selection, true, 0.1, true, true)
    @folds = 10
  end
end