java_import 'weka.classifiers.trees.J48'

class J48Tree
  include CrossValidation

  def initialize(file, class_name)
    @instances = CSVFile.load(file)
    @instances.class = @instances.enumerate_attributes.detect {|a| a.name == class_name}
    @classifier = J48.new
  end
end