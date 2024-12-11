defmodule Mix.Tasks.D10.P1 do
  use Mix.Task
  import AdventOfCode.Solution.Year2024.Day10

  @shortdoc "Day 10 Part 1"
  def run(args) do
    input = AdventOfCode.Input.get!(10, 2024) # Use o ano e dia corretos

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
