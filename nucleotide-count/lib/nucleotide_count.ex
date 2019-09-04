defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    # using condition to do fail fast
    cond do
      # matching strand and @nucleotides
      MapSet.subset?(MapSet.new(strand), MapSet.new(@nucleotides)) == false ->
        raise ArgumentError

      # matching nucleotide and @nucleotides
      nucleotide in @nucleotides == false ->
        raise ArgumentError

      # immediately throw empty result
      strand == [] ->
        0

      true ->
        Enum.count(strand, &(&1 == nucleotide))
    end
  end

  # alternate solution using tail recursive function
  
  # def count(strand, nucleotide), do: count(strand, nucleotide, 0)
  # defp count([nucleotide | _], _, _) when not (nucleotide in @nucleotides),
  #   do: raise(ArgumentError)
  # defp count(_, nucleotide, _) when not (nucleotide in @nucleotides), do: raise(ArgumentError)
  # defp count([], _, acc), do: acc
  # defp count([nucleotide | tail], nucleotide, acc), do: count(tail, nucleotide, acc + 1)
  # defp count([_ | tail], nucleotide, acc), do: count(tail, nucleotide, acc)

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    Map.new(@nucleotides, &{&1, count(strand, &1)})
  end

  # alternate solution using tail recursive function

  # def histogram(strand), do: histogram(strand, %{?A => 0, ?T => 0, ?C => 0, ?G => 0})
  # defp histogram([], counts), do: counts
  # defp histogram([nucleotide | tail], counts) when nucleotide in @nucleotides do
  #   %{^nucleotide => acc} = counts
  #   histogram(tail, %{counts | nucleotide => acc + 1})
  # end
  # defp histogram(_, _), do: raise(ArgumentError)
end
