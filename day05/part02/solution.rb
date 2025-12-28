full_file_content = File.read('input.txt')
merged_ranges = []

fresh_igredients_id_ranges, _ = full_file_content.split("\n\n")

fresh_igredients_id_ranges = fresh_igredients_id_ranges.split("\n").map { |line| line.split('-').map(&:to_i) }
fresh_igredients_id_ranges = fresh_igredients_id_ranges.map { (_1.first.._1.last) }
fresh_igredients_id_ranges.sort_by! { [_1.begin, _1.end] }

merged_ranges = fresh_igredients_id_ranges.each_with_object([]) do |next_range, merged|
  if merged.empty?
    merged << next_range
    next
  end

  current_range = merged.last

  if current_range.overlap?(next_range)
    new_end = [current_range.end, next_range.end].max
    merged[-1] = (current_range.begin..new_end)
    puts "  [OVERLAP] Merged #{current_range} with #{next_range} to #{merged.last}"
  else
    merged << next_range
    puts "  [NO OVERLAP] #{current_range} with #{next_range}. Added #{current_range}"
  end

  # puts "  Merged ranges: #{merged.inspect}"
end

total_fresh_igredients_ids = merged_ranges.sum(&:size)

puts "The number of fresh available igredients is #{total_fresh_igredients_ids}"