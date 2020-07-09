require 'csv'

puts "Enter a postcode"
input = gets.chomp
row_count = 0
CSV.parse(File.read("Downloads/plz_verzeichnis_v2.csv"), headers: true, col_sep: ";") do |row|
    row_count += 1
    if row["postleitzahl"] == input
        puts row["kanton"] + ", " + row["ortbez18"]
    end
end
puts row_count