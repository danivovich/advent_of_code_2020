{:ok, contents} = File.read("input.txt")

numbers =
  contents
  |> String.split("\n", trim: true)
  |> Enum.map(fn s ->
    {i, _} = Integer.parse(s)
    i
  end)

Enum.each(numbers, fn one ->
  Enum.each(numbers, fn two ->
    case one + two do
      2020 ->
        IO.inspect(one * two)

      _ ->
        nil
    end
  end)
end)
