java_import 'weka.classifiers.lazy.IBk'
class KNearestNeighbor
  include CrossValidation

  def initialize(file, class_name, k = 3)
    @classifier = IBk.new(k)
    @instances = CSVFile.load(file)
    @instances.class = @instances.enumerate_attributes.detect {|a| a.name == class_name}
    @folds = 10
  end
end