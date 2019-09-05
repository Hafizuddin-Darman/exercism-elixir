defmodule RotationalCipher do
  @uppercase_char_enum ?A..?Z
  @lowercase_char_enum ?a..?z
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    # convert string to char for per character processing
    |> to_charlist
    # pass each char in the list to process_rotation
    # &1 represent the value when Enum.map is processing recursively
    |> Enum.map(&process_rotation(&1, shift))
    |> to_string
  end

  defp process_rotation(char, number_to_shift) do
    cond do
      # get the char and shift count then add to ?A or ?a
      # char are represented with a number e.g. ?A = 65; ?B = 66
      # calculation:
      #   rem(?B - ?A + 1, 26) + ?A
      #   = rem(66 - 65 + 1, 26) + 65
      #   = 2 + 65
      #   = 67
      #   = ?C
      char in @uppercase_char_enum -> rem(char - ?A + number_to_shift, 26) + ?A
      char in @lowercase_char_enum -> rem(char - ?a + number_to_shift, 26) + ?a
      true -> char
    end
  end
end
