require 'csv'
require 'byebug'

data_path = "Downloads/plz_verzeichnis_v2.csv"

row_count = 0
CSV.parse(File.read(data_path), headers: true, col_sep: ";") do |row|
    row_count += 1
end
puts "Number of rows: " + row_count.to_s 
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

    CSV.parse(File.read(data_path), headers: true, col_sep: ";") do |row|
        row_count += 1
        if row[col_to_check] == col_val_to_find
            return_vals.append(row[col_to_return])
        end
    end

    puts ''
    if return_vals.length == 0
        # puts "The postcode #{postcode} was not found"
        puts "No values were found for #{col_val_to_find}"
    else
        filtered_return_vals = []
        return_vals.each do |val|
            if !filtered_return_vals.include? val
                filtered_return_vals.append(val)
            end
        end
        puts filtered_return_vals
    end

    puts "\nDo you want to end the program? Type exit if so"
    should_end = gets.chomp
    if should_end.downcase == 'exit'
        running = false
    end
    puts ''
end