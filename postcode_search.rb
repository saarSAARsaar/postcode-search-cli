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
    puts "Enter a postcode"
    postcode = gets.chomp
    cantons = []

    CSV.parse(File.read(data_path), headers: true, col_sep: ";") do |row|
        row_count += 1
        if row["postleitzahl"] == postcode
            cantons.append(row["kanton"])
        end
    end

    puts ''
    if cantons.length == 0
        puts "The postcode #{postcode} was not found"
    else
        filtered_cantons = []
        cantons.each do |canton|
            if !filtered_cantons.include? canton
                filtered_cantons.append(canton)
            end
        end
        puts filtered_cantons
    end

    puts "\nDo you want to end the program? Type exit if so"
    should_end = gets.chomp
    if should_end.downcase == 'exit'
        running = false
    end
    puts ''
end