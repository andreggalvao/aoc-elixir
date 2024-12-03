defmodule AdventOfCode.Solution.Year2024.Day02 do
  def part1(input) do
    input
    |> String.trim()
    |> String.split("\n")\
    |> Enum.map(fn line ->
      line
      |> String.split()
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2,1, :discard)
      |> Enum.map(fn [a, b] -> b - a end)
      |> then(fn numbers ->
        all_positive = Enum.all?(numbers, &( 1<= &1 and &1 <= 3))
        all_negative = Enum.all?(numbers, &( -3<= &1 and &1 <= -1))

        all_positive or all_negative
        end)
    end)
    |> Enum.count(&(&1 == true))


  end


  def part2(input) do
    input
    |> String.trim()
    |> String.split("\n")\
    |> Enum.map(fn line ->
      numeros = line
      |> String.split()
      |> Enum.map(&String.to_integer/1)

      numeros
      |> Enum.with_index()
      |> Enum.map(fn {_x,index} ->
        List.delete_at(numeros, index)
      end)
      |> Enum.map(fn list_with_combinations ->
        list_with_combinations
        |> Enum.chunk_every(2,1, :discard)
        |> Enum.map(fn [a, b] -> b - a end)
        |> then(fn numbers ->
            all_positive = Enum.all?(numbers, &( 1<= &1 and &1 <= 3))
            all_negative = Enum.all?(numbers, &( -3<= &1 and &1 <= -1))

            all_positive or all_negative
          end)
      end)
    end)
    |> Enum.count(fn line -> Enum.any?(line, &(&1)) end)
  end
end
