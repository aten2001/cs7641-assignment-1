java_import 'weka.classifiers.functions.LibSVM'
java_import 'weka.core.SelectedTag'

class SVM
  include CrossValidation
  extend Forwardable
  include Enumerable

  def_delegators :@classifier,
    :cost=,
    :degree=

  def initialize(instances)
    @classifier = LibSVM.new
    @classifier.cache_size = 100
    @instances = instances
  end

  def kernel=(kernel)
    @kernel = kernel
    kernel_code = {
      :linear => LibSVM::KERNELTYPE_LINEAR,
      :polynomial => LibSVM::KERNELTYPE_POLYNOMIAL,
      :rbf => LibSVM::KERNELTYPE_RBF,
      :sigmoid => LibSVM::KERNELTYPE_SIGMOID
    }.fetch(kernel)

    tag = SelectedTag.new(kernel_code, LibSVM::TAGS_KERNELTYPE)
    @classifier.kernel_type = tag
  end

  def summary_data
    {:degree => @classifier.degree, :cost => @classifier.cost, :kernel => @kernel}
  end

  def each(&block)
    [:linear, :polynomial, :rbf].each do |kernel|
      -15.step(15, 3).each do |c_exp|
        svm = SVM.new(@instances)
        svm.kernel = kernel
        svm.cost = 2 ** c_exp

        if kernel == :polynomial
          (2..5).each do |degree|
            svm.degree = degree
            yield svm
          end
        else
          yield svm
        end
      end
    end
  end

end