@array = (0..99).to_a
@initialized_array = @array.rotate(50) # Circular array must start on position 50
step_on_0_counter = 0

def reversing?(rotating_position) = rotating_position.eql?('L')

def num_of_zero_crossings_on_cycle(current_position, steps, reversing)
  steps_on_0 = 0

  num_of_crossings, remainder = steps.divmod(@array.size)

  # No partial crossings to check on the remainder
  return 0 if remainder.zero?
  
  if reversing
    segment = @initialized_array.last(remainder) # Gets last #remainder elements from rotated array
    steps_on_0 += 1 if segment.include?(0)
    
  else
    segment = @initialized_array[1..remainder] # Gets 1st to #remainder elements from rotated array
    steps_on_0 += 1 if segment.include?(0)
  end
  
  steps_on_0 += num_of_crossings.abs
  steps_on_0
end

File.readlines('input.txt').each do |line|
  rotation = line.match(/\w/).to_s # Gets any word character as position (L or R)
  steps = line.match(/\d+/).to_s.to_i # Gets the number of steps to move

  current_position = @initialized_array.first
  # Counts every time the dial passes through ZERO
  this_cycle = num_of_zero_crossings_on_cycle(current_position, steps, reversing?(rotation))
  step_on_0_counter += this_cycle

  @initialized_array.rotate!(reversing?(rotation) ? -steps : steps)

  puts "#{current_position} - #{rotation}#{steps} => #{@initialized_array.first} (#{this_cycle})"
end

puts "Dial pointed or crossed at zero #{step_on_0_counter} time(s)"
