file_content = File.read('input.txt')
invalid_ids = []

def invalid_id?(id)
  individual_characters = id.to_s.split('')

  # Single characters like 1, 2, 3 are not invalid IDs
  return false if individual_characters.size <= 1

  # If by removing the duplicate characters (.uniq) we get just one char, than it is an invlida ID
  if individual_characters.uniq.size.eql?(1)
    puts "invalid: #{id} [all same chars]"
    return true
  end

  # Split the id equally from start to the half of it and from the half of it to the end
  first_part = id.to_s.slice(...(id.to_s.size / 2))
  second_part = id.to_s.slice((id.to_s.size/2)..)

  # If both splits are equal, than we have an invalid ID
  if first_part.eql?(second_part)
    puts "invalid: #{id} [eql splits]"
    return true
  end

  if id.to_s.match?(/^(\d+)\1+$/)
    puts "invalid: #{id} [regex]"
    return true
  end

  false
end

file_content.split(',').each do |range_text|
  range = range_text.split('-')
  range_array = (range.first.to_i..range.last.to_i).to_a

  invalid_ids << range_array.select { invalid_id?(_1) }
end

puts "The sum of all invalid IDs is: #{invalid_ids.flatten.sum}"