require 'csv'
require 'byebug'

data_path = "Downloads/plz_verzeichnis_v2.csv"

class Place
    attr_reader :name, :postcode, :canton

    def initialize(postcode, name, canton)
        @postcode = postcode
        @name = name
        @canton = canton
    end 
end

rows = CSV.parse(File.read(data_path), headers: true, col_sep: ";")
places = rows.map do |row|
    Place.new(row["postleitzahl"], row["ortbez18"], row["kanton"])
end

puts "Number of rows: " + places.length.to_s
puts ''

running = true
while running
    puts "Enter a postcode or a name of city/town"
    col_val_to_find = gets.chomp
    
    if /\A\d+\z/.match(col_val_to_find) 
        wanted_places = places.find_all { |place| place.postcode == col_val_to_find }
        return_vals = wanted_places.map { |place| place.canton }
    else
        wanted_places = places.find_all { |place| place.name == col_val_to_find }
        return_vals = wanted_places.map { |place| place.postcode }
    end  

    puts ''
    if return_vals.length == 0
        puts "No values were found for #{col_val_to_find}"
    else
        puts return_vals.uniq
    end

    puts "\nDo you want to end the program? Type exit if so"
    should_end = gets.chomp
    if should_end.downcase == 'exit'
        running = false
    end
    puts ''
end