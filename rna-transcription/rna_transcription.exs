defmodule RNATranscription do
  # define a map constant
  @rna_complements %{
    # using ? to find the character’s code point
    ?G => ?C,
    ?C => ?G,
    ?T => ?A,
    ?A => ?U
  }

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    # using & as function shorthand;
    # each of the charlist will be iterated through the map constants
    Enum.map(dna, &@rna_complements[&1])
    # alt: Enum.map(dna, fn x -> @rna_complements[x] end)
    # alt: Enum.map(dna, &(@rna_complements[&1]))
  end
end
