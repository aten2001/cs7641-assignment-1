require 'csv'

# Load information from names file

class MetaData
  attr_reader :meta, :file
  def initialize(file)
    @file = file
    calculate_meta!
  end

  def convert(key, value)

  end

  def calculate_meta!
    @meta = {'class' => {'e' => 'edible', 'p' => 'poisonous'}}
    f = File.read(@file)

    between = f.split(/7\. Attribute Information.*$/).last.split("8. Missing Attribute").first
    ll = nil

    current_attribute = ''

    between.each_line do |l|
      next if l =~ /^\s*$/
      match = l.strip.match(/\d+\.\s+([A-Za-z\-]+)\??:(.*)/)
      if match
        current_attribute = match[1].gsub("-", "_")
        rest = match[2]
      else
        rest = l.strip
      end

      @meta[current_attribute] ||= {}
      rest.split(",").each do |tok|
        parts = tok.strip.split("=")
        @meta[current_attribute][parts.last] = parts.first
      end
    end
  end

  def headers
    headers = %w[class]
    meta.each do |attr,hash|
      next if attr == 'class'
      hash.each do |key, value|
        headers << "#{value}_#{attr}"
      end
    end
    headers
  end

  def transform_row(row)
    row_prime = []
    row_prime << row.fetch('class')

    meta.each do |attribute, values|
      next if attribute == 'class'
      values.each do |key, value|
        row_prime << ((row.fetch(attribute) == key) ? 1 : 0)
      end
    end

    assert row_prime.length == headers.length

    row_prime
  end

  def assert(value)
    if value
    else
      throw 'Does not work'
    end
  end
end
meta = MetaData.new('./agaricus-lepiota.names')

CSV.open("./agaricus-lepiota-svm.csv", "wb") do |csv|
  csv << meta.headers

  CSV.foreach('./agaricus-lepiota.csv', :headers => true) do |row|
    csv << meta.transform_row(row)
  end
end