defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    # initiate tail recursive function
    keep(list, fun, [])
  end

  defp keep([], _, acc), do: acc

  defp keep([head | tail], fun, acc) do
    if fun.(head) do
      # using pattern matching
      # automatically building the list when adding [head | tail_function]
      # cannot use keep(tail, fun, acc ++ head) since it will combine the list into one list
      # error example: [[1, 2, 3], [2, 1, 2], [2, 2, 1]] will become [[1, 2, 3], [2, 1, 2], [2, 2, 1]]
      [head | keep(tail, fun, acc)]
    else
      keep(tail, fun, acc)
    end
  end

  # # alternate way to invoke function using apply
  # defp keep([head | tail], fun, acc) do
  #   if apply(fun, [head]) do
  #     [head | keep(tail, fun, acc)]
  #   else
  #     keep(tail, fun, acc)
  #   end
  # end

  # # the illegal function :P
  # def keep(list, fun) do
  #   Enum.filter(list, fun)
  # end

  # # other alternate solution :P
  # def keep(list, fun) do
  #   # generator after for
  #   for x <- list,
  #       # filter
  #       fun.(x),
  #       do: x
  # end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    keep(list, &(!fun.(&1)))
  end

  # # the illegal function :P
  # def discard(list, fun) do
  #   Enum.reject(list, fun)
  # end

  # # other alternate solution :P
  # def discard(list, fun) do
  #   for x <- list,
  #       # notice the ! to invert the function result given
  #       !fun.(x),
  #       do: x
  # end
end
