sum_of_jolts = 0
REQUIRED_BATTERIES_INDEXES = 12

def biggest_combination_index(bank_nums, from_index, required_numbers)
  puts "  Searching for #{required_numbers} batteries from index #{from_index}"
  # Ensures any number picked on this array still has at least the amount of remaining numbers to the right
  leftmost_array = bank_nums.slice(from_index, (bank_nums.size - from_index - required_numbers + 1))
  puts "    - Leftmost array is #{leftmost_array.join('')}"

  biggest_number_on_slice = leftmost_array.max
  # finds indexes of all occurrences of the biggest number in the full array
  all_indexes_of_biggest = bank_nums.each_index.select { bank_nums[_1].eql?(biggest_number_on_slice) }

  # When we have more than one of the biggest number on the overall array,
  #   we only consider a valid one that is within the sliced array, so one with
  #   the index higher than the from_index
  found_valid_index = all_indexes_of_biggest.sort.find { _1 >= from_index }

  puts "    - Found #{biggest_number_on_slice} at index #{found_valid_index}"
  [biggest_number_on_slice, found_valid_index]
end

File.new('input.txt').readlines(chomp: true).each do |line|
  # Transforms the battery bank line in array of integers. Example: 12345 becomes: [1, 2, 3, 4, 5]
  bank_nums = line.to_s.split('').map(&:to_i)
  puts "Checking #{line}"
  found_numbers = []
  from_index = 0

  while found_numbers.size < REQUIRED_BATTERIES_INDEXES
    found_number, found_index = biggest_combination_index(
      bank_nums, from_index, REQUIRED_BATTERIES_INDEXES - found_numbers.size
    )

    found_numbers << found_number
    # Remaining array goes from the found index + 1 to the end of the initial array
    from_index = found_index.next
  end

  puts "  final jolt for line is #{found_numbers.join('').to_i}"
  sum_of_jolts += found_numbers.join('').to_i
end

puts "The total joltage output is #{sum_of_jolts}"