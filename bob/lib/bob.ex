defmodule Bob do
  @doc """
  Responds to different types of phrases

  ## Examples

  iex> Bob.hey("Tom-ay-to, tom-aaaah-to.")
  "Whatever."

  iex> Bob.hey("WATCH OUT!")
  "Whoa, chill out!"

  iex> Bob.hey("Does this cryogenic chamber make me look fat?")
  "Sure."

  iex> Bob.hey("")
  "Fine. Be that way!"

  iex> Bob.hey("REALLY?")
  "Calm down, I know what I'm doing!"

  """
  def hey(input) do
    cond do
      shout?(input) and question?(input) ->
        "Calm down, I know what I'm doing!"

      silence?(input) ->
        "Fine. Be that way!"

      shout?(input) ->
        "Whoa, chill out!"

      question?(input) ->
        "Sure."

      true ->
        "Whatever."
    end
  end

  defp silence?(input), do: String.trim(input) == ""
  defp question?(input), do: String.last(input) == "?"
  defp have_unicode_letters?(input), do: String.match?(input, ~r/[\p{L}]/)

  defp shout?(input) do
    String.upcase(input) == input and have_unicode_letters?(input)
  end
end
