defmodule AdventOfCode.Solution.Year2024.Day05 do
  def part1(input) do
    {rules, lists} = process_input(input)

    lists
    |> Enum.filter(&validate_list(&1, rules))
    |> Enum.map(&find_middle_number/1)
    |> Enum.sum()
  end

  def process_input(input) do
    [rules_section, lists_section] = String.split(input, "\n\n", parts: 2)

    rules = parse_rules_section(rules_section)
    lists = parse_lists_section(lists_section)

    {rules, lists}
  end

  def parse_rules_section(rules_section) do
    rules_section
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn rule_line, acc ->
      [n_before, n_after] = String.split(rule_line, "|")
                       |> Enum.map(&String.trim/1)
                       |> Enum.map(&String.to_integer/1)

      Map.update(acc, n_before, [n_after], fn existing -> [n_after | existing] end) #adiciona uma key caso nao tenha
    end)
  end

  def parse_lists_section(lists_section) do
    lists_section
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(",")
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def validate_list(list, rules) do
    list
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] -> valid_pair?(a, b, rules) end)
  end

  def valid_pair?(a, b, rules) do
    rules_for_a = Map.get(rules, a, [])
    rules_for_b = Map.get(rules, b, [])

    cond do
      b in rules_for_a -> true
      a in rules_for_b -> false
      true -> true
    end
  end

  def find_middle_number(list) do
    middle_index = div(length(list), 2)
    Enum.at(list, middle_index)
  end

  def part2(_input) do
  end
end
