java_import 'weka.classifiers.lazy.IBk'
java_import 'weka.core.ChebyshevDistance'
java_import 'weka.core.ManhattanDistance'
java_import 'weka.core.EuclideanDistance'
java_import 'weka.core.neighboursearch.KDTree'

class KNearestNeighbor
  include CrossValidation

  def initialize(file, class_name, k = 3)
    @classifier = IBk.new(k)
  end

  def instances
    @instances ||= CSVFile.load(file)
    @instances.class = @instances.enumerate_attributes.detect {|a| a.name == class_name}
  end

  def k=(k)

  end

  def distance_function=(dist_funct)
    kd_tree = KDTree.new

    distance_fun = {
      :euclidean => EuclideanDistance.new,
      :manhattan => ManhattanDistance.new,
      :chebyshev => ChebyshevDistance.new
    }.fetch(dist_funct)

    kd_tree.distance_function = distance_fun

    @classifier.nearest_neighbour_search_algorithm = kd_tree
  end

  def weighting=(weighting_scheme)

  end
end