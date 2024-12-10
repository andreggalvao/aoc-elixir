defmodule MochilaMagica do
  @doc """
  Recebe uma lista de itens e a capacidade máxima.
  Retorna a melhor combinação possível.
  """
  def encontrar_melhor_combinacao(itens, capacidade) do
    # Iniciamos a recursão com estado inicial
    explorar_combinacoes(itens, [], 0, 0, capacidade)
  end

  # Caso base: quando não há mais itens para explorar
  defp explorar_combinacoes([], itens_escolhidos, peso_total, valor_total, _capacidade) do
    %{
      itens: itens_escolhidos,
      peso_total: peso_total,
      valor_total: valor_total
    }
  end

  # Função principal de exploração
  defp explorar_combinacoes([item | resto_itens], itens_escolhidos, peso_atual, valor_atual, capacidade) do
    # Primeiro, tentamos SEM incluir o item atual
    solucao_sem_item = explorar_combinacoes(
      resto_itens,
      itens_escolhidos,
      peso_atual,
      valor_atual,
      capacidade
    )

    # Depois, verificamos se PODEMOS incluir o item atual
    solucao_com_item =
      if peso_atual + item.peso <= capacidade do
        explorar_combinacoes(
          resto_itens,
          [item | itens_escolhidos],
          peso_atual + item.peso,
          valor_atual + item.valor,
          capacidade
        )
      else
        # Se não puder incluir, retornamos a solução sem o item
        solucao_sem_item
      end

    # Comparamos as duas soluções e retornamos a melhor
    if solucao_com_item.valor_total > solucao_sem_item.valor_total do
      solucao_com_item
    else
      solucao_sem_item
    end
  end
end

# Dados de teste
itens = [
  %{nome: :cristal, peso: 4, valor: 10},
  %{nome: :orbe, peso: 3, valor: 7}
]

# Executando o teste
resultado = MochilaMagica.encontrar_melhor_combinacao(itens, 20)
IO.inspect(resultado, label: "Melhor combinação encontrada")
