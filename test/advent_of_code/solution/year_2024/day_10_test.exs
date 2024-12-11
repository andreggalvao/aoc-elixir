defmodule AdventOfCode.Solution.Year2024.Day10Test do
  use ExUnit.Case, async: true

  import AdventOfCode.Solution.Year2024.Day10

  setup do
    [
      input: """
      ...0...
      ...1...
      ...2...
      6543456
      7.....7
      8.....8
      9.....9
      """
    ]
  end

  @tag :skip
  test "part1", %{input: input} do
    result = part1(input)

    assert result == 2
  end

  @tag :skip
  test "part2", %{input: input} do
    result = part2(input)

    assert result
  end
end
