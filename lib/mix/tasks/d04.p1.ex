defmodule Mix.Tasks.D04.P1 do
  use Mix.Task
  import AdventOfCode.Solution.Year2024.Day04

  @shortdoc "Day 04 Part 1"
  def run(args) do
    input = AdventOfCode.Input.get!(4, 2024) # Use o ano e dia corretos

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end