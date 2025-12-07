sum_of_jolts = 0

def find_biggest_pair(bank_nums)
  biggest_pair = bank_nums.max(2)
  current_biggest_combination = biggest_pair

  puts "#{bank_nums.join('')} => #{biggest_pair}"

  # If the first highest num appears later on the array, we need to return it in the right expected order
  if (bank_nums.index(biggest_pair.first) > bank_nums.index(biggest_pair.last))
    puts "  - reverting #{biggest_pair.reverse}"
    current_biggest_combination = biggest_pair.reverse
  end

  maximum_element = biggest_pair.max
  maximum_element_index = bank_nums.index(maximum_element)

  bank_nums.each.with_index do |num, index|
    # Skips checking a combination of the biggest number with itself
    next if index.eql?(maximum_element_index)

    pair_to_compare = [num, maximum_element]
    # if num's index > maximum_element_index we need comparison array to be [maximum, num] instead of [num, maximum]
    pair_to_compare = pair_to_compare.reverse if (index > maximum_element_index)

    num_to_compare = pair_to_compare.join('').to_i

    if num_to_compare > current_biggest_combination.join('').to_i
      puts "  - found a bigger combination: #{num_to_compare}"
      current_biggest_combination = pair_to_compare
    end
  end

  current_biggest_combination
end

File.new('input.txt').readlines(chomp: true).each do |line|
  # Transforms the battery bank line in array of integers. Example: 12345 becomes: [1, 2, 3, 4, 5]
  bank_nums = line.to_s.split('').map(&:to_i)

  biggest_pair = find_biggest_pair(bank_nums)
  sum_of_jolts += biggest_pair.join('').to_i
end

puts "The total joltage output is #{sum_of_jolts}"