java_import 'weka.classifiers.functions.LibSVM'
java_import 'weka.core.SelectedTag'

class SVM
  include CrossValidation
  attr_reader :kernel

  def initialize(file, class_name)
    @classifier = LibSVM.new
    @classifier.cache_size = 100
    @instances = CSVFile.load(file)
    @instances.class = @instances.enumerate_attributes.detect {|a| a.name == class_name}
  end

  def heuristics=(off_or_on)
    @classifier.shrinking = off_or_on
  end

  def kernel=(kernel)
    kernel_code = {
      :linear => LibSVM::KERNELTYPE_LINEAR,
      :polynomial => LibSVM::KERNELTYPE_POLYNOMIAL,
      :rbf => LibSVM::KERNELTYPE_RBF,
      :sigmoid => LibSVM::KERNELTYPE_SIGMOID
    }.fetch(kernel)

    tag = SelectedTag.new(kernel_code, LibSVM::TAGS_KERNELTYPE)
    @classifier.kernel_type = tag
  end
end