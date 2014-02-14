require 'csv'

CSV.open("winequality.csv", 'wb') do |out|
  headers = nil
  CSV.foreach("winequality-red.csv", :headers => true) do |csv|
    if headers.nil?
      headers = %w[red].concat(csv.headers)
      headers[-1] = 'above_average'
      out << headers
    end

    row = %w[t].concat(csv.to_hash.values)
    row[-1] = (row[-1].to_i > 5 ? 't' : 'f')
    out << row
  end

  CSV.foreach("winequality-white.csv", :headers => true) do |csv|
    row = %w[f].concat(csv.to_hash.values)
    row[-1] = (row[-1].to_i > 5 ? 't' : 'f')
    out << row
  end
end