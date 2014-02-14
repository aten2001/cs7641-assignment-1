require_relative '../config/bootstrap'

mushrooms = './data/agaricus-lepiota/agaricus-lepiota.csv'
wine = './data/wine_data/winequality.csv'

class Analysis
  if ARGV.first.nil?
    ALGORITHMS = [KNearestNeighbor, SVM, J48Tree, AdaBoost, NeuralNetwork]
  else
    ALGORITHMS = [Kernel.const_get(ARGV.first)]
  end

  def initialize(file_hash, algorithm = nil)
    @files = file_hash.keys
    @instances = file_hash.map do |file, class_name|
      instances = CSVFile.load(file)
      instances.class = instances.enumerate_attributes.detect {|a| a.name == class_name}
      instances
    end
  end

  def run_all!
    ALGORITHMS.each do |algo|
      @instances.each do |instance|
        puts "Running Analysis for #{instance.relation_name} #{algo}"
        run_algorithm!(algo, instance)
      end
    end
  end

  def run_algorithm!(klass, instances)
    algorithm = klass.new(instances)
    cv = algorithm.map do |configured_algo|
      configured_algo.cross_validation
    end

    File.open("./data/cross_validation/#{instances.relation_name}-#{klass.name.downcase}.yml", "wb") do |f|
      f.write(YAML::dump(cv))
    end
  end
end

analysis = Analysis.new({
  './data/wine_data/winequality.csv' => 'above_average'
})

analysis.run_all!
