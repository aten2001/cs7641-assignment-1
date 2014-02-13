java_import 'weka.classifiers.meta.AdaBoostM1'
class AdaBoost
  include CrossValidation

  def initialize(file, class_name)
    @classifier = AdaBoostM1.new
    @instances = CSVFile.load(file)

  end
end