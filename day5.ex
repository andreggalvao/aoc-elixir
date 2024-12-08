def matrix_base() do
  input = File.read!("data.txt")
  |> String.trim()
  |> String.split("\n")
  |> Enum.with_index()
  |> Enum.flat_map(fn {line, row_index} ->
    line
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.map(fn {char, col_index} ->
      {{row_index, col_index}, char}
    end)
  end)
  |> IO.inspect()
end

# input vai ser [{{x , y} char}, {{x , y} char}, ...]

# position_4_5 = Enum.find(input, fn {{row, col}, _char} -> row == 4 and col == 5 end)
# position_of_caret = Enum.find(input, fn {_pos, char} -> char == "^" end)
def initial position
