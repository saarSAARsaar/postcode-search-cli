require 'csv'
require 'byebug'

puts "Enter a postcode"
postcode = gets.chomp
cantons = []
row_count = 0
CSV.parse(File.read("Downloads/plz_verzeichnis_v2.csv"), headers: true, col_sep: ";") do |row|
    row_count += 1
    if row["postleitzahl"] == postcode
        cantons.append(row["kanton"])
    end
end
if cantons.length == 0
    puts "The postcode #{postcode} was not found"
else
    # filtered_cantons = []
    # cantons.each do |canton|
    #    if !filtered_cantons.include? canton
    #        filtered_cantons.append(canton)
    #    end
    # end
    puts cantons.uniq
end
puts row_count