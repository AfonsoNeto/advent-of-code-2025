full_matrix = []

File.readlines('input.txt').each_with_index do |line, index|
  all_chars_on_line = line.split(/\s+/).reject(&:empty?)
  full_matrix << all_chars_on_line
end

grand_total = full_matrix.transpose.sum do |row|
  operator = row.pop
  puts "row: #{row}"
  puts "    operator: #{operator}"
  result = row.map(&:to_i).reduce(&operator.to_sym)

  puts "    result: #{result}"
  result
end

puts "The grand total is #{grand_total}"