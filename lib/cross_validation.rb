java_import 'weka.classifiers.Evaluation'
java_import 'weka.classifiers.Classifier'
java_import 'weka.core.Utils'

module CrossValidation
  def cross_validate!
    @folds ||= 10
    evaluation = Evaluation.new(@instances)
    (1..@folds).each do |fold|
      training = @instances.train_cv(@folds, fold - 1)
      testing = @instances.test_cv(@folds, fold - 1)

      classifier_copy = @classifier.dup
      classifier_copy.build_classifier(training)
      puts "Evaluating #{fold}"
      evaluation.evaluate_model(classifier_copy, testing)
    end

    output = <<-EOL
=== Setup ===

Classifier: #{@classifier.class.name} #{Utils.join_options(@classifier.options)}
Dataset: #{@instances.relation_name}
Folds: #{@folds}

#{evaluation.to_summary_string("=== #{@folds}-fold Cross-validation ===", false)}
    EOL
    puts output
  end
end