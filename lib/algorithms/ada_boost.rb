java_import 'weka.classifiers.meta.AdaBoostM1'
class AdaBoost
  include CrossValidation
  extend Forwardable
  include Enumerable

  def_delegators :@classifier,
    :num_iterations=,
    :use_resampling=,
    :weight_threshold=

  def initialize(instances)
    @classifier = AdaBoostM1.new
    @instances = CSVFile.load(file)
  end

  def each(&block)
    90.step(100, 2).to_a.reverse.each do |weight_mass_percentage|
      [true, false].each do |resampling|
        [10, 100, 1000, 10000].each do |iterations|
          adaboost = AdaBoost.new(@instances)
          adaboost.num_iterations = iterations
          adaboost.use_resampling = resampling
          adaboost.weight_threshold = weight_mass_percentage

          yield adaboost
        end
      end
    end
  end
end