defmodule AdventOfCode.Solution.Year2024.Day10 do

 ####
 #### PARCIALMENTE FEITO, FALTA CONTAR OS SCORES
 ####
  def part1(_input) do
    input = """
            89010123
            78121874
            87430965
            96549874
            45678903
            32019012
            01329801
            10456732
            """
    map_parse = parse(input)

     positions =
      map_parse
      |> Enum.filter(fn {{_row, _col}, value} -> value == 0 end)

    positions
      |> Enum.map(fn {{x,y}, char} ->
        move({{x,y}, char}, map_parse)
      end)
    |>List.flatten()
    |> Enum.count(&(&1 == true))

  end

  def parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn { line, row_index }, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {char, col_index}, acc_inner ->
        case Integer.parse(char) do
          {int, _} -> Map.put(acc_inner, {row_index, col_index}, int)
          :error -> acc_inner
        end
      end)
    end)
  end


  def move({{x,y}, char}, positions) do
    next_num = char + 1
    case Map.get(positions, {x,y}) do
      9 -> true
      nil -> false
      _ -> possible_paths = [
        {x+1,y},
        {x-1,y},
        {x,y+1},
        {x,y-1}
      ]

      possible_paths
      |> Enum.filter(fn pos ->
        Map.get(positions, pos) == next_num
      end)
      |> Enum.any?(fn {n_x,n_y} ->
        move({{n_x,n_y},next_num}, positions)
      end)
    end
  end


  def part2(_input) do
  end
end


## pegar possiveis starts
## testar cada um
## somar o que der certo
