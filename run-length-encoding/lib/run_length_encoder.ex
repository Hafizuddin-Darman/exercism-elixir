defmodule RunLengthEncoder do
  # @encode_regex ~r/(.)\1*/
  @decode_regex ~r/(\d+)(.)/
  # @decode_regex_scan ~r/(\d*)(.)/
  # alternate way to write regex sigil
  # @decode_regex_scan_alt ~r{(\d*)(.)}

  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"

  ## Examples

  iex> RunLengthEncoder.encode("AABBBCCCC")
  "2A3B4C"

  iex> RunLengthEncoder.encode("AABBBECCCCD")
  "2A3BE4CD"

  iex> RunLengthEncoder.decode("2A3B4C")
  "AABBBCCCC"

  iex> RunLengthEncoder.decode("2A3BE4C")
  "AABBBECCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    # convert to list of character
    # i use graphemes to cater for unicode
    |> String.graphemes()
    # group the same character in one sub list
    |> Enum.chunk_by(& &1)
    # compress the character
    |> Enum.map(&compress/1)
    # join the string
    |> List.to_string()

    # alternate way to create the string
    # |> Enum.join()
  end

  # if there are only one character
  defp compress([character]), do: character

  # if there are list of characters
  defp compress(character_list), do: "#{length(character_list)}#{List.first(character_list)}"

  # # encode alternate solution #1
  # # using regex replace

  # @spec encode(String.t()) :: String.t()
  # def encode(string) do
  #   # the replace function will show the overall matched value and the subsequent return value is based on the capture group
  #   # &1 will return the overall regex match (e.g. "AAAB" will show &1 = "AAA" and "B" on the next iteration)
  #   # there are only one capture group thus &2 is referring to the (.) capture group (e.g. "AAAB" will show &2 = "A" and "B" on the next iteration)
  #   Regex.replace(@encode_regex, string, &encode(String.length(&1), &2))
  # end

  # # to ensure the value of 1 is omitted
  # defp encode(1, character) do
  #   character
  # end

  # defp encode(character_count, character) do
  #   "#{character_count}#{character}"
  # end

  # # encode alternate solution #2
  # # using regex scan

  # @spec encode(String.t()) :: String.t()
  # def encode(string) do
  #   @encode_regex
  #   |> Regex.scan(string)
  #   |> Enum.flat_map(&[List.first(&1) |> String.length(), List.last(&1)])
  #   |> Enum.filter(&(&1 != 1))
  #   |> Enum.join()
  # end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    # the replace function will show the overall matched value and the subsequent return value is based on the capture group
    # &1 will return the overall regex match (e.g. "AAAB" will show &1 = "AAA" and "B" on the next iteration)
    # there are only one capture group thus &2 is referring to the (.) capture group (e.g. "AAAB" will show &2 = "A" and "B" on the next iteration)
    Regex.replace(@decode_regex, string, fn _, character_count, character ->
      String.duplicate(character, String.to_integer(character_count))
    end)
  end

  # # decode alternate solution #1
  # # using regex scan

  # @spec decode(String.t()) :: String.t()
  # def decode(string) do
  #   # find the pair of digits (\d*) + remaining character (.)
  #   # none or multiple digit is counted since star is used
  #   # only one character since the dot have no repetition character set (e.g. no star or plus sign)
  #   # the scan will split based on the regex (e.g. "2A9B" will cause the scan to be "2A" then "9B" as seperate list)
  #   Regex.scan(@decode_regex_scan, string)
  #   |> Enum.map(&decompress/1)
  #   |> Enum.join()
  # end

  # defp decompress([_, "", character]), do: character

  # defp decompress([_, character_count, character]),
  #   do: String.duplicate(character, String.to_integer(character_count))
end
