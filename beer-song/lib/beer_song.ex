defmodule BeerSong do
  @doc ~S"""
  Get a single verse of the beer song

  ## Examples

      iex> BeerSong.verse(99)
      "99 bottles of beer on the wall, 99 bottles of beer.\nTake one down and pass it around, 98 bottles of beer on the wall.\n"

      iex> BeerSong.verse(1)
      "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n"

      iex> BeerSong.verse(0)
      "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"

  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    {shelf_bottle_phrase, take_bottle_phrase} = bottle_phrases(number)

    {remaining_bottle_phrase, _ } = bottle_phrases(number - 1)

    # using string interpolation to replace returned parameters
    """
    #{String.capitalize(shelf_bottle_phrase)} of beer on the wall, #{shelf_bottle_phrase} of beer.
    #{take_bottle_phrase}, #{remaining_bottle_phrase} of beer on the wall.
    """
  end

  @doc ~S"""
  Get the entire beer song for a given range of numbers of bottles.

  ## Example

      iex> BeerSong.lyrics(3..1)
      "3 bottles of beer on the wall, 3 bottles of beer.\nTake one down and pass it around, 2 bottles of beer on the wall.\n\n2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n\n1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n"

      iex> BeerSong.lyrics(2..0)
      "2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n\n1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n\nNo more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"

      iex> BeerSong.lyrics(0..0)
      "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"

  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    # this will enumerate all the range and joined using the second parameter
    # verse is called using function capture operator '&'
    # https://dockyard.com/blog/2016/08/05/understand-capture-operator-in-elixir
    Enum.map_join(range, "\n", &verse/1)
    # using full notation
    # Enum.map_join(range, "\n", &(BeerSong.verse/1))
  end

  # using condition instead of function guard 
  defp bottle_phrases(number) do
    cond do
      number > 1 ->
        {"#{number} bottles", "Take one down and pass it around"}

      number == 1 ->
        {"1 bottle", "Take it down and pass it around"}

      # to cater for bottle_phrases(0)
      number < 0 ->
        {"99 bottles", ""}

      true ->
        {"no more bottles", "Go to the store and buy some more"}
    end
  end
end
