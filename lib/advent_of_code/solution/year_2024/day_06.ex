defmodule AdventOfCode.Solution.Year2024.Day06 do
  def part1(input) do
    {time, result} = :timer.tc(fn ->
      matrix = generate_matrix(input)
      inicial_position = current_position(matrix)
      move(inicial_position, matrix)
    end)

    IO.puts("Execution time: #{time / 1_000_000} seconds")
    result
  end

  def generate_matrix(input) do
    input
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

  end

  def current_position(matrix) do
    matrix
    |> Enum.find_value(fn {{x,y}, "^"} ->
      {{x,y}, "^"}
      _ -> nil #em uma fn, precisa ter clause que cubra todos os casos possívels
    end)
  end

  def move({{x, y}, direction}, matrix) do
    IO.inspect({{x, y}, direction})
    updated_matrix = update_matrix(matrix, x, y)

     case what_is_in_front({{x, y},  direction}, updated_matrix) do
      {:continue, {{row, col}, "."}} -> move({{row, col}, direction}, updated_matrix)
      {:continue, {{row, col}, "X"}} -> move({{row, col}, direction}, updated_matrix)

      {:turn, {{_row, _col}, "#"}} ->
        new_direction = change_direction(direction)
        move({{x, y}, new_direction}, updated_matrix)
      {:error, _txt} ->  count_x = Enum.count(updated_matrix, fn {{_row, _col}, char} -> char == "X" end)
      IO.inspect("Number of X's in the matrix: #{count_x}")
     end
  end

  def what_is_in_front({{x, y}, direction}, matrix) do
    case direction do
      "^" -> find_in_matrix(matrix, x - 1, y)
      ">" -> find_in_matrix(matrix, x, y + 1)
      "v" -> find_in_matrix(matrix, x + 1, y)
      "<" -> find_in_matrix(matrix, x, y - 1)
    end
  end

  def find_in_matrix(matrix, row, col) do
    case Enum.find(matrix, fn {{r, c}, _char} -> r == row and c == col end) do
      nil -> {:error, "No element found in the specified direction"}
      {{_r, _c}, "."} -> {:continue, {{row, col}, "."}}
      {{_r, _c}, "X"} -> {:continue, {{row, col}, "X"}}
      {{_r, _c}, "#"} -> {:turn, {{row, col}, "#"}}
    end
  end

  def change_direction(direction) do
    case direction do
      "^" -> ">"
      ">" -> "v"
      "v" -> "<"
      "<" -> "^"
    end
  end

  def update_matrix(matrix, x, y) do
    Enum.map(matrix, fn
      {{row, col}, _} = elem when row == x and col == y -> {{row, col}, "X"}
      elem -> elem
    end)
  end



  def part2(_input) do
  end
end
