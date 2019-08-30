defmodule Roman do
  # define keyword list constant
  @conversions [
    # also can be notated as "M": 1000, "CM": 900
    # ordered by maximum to minimum to avoid the need of sorting
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    # calling tail recursive function
    numerals(number, "")
  end

  defp numerals(0, roman) do
    roman
  end

  defp numerals(number, roman) do
    # Enum.find/3 will return the first value that fulfill the function
    {const_number, roman_result} =
      Enum.find(@conversions, roman, fn {const_number, roman} -> number >= const_number end)

    # call their own function recursively
    numerals(number - const_number, roman <> roman_result)
  end

  # Alternate solution (not using tail recursion)

  # def numerals(0), do: ""

  # def numerals(number) do
  #   {const_number, roman} =
  #     Enum.find(@conversions, fn {const_number, roman} -> number >= const_number end)

  #   # this will concatenate the current value (roman) with the result of the subsequent method call
  #   roman <> numerals(number - const_number)
  # end
end
