java_import 'weka.classifiers.trees.J48'
require 'forwardable'

class J48Tree
  include CrossValidation
  extend Forwardable
  include Enumerable

  def_delegators :@classifier,
    :confidence_factor=,
    :binary_splits=,
    :min_num_obj=,
    :reduced_error_pruning=,
    :confidence_factor=

  def initialize(instances)
    @instances = instances
    @classifier = J48.new
  end

  def summary_data
    Hash[%w[confidence_factor use_laplace reduced_error_pruning min_num_obj binary_splits].map do |attribute|
      [attribute, @classifier.send(attribute)]
    end]
  end

  # Grid Search of best tree
  # 32 Different parameters
  def each(&block)
    0.05.step(0.45, 0.1).each do |confidence_factor|
      [true, false].each do |use_laplace|
        [true, false].each do |reduced_error_pruning|
          (2..5).each do |min_num_obj|
            [true, false].each do |binary_split|
              tree = J48Tree.new(@instances)
              tree.confidence_factor = confidence_factor
              tree.binary_splits = binary_split
              tree.min_num_obj = min_num_obj
              tree.reduced_error_pruning = reduced_error_pruning
              tree.confidence_factor = confidence_factor

              yield tree
            end
          end
        end
      end
    end
  end
end