module CSVFile
  extend self

  def load(csv_path)
    loader = Java::WekaCoreConverters::CSVLoader.new
    loader.source = java.io.File.new(csv_path)
    data = loader.data_set
  end
end