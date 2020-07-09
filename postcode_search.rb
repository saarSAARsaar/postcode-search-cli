require 'csv'

row_count = 0
CSV.parse(File.read("Downloads/plz_verzeichnis_v2.csv"), headers: true, col_sep: ";") do |row|
    row_count += 1
end
puts row_count