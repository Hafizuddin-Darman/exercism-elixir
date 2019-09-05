defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1     = wink                                                        = hex-number: 0x01 = binary-number: 0000 0001
  10    = double blink                                                = hex-number: 0x02 = binary-number: 0000 0010
  100   = close your eyes                                             = hex-number: 0x04 = binary-number: 0000 0100
  1000  = jump                                                        = hex-number: 0x08 = binary-number: 0000 1000

  10000 = Reverse the order of the operations in the secret handshake = hex-number: 0x08 = binary-number: 0001 0000
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    # separate the number to separate digits and change it into base of 2 (binary). search for:radix
    Integer.digits(code, 2)
    # reverse the generated binary number order
    # (1 - > jump)(1 - > close your eyes)(1 - > double blink)(1 - > walk)
    # the correct order is walk -> double blink -> close your eyes -> jump
    |> Enum.reverse()
    # assign the binary number to a index number
    |> Enum.with_index()
    # process the iteration by calling append while removing the used binary number
    |> Enum.reduce([], &append/2)
    # Enum.reduce/3 will always process in reverse order thus need to reverse back
    # need to look if we do not need to do the reverse in the first place
    |> Enum.reverse()
  end

  # using the generated tuple list (by Enum.with_index/2) do pattern matching
  # each tuple are compared using Enum.reduce/3, extracting the tuple one by one
  # e.g. #1 {0, 1} will be using append({0, _}, acc)
  # e.g. #2 {1, 3} will be using append({_, 3}, acc)
  defp append({0, _}, acc), do: acc
  defp append({_, 0}, acc), do: ["wink" | acc]
  defp append({_, 1}, acc), do: ["double blink" | acc]
  defp append({_, 2}, acc), do: ["close your eyes" | acc]
  defp append({_, 3}, acc), do: ["jump" | acc]
  defp append({_, 4}, acc), do: Enum.reverse(acc)
  defp append({_, _}, acc), do: acc

  ### Alternate solution ###

  # use Bitwise

  # @doc """
  # Determine the actions of a secret handshake based on the binary
  # representation of the given `code`.

  # If the following bits are set, include the corresponding action in your list
  # of commands, in order from lowest to highest.

  # 1     = wink                                                        = hex-number: 0x01 = binary-number: 0000 0001
  # 10    = double blink                                                = hex-number: 0x02 = binary-number: 0000 0010
  # 100   = close your eyes                                             = hex-number: 0x04 = binary-number: 0000 0100
  # 1000  = jump                                                        = hex-number: 0x08 = binary-number: 0000 1000

  # 10000 = Reverse the order of the operations in the secret handshake = hex-number: 0x08 = binary-number: 0001 0000
  # """
  # @spec commands(code :: integer) :: list(String.t())
  # def commands(code) do
  #   []
  #   |> do_commands(0x08 == (code &&& 0x08), "jump")
  #   |> do_commands(0x04 == (code &&& 0x04), "close your eyes")
  #   |> do_commands(0x02 == (code &&& 0x02), "double blink")
  #   |> do_commands(0x01 == (code &&& 0x01), "wink")
  #   # call do_commands but passing function instead of string
  #   |> do_commands(0x10 == (code &&& 0x10), &Enum.reverse/1)
  # end

  # # this is to define the function head. not really needed for this case but will be needed for other case
  # # see function head explanation in elixir school -> function -> default arguments
  # defp do_commands(acc, do?, todo)
  # defp do_commands(acc, false, _), do: acc
  # defp do_commands(acc, true, str) when is_binary(str), do: [str | acc]
  # defp do_commands(acc, true, fun), do: fun.(acc)
end
