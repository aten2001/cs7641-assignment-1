java_import 'weka.classifiers.functions.MultilayerPerceptron'
class NeuralNetwork
  include CrossValidation
  extend Forwardable
  include Enumerable

  def_delegators :@classifier,
    :training_time=

  def initialize(instances)
    @classifier = MultilayerPerceptron.new
    @folds = 5
    @instances = instances
  end

  def summary_data
    {
      :training_time => @classifier.training_time
    }
  end

  def each(&block)
    100.step(500, 100).each do |training_time|
      ann = NeuralNetwork.new(@instances)
      ann.training_time = training_time

      yield ann
    end
  end
end