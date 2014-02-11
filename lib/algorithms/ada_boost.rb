java_import 'weka.classifiers.meta.AdaBoostM1'
class AdaBoost
  include CrossValidation

  def initialize(file, class_name)
    @classifier = AdaBoostM1.new
    @instances = CSVFile.load(file)
    @instances.class = @instances.enumerate_attributes.detect {|a| a.name == class_name}
  end
end