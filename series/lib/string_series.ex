defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_s, size) when size <= 0, do: []

  def slices(s, size) do
    s
    # convert to charlist to cater for unicode character
    |> String.to_charlist()
    # using chunk_every(enumerable, count, step, leftover)
    # count is the size of chunk
    # step is shift count e.g. 1,2,3 -> 2,3,4 -> 3,4,5
    # leftover is to handle value that is not enough to be in one chunk
    # :discard will basically delete the leftover
    |> Enum.chunk_every(size, 1, :discard)
    # Enum.chunk_every/4 will create map in map e.g. [[1, 2, 3], [3, 4, 5]]
    # below is to map only the second level of map e.g. [[123], [345]]
    |> Enum.map(&to_string/1)
  end
end
