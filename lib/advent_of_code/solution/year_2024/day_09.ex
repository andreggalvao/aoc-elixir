defmodule AdventOfCode.Solution.Year2024.Day09 do
  def part1(input) do
    input = "2333133121414131402"
    |> parse()
    |> process()
    |> process_string()
    |> calculate_checksum()
  end

  def parse(input) do
    input
    |> String.trim()
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
  end

  def process(list_with_number) do
    list_with_number
    |> Enum.with_index()
    |> Enum.chunk_every(2)
    |> Enum.with_index()
    |> Enum.map(&expand_blocks(&1))
    |> Enum.join()
  end

  defp expand_blocks({[{file_digit, _file_position}, {space_digit, _space_position}], file_id}) do
      file_block = String.duplicate("#{file_id}", file_digit)
      space_block = String.duplicate(".", space_digit)
      [file_block, space_block]
  end

  defp expand_blocks({[{file_digit, _file_position}], file_id}) do
    [String.duplicate("#{file_id}", file_digit)]
  end

  defp process_string(input) do
    chars = input
    |> String.codepoints()
    |> Enum.with_index()

    process_chars(chars)
  end

  defp process_chars(chars) do
    first_dot = find_first_dot(chars)
    last_number = find_last_number(chars)

    case {first_dot, last_number} do
      {nil, _} -> # Acabou os pontos
        chars |> Enum.map(fn {char, _} -> char end) |> Enum.join()

      {_, nil} -> # Acabou os números
        chars |> Enum.map(fn {char, _} -> char end) |> Enum.join()

      {first_dot, last_number} when first_dot < last_number ->
        chars
        |> swap_positions(first_dot, last_number)
        |> process_chars()

      _ -> # Termina
        chars |> Enum.map(fn {char, _} -> char end) |> Enum.join()
    end

  end

  defp find_first_dot(chars) do
    chars
    |> Enum.find_index(fn {char, _idx} -> char == "." end)
  end

  defp find_last_number(chars) do
    chars
    |> Enum.reverse()
    |> Enum.find_index(fn {char, _idx} -> char != "." end)
    |> case do
      nil -> nil
      idx -> length(chars) - 1 - idx
    end
  end

  defp swap_positions(chars, pos1, pos2) do

    char1 = Enum.at(chars, pos1)
    char2 = Enum.at(chars, pos2)

    chars
    |> List.replace_at(pos1, char2)
    |> List.replace_at(pos2, char1)
  end

  defp calculate_checksum(input) do
    input
    |> String.codepoints()
    |> Enum.with_index()
    |> Enum.filter(fn {char, _idx} -> char != "." end)
    |> Enum.map(fn {char, idx} -> String.to_integer(char) * idx end)
    |> Enum.sum()
  end

  def part2(_input) do
  end



end

# 12345
# 0 file id 0 -> 1 * "0"
# .. space -> 2 * "."
# 111 file id 1 -> 3 * "0"
# .... space  4 * "."
# 22222 file id 2 -> 5 * "0"
