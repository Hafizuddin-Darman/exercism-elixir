defmodule TwelveDays do
  # define word list using sigil ~w
  # zero is only used to make the number equal to the word
  @number_in_word ~w(
    zero
    first
    second
    third
    fourth
    fifth
    sixth
    seventh
    eighth
    ninth
    tenth
    eleventh
    twelfth
  )

  # value for index 0 is not used
  # zero is only used to make the number equal to the word
  @gift [
    "not used",
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  ]

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the " <>
      Enum.at(@number_in_word, number) <>
      " day of Christmas my true love gave to me: " <>
      build_gift_list(number) <>
      "."
  end

  defp build_gift_list(1) do
    Enum.at(@gift, 1)
  end

  defp build_gift_list(2) do
    Enum.at(@gift, 2) <> ", and " <> build_gift_list(1)
  end

  defp build_gift_list(number) do
    Enum.at(@gift, number) <> ", " <> build_gift_list(number - 1)
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    # create range using the provided value
    starting_verse..ending_verse
    # range can be iterated using enum
    |> Enum.map(&verse(&1))
    # alternate way to write the function call
    # |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
