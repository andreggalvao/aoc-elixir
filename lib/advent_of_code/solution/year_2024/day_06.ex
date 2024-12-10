defmodule AdventOfCode.Solution.Year2024.Day06 do
  def part1(_input) do

    matrix = generate_matrix(File.read!("data.txt"))
    inicial_position = current_position(matrix)
    move(inicial_position, matrix)
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
    # IO.inspect({{x, y}, direction})
    updated_matrix = update_matrix(matrix, x, y, "X")

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
      {{_r, _c}, "\r"} -> {:error, "No element found in the specified direction"}
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

  def part2(input) do
    matrix = generate_matrix(input)#generate_matrix(File.read!("data.txt"))
    inicial_position = current_position(matrix)
    possible_positions = Enum.filter(matrix, fn {{_row, _col}, char} -> char == "." end)

    loop_positions_count =
      possible_positions
      |> Task.async_stream(fn {{row, col}, _char} ->
        test_matrix = update_matrix(matrix, row, col, "#")
        case is_loop?(inicial_position, test_matrix, MapSet.new()) do
          {:loop_detected, _} -> true
          _ -> false
        end
      end, max_concurrency: System.schedulers_online(), timeout: :infinity)
      |> Enum.count(fn result -> result == {:ok, true} end)

    IO.puts("Number of positions that cause a loop: #{loop_positions_count}")
    loop_positions_count
  end

  defp is_loop?(position, matrix, visited_positions) do
    # IO.inspect(position)
    if MapSet.member?(visited_positions, position) do
      {:loop_detected, matrix}
    else
      {{x, y}, direction} = position
      updated_matrix = update_matrix(matrix, x, y)

      case what_is_in_front(position, updated_matrix) do

        {:continue, {{row, col}, "."}} ->  is_loop?({{row, col}, direction}, updated_matrix, MapSet.put(visited_positions, position))
        {:continue, {{row, col}, "X"}} ->  is_loop?({{row, col}, direction}, updated_matrix, MapSet.put(visited_positions, position))


        {:turn, _} ->
          new_direction = change_direction(direction)
          is_loop?({{x, y}, new_direction}, updated_matrix, MapSet.put(visited_positions, position))

        {:error, _txt} ->
          {:finished, "fim"}
      end
    end
  end

  defp update_matrix(matrix, x, y, new_char \\ "X") do
    Enum.map(matrix, fn
      {{row, col}, _} = _elem when row == x and col == y -> {{row, col}, new_char}
      elem -> elem
    end)
  end
end
