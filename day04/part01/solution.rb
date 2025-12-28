PAPER_ROLL_SYMBOL = '@'
MAX_NUM_OF_ADJACENT_PAPER_ROLLS_FOR_ACCESSIBILITY = 4

num_of_accessible_paper_rolls = 0

full_file_content = File.read('input.txt')
@full_file_matrix = full_file_content.split("\n").map { |line| line.split('') }
@final_replaced_matrix = @full_file_matrix.map(&:dup) # avoiding shallow dup by dupping inner contents

def less_than_max_adjacent_rolls?(row_index, column_index)
  (
    num_of_rolls_on_top_left(row_index, column_index) +
    num_of_rolls_on_top_right(row_index, column_index) +
    num_of_rolls_on_bottom_left(row_index, column_index) +
    num_of_rolls_on_bottom_right(row_index, column_index) +
    num_of_rolls_on_left(row_index, column_index) +
    num_of_rolls_on_right(row_index, column_index) +
    num_of_rolls_on_top(row_index, column_index) +
    num_of_rolls_on_bottom(row_index, column_index)
  ) < MAX_NUM_OF_ADJACENT_PAPER_ROLLS_FOR_ACCESSIBILITY
end

def num_of_rolls_on_top_left(row_index, column_index)
  return 0 if row_index.zero? || column_index.zero?

  return 1 if @full_file_matrix[row_index - 1][column_index - 1].eql?(PAPER_ROLL_SYMBOL)

  return 0
end

def num_of_rolls_on_top_right(row_index, column_index)
  return 0 if row_index.zero? || column_index.eql?(@full_file_matrix[row_index].size - 1)

  return 1 if @full_file_matrix[row_index - 1][column_index + 1].eql?(PAPER_ROLL_SYMBOL)

  return 0
end

def num_of_rolls_on_bottom_left(row_index, column_index)
  return 0 if row_index.eql?(@full_file_matrix.size - 1) || column_index.zero?

  return 1 if @full_file_matrix[row_index + 1][column_index - 1].eql?(PAPER_ROLL_SYMBOL)

  return 0
end

def num_of_rolls_on_bottom_right(row_index, column_index)
  return 0 if row_index.eql?(@full_file_matrix.size - 1) || column_index.eql?(@full_file_matrix[row_index].size - 1)

  return 1 if @full_file_matrix[row_index + 1][column_index + 1].eql?(PAPER_ROLL_SYMBOL)

  return 0
end

def num_of_rolls_on_top(row_index, column_index)
  return 0 if row_index.zero?

  return 1 if @full_file_matrix[row_index - 1][column_index].eql?(PAPER_ROLL_SYMBOL)

  return 0
end

def num_of_rolls_on_bottom(row_index, column_index)
  return 0 if row_index.eql?(@full_file_matrix.size - 1)

  return 1 if @full_file_matrix[row_index + 1][column_index].eql?(PAPER_ROLL_SYMBOL)

  return 0
end

def num_of_rolls_on_left(row_index, column_index)
  return 0 if column_index.zero?

  return 1 if @full_file_matrix[row_index][column_index - 1].eql?(PAPER_ROLL_SYMBOL)

  return 0
end

def num_of_rolls_on_right(row_index, column_index)
  return 0 if column_index.eql?(@full_file_matrix[row_index].size - 1)

  return 1 if @full_file_matrix[row_index][column_index + 1].eql?(PAPER_ROLL_SYMBOL)

  return 0
end

@full_file_matrix.each_with_index do |row, row_index|
  row.each_with_index do |symbol, column_index|
    if symbol.eql?(PAPER_ROLL_SYMBOL)
      if less_than_max_adjacent_rolls?(row_index, column_index)
        num_of_accessible_paper_rolls += 1
        @final_replaced_matrix[row_index][column_index] = 'X'
      end
    end
  end
end


# puts @final_replaced_matrix.map(&:join).join("\n")
puts "The number of accessible paper rolls is #{num_of_accessible_paper_rolls}"