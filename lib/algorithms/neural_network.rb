java_import 'weka.classifiers.functions.MultilayerPerceptron'
class NeuralNetwork
  include CrossValidation

  def initialize(file, class_name)
    @classifier = MultilayerPerceptron.new
    @instances = CSVFile.load(file)
    @instances.class = @instances.enumerate_attributes.detect {|a| a.name == class_name}
  end
end