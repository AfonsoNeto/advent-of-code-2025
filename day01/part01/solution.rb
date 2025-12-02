array = (0..99).to_a

initialized_array = array.rotate(50) # Circular array must start on position 50

step_on_0_counter = 0

File.readlines('input.txt').each do |line|
  rotating_position = line.match(/\w/).to_s # Gets any word character as position (L or R)
  steps = line.match(/\d+/).to_s.to_i # Gets the number of steps to move

  initialized_array.rotate!(rotating_position.eql?('L') ? -steps : steps)

  # Counts every time the dial points at ZERO
  step_on_0_counter += 1 if initialized_array.first.zero?
end

puts "Dial pointed at zero #{step_on_0_counter} time(s)"
