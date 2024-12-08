defmodule AdventOfCode.Solution.Year2024.Day07 do
  def part1(input) do
    input# = File.read!("data.txt")
    |> String.trim()
    |> String.replace(":", "")
    |> String.split("\n")
    |> Enum.map(fn line ->
      [tgt | numbers] = line
      |> String.split()
      |> Enum.map(&String.to_integer/1)
      {tgt, numbers} #tupla geralmente é padrao de retorno, garante consistencia
    end)
    |> Enum.filter(fn {tgt, numbers} ->
      check_combinations(tgt, numbers) #pega tudo que não é false ou nil
    end)
    |> Enum.map(fn {tgt, _} -> tgt end)
    |> Enum.sum()
  end

  def part2(input) do
    input#= File.read!("data.txt")
    |> String.trim()
    |> String.replace(":", "")
    |> String.split("\n")
    |> Enum.map(fn line ->
      [tgt | numbers] = line
      |> String.split()
      |> Enum.map(&String.to_integer/1)
      {tgt, numbers} #tupla geralmente é padrao de retorno, garante consistencia
    end)
    |> Enum.filter(fn {tgt, numbers} ->
      check_combinations_part2(tgt, numbers) #pega tudo que não é false ou nil
    end)
    |> Enum.map(fn {tgt, _} -> tgt end)
    |> Enum.sum()
  end

  defp check_combinations(tgt , [head | tails]), do: check_combinations(tgt, head, tails)
  defp check_combinations(tgt, acc, []), do: acc == tgt
  defp check_combinations(tgt, acc, [head | tail]) do
    check_combinations(tgt, acc + head, tail) or
    check_combinations(tgt, acc * head, tail)
  end

  defp check_combinations_part2(tgt , [head | tails]), do: check_combinations_part2(tgt, head, tails)
  defp check_combinations_part2(tgt, acc, []), do: acc == tgt
  defp check_combinations_part2(tgt, acc, [head | tail]) do
    concatenated_string = Integer.to_string(acc) <> Integer.to_string(head)
    concatenated_number = String.to_integer(concatenated_string)
    check_combinations_part2(tgt, acc + head, tail) or
    check_combinations_part2(tgt, acc * head, tail) or
    check_combinations_part2(tgt, concatenated_number, tail)
  end
end


# Operators are always evaluated left-to-right, not according to precedence rules.
# Furthermore, numbers in the equations cannot be rearranged.
# Glancing into the jungle, you can see elephants holding two different types of operators: add (+) and multiply (*).
## exemplo 3267: 81 40 27
# 81 como acc
## 81 * 40 = 121
## 81 + 40 = 2240
### 121 * 27 = 3267 -OK (a)
### 121 + 27 = 148 (b)
###
### 2240 * 27 = 87480 (c)
### 2240 + 27 = 3267 -OK (d)
#
#1- check_combinations(3267, [81, 40, 27]) -> acc 81
#2- check_combinations(3267, 81 + 40, [27])
#3- check_combinations(3267, 121 + 27, []) -> Retorna false 148 != 3267 (b)
#4- check_combinations(3267, 81 * 40, [27]) -> Volta para o passo 2, agora multiplicando (a)
#5- check_combinations(3267,3240 + 27, []) -> Retorna true porque 3267 == 3267 (d)
#6- check_combinations(3267,3240 * 27, []) -> Retorna false porque 87480 != 3267 (d)
# recursividade e backtracking
#
# split_line_tgt_body(292, 11, [6, 16, 20])  # Primeira chamada
#   ├─ split_line_tgt_body(292, 17, [16, 20])  # Segunda chamada (11 + 6)
#   │    ├─ split_line_tgt_body(292, 33, [20])  # Terceira chamada (17 + 16)
#   │    │    ├─ split_line_tgt_body(292, 53, [])  # Quarta chamada (33 + 20) -> false
#   │    │    └─ split_line_tgt_body(292, 660, [])  # Backtracking e tenta (33 * 20) -> false
#   │    └─ split_line_tgt_body(292, 272, [20])  # Backtracking e tenta (17 * 16)
#   │         ├─ split_line_tgt_body(292, 292, [])  # Quinta chamada (272 + 20) -> true
#   │         └─ split_line_tgt_body(292, 5440, [])  # Backtracking e tenta (272 * 20) -> false
#   └─ split_line_tgt_body(292, 66, [16, 20])  # Backtracking e tenta (11 * 6)
#        ├─ split_line_tgt_body(292, 82, [20])  # Sexta chamada (66 + 16)
#        │    ├─ split_line_tgt_body(292, 102, [])  # Sétima chamada (82 + 20) -> false
#        │    └─ split_line_tgt_body(292, 1640, [])  # Backtracking e tenta (82 * 20) -> false
#        └─ split_line_tgt_body(292, 1056, [20])  # Backtracking e tenta (66 * 16)
#             ├─ split_line_tgt_body(292, 1076, [])  # Oitava chamada (1056 + 20) -> false
#             └─ split_line_tgt_body(292, 21120, [])  # Backtracking e tenta (1056 * 20) -> false
