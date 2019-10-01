defmodule Acronym do
  # set constant regex
  # ~r/ <value here> / => this is the sigil to indicate the value between is a regex
  # \b\w is for checking the first letter after the boundary
  # | is used as or (this case \b\w or \p{Lu})
  # \p{Lu} is to find uppercase unicode character with lowercase value
  # this is to include T in "HyperText Markup Language"
  @regex_value ~r/\b\w|\p{Lu}/

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.scan(@regex_value, string)
    |> List.to_string()
    # alternate way to create the string
    # |> Enum.join()
    |> String.upcase()
  end
end
