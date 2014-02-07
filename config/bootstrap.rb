require 'java'

require_relative '../vendor/libsvm-3.17/java/libsvm.jar'
require_relative '../vendor/weka-3-6-10/weka.jar'

Dir['./lib/**/*.rb'].each {|r| require r }
