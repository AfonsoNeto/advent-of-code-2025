full_file_content = File.read('input.txt')

fresh_igredients_id_ranges, available_igredients_ids = full_file_content.split("\n\n")

fresh_igredients_id_ranges = fresh_igredients_id_ranges.split("\n").map { |line| line.split('-').map(&:to_i) }
fresh_igredients_id_ranges = fresh_igredients_id_ranges.map { (_1.first.._1.last) }

available_igredients_ids = available_igredients_ids.split("\n").map(&:to_i)

total_fresh_available_igredients_ids = available_igredients_ids.count do |id|
  fresh_igredients_id_ranges.any? do |range|
    if range.include?(id)
      puts "#{id} is fresh as it falls into #{range.to_s}"
      true
    end
  end
end

puts "The number of fresh available igredients is #{total_fresh_available_igredients_ids}"