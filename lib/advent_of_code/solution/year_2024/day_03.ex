defmodule AdventOfCode.Solution.Year2024.Day03 do
  def part1(input) do
    regex = ~r/mul\((\d+),(\d+)\)/

    Regex.scan(regex, input)
    |> Enum.map(&clean_and_process/1)
    |> Enum.sum()
    |> IO.inspect()
  end

  defp clean_and_process([_string, x, y]), do: String.to_integer(x) * String.to_integer(y)


  def part2(input) do

    expression = Regex.scan(~r/(don't\(\)|do\(\)|mul\(\d+,\d+\))/, input)
              |> Enum.map(fn [match|_] -> match end)


    process_expression(expression, true, 0)  #começa aceitando
    |> IO.inspect()

  end

  defp process_expression([], _true, final_value), do: final_value #quando acbar

  defp process_expression(["don't()" | tail], _false, value), do: process_expression(tail, false, value) #quando é dont, passa flase

  defp process_expression(["do()" | tail], _true, value), do: process_expression(tail, true, value) #quando é do, passa true

  defp process_expression([expression | tail], allowed, value) when allowed do #mul quando true
    new_value = value + clean_and_process_part2(expression)
    process_expression(tail, allowed, new_value)
  end

  defp process_expression([_expression | tail], false, value), do:  process_expression(tail, false, value) #mul quando false

  defp clean_and_process_part2(expression) do
    [_, x, y] = Regex.run(~r/mul\((\d+),(\d+)\)/, expression)
    String.to_integer(x) * String.to_integer(y)
  end
end
