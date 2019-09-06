defmodule ProteinTranslation do
  @proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.

  ## Examples

    iex> ProteinTranslation.of_rna("UUUUGU")
    {:ok, ["Phenylalanine", "Cysteine"]}

    iex> ProteinTranslation.of_rna("UAUUGU")
    {:ok, ["Tyrosine", "Cysteine"]}

    iex> ProteinTranslation.of_rna("UAUUAA")
    {:ok, ["Tyrosine"]}
    
    iex> ProteinTranslation.of_rna("UAUNOT")
    {:error, "invalid RNA"}
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    # initiate tail recursion
    of_rna(rna, [])
  end

  defp of_rna("", acc), do: {:ok, acc}

  # do pattern matching for string using bitstring <<head::binary-size(3), tail::binary>>
  # head::binary-size(3) will take first 3 letter and the rest will be in tail
  defp of_rna(<<head::binary-size(3), tail::binary>>, acc) do
    case of_codon(head) do
      # immediately replace the acc with "invalid RNA"
      {:error, _} -> {:error, "invalid RNA"}
      # stop the processing and return the accumulated value (acc)
      {:ok, "STOP"} -> {:ok, acc}
      # since we are only returning as one list, we can use [list] ++ [list]
      {:ok, protein} -> of_rna(tail, acc ++ [protein])
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  ## Examples

    iex> ProteinTranslation.of_codon("UGU")
    {:ok, "Cysteine"}

    iex> ProteinTranslation.of_codon("UUA")
    {:ok, "Leucine"}

    iex> ProteinTranslation.of_codon("AUG")
    {:ok, "Methionine"}

    iex> ProteinTranslation.of_codon("UUU")
    {:ok, "Phenylalanine"}

    iex> ProteinTranslation.of_codon("UCU")
    {:ok, "Serine"}

    iex> ProteinTranslation.of_codon("UGG")
    {:ok, "Tryptophan"}

    iex> ProteinTranslation.of_codon("UAU")
    {:ok, "Tyrosine"}

    iex> ProteinTranslation.of_codon("UAA")
    {:ok, "STOP"}
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case Map.fetch(@proteins, codon) do
      :error -> {:error, "invalid codon"}
      {:ok, _} = value -> value
    end
  end
end
