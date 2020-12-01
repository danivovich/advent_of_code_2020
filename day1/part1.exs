{:ok, contents} = File.read("input.txt")

numbers =
  contents
  |> String.split("\n", trim: true)
  |> Enum.map(fn s ->
    {i, _} = Integer.parse(s)
    i
  end)

Enum.each(numbers, fn one ->
  case Enum.find(numbers, fn two -> one + two == 2020 end) do
    nil ->
      nil

    two ->
      IO.inspect(one * two)
  end
end)
