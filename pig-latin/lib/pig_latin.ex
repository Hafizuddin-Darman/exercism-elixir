defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    # split each word from phrase
    |> String.split(" ")
    # process each words
    |> Enum.map_join(" ", &process_word(&1))
  end

  # # the short solution :P
  # defp process_word(word) do
  #   [head, included_captures, tail] =
  #     String.split(word, ~r/(a|e|i|o|u|yt|yd|xr|xb|^squ|^qu)/, include_captures: true, parts: 2)

  #   if Regex.match?(~r/^(squ|qu)/, included_captures) do
  #     tail <> included_captures <> "ay"
  #   else
  #     included_captures <> tail <> head <> "ay"
  #   end
  # end

  # the long dynamic solution :P
  # define the list of vowels (including special ones)
  @vowels ["a", "e", "i", "o", "u", "yd", "yt", "xr", "xb"]
  # define consonants which will break the above vowels regex
  @consonants ["squ", "qu"]

  defp process_word(word) do
    # notice the parts only 2 but there will be 3 items in the list because of include_captures: true
    [head, included_captures, tail] =
      String.split(word, build_vowels_regex(), include_captures: true, parts: 2)

    # if the second var in the list is part of the special consonants, then move it to last
    if Regex.match?(build_consonants_regex(), included_captures) do
      tail <> included_captures <> "ay"
    else
      included_captures <> tail <> head <> "ay"
    end
  end

  # dynamically build the regex
  defp build_vowels_regex() do
    {:ok, vowels_regex} = Regex.compile("(" <> build_vowels_collection() <> ")")

    vowels_regex
  end

  defp build_consonants_regex() do
    {:ok, consonants_regex} = Regex.compile("^(" <> build_consonants_collection() <> ")")

    consonants_regex
  end

  defp build_vowels_collection() do
    vowels_collection = Enum.join(@vowels, "|")

    consonants_collection =
      Enum.map(@consonants, fn x -> "^" <> x end)
      |> Enum.join("|")

    vowels_collection <> "|" <> consonants_collection
  end

  defp build_consonants_collection() do
    Enum.join(@consonants, "|")
  end
end
