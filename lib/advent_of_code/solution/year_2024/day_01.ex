defmodule AdventOfCode.Solution.Year2024.Day01 do
  def preprocessor(input) do
    input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn line ->
        line
        |> String.split()
        |> Enum.map(&String.to_integer/1)
      end)
      |> Enum.zip_with(&(&1))

  end


  def part1(input) do
    [l1, l2] = preprocessor(input)
    result =
      Enum.zip(Enum.sort(l1), Enum.sort(l2))
      |> Enum.map(fn {x, y} -> abs(x - y) end)
      |> Enum.sum()

    result

  end

  def part2(input) do
    [l1, l2] = preprocessor(input)

    freq = Enum.frequencies(l2)

    result =
      l1
      |> Enum.map(fn element ->
        frequencia_real = Map.get(freq, element, 0)
        element * frequencia_real
      end)
      |> Enum.sum()

    result

  end
end
