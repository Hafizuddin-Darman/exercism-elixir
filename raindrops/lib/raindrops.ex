defmodule Raindrops do
  # define a map constant
  @raindrop_sound %{
    3 => "Pling",
    5 => "Plang",
    7 => "Plong"
  }

  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
  just pass the number's digits straight through.
  """
  # @spec convert(pos_integer) :: String.t()
  # def convert(number) do
  #   # set filter anonymous function
  #   # this is to get the applicable condition for the "for" comprehension
  #   filter_fn = fn number, raindrop_number ->
  #     rem(number, raindrop_number) == 0
  #   end

  #   # the actual action when filter_fn is true
  #   map_fn = fn x ->
  #     @raindrop_sound[x]
  #   end

  #   # extract list of key to the given map to be enumerated
  #   # this will set 3, 5, 7 as the enumeration value
  #   map_keys = Map.keys(@raindrop_sound)

  #   # doing "for" comprehension since filter_map is deprecated
  #   mapped_value =
  #     for n <- map_keys,
  #         filter_fn.(number, n),
  #         do: map_fn.(n)

  #   # change the list into one string
  #   to_string(mapped_value, number)
  # end

  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    # set filter anonymous function
    # this is to get the applicable condition for the "for" comprehension
    filter_fn = fn number, raindrop_number ->
      rem(number, raindrop_number) == 0
    end

    # the actual action when filter_fn is true
    map_fn = fn x ->
      @raindrop_sound[x]
    end

    # doing "for" comprehension since filter_map is deprecated
    # extract list of key to the given map to be enumerated by "for" comprehension
    # this will set 3, 5, 7 as the enumeration value
    mapped_value =
      for n <- Map.keys(@raindrop_sound),
          filter_fn.(number, n),
          do: map_fn.(n)

    # change the list into one string
    to_string(mapped_value, number)
  end

  defp to_string([], number), do: "#{number}"
  defp to_string(list, _), do: Enum.join(list)
end
