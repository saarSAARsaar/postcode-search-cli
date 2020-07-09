require 'csv'
require 'byebug'

data_path = "Downloads/plz_verzeichnis_v2.csv"

postcodes = CSV.parse(File.read(data_path), headers: true, col_sep: ";")
puts "Number of rows: " + postcodes.length.to_s
puts ''

running = true
while running
    puts "Enter a postcode or a name of city/town"
    col_val_to_find = gets.chomp
    if !/\A\d+\z/.match(col_val_to_find)
        puts "Checking for the postcode of that place..."
        col_to_check = "ortbez18"
        col_to_return = "postleitzahl"
    else
        puts "Checking for the canton of that postcode..."
        col_to_check = "postleitzahl"
        col_to_return = "kanton"
    end  
    return_vals = []

    rows = postcodes.find_all { |row| row[col_to_check] == col_val_to_find }
    return_vals = rows.map { |row| row[col_to_return] }

    puts ''
    if return_vals.length == 0
        # puts "The postcode #{postcode} was not found"
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