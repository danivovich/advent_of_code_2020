{:ok, contents} = File.read("input.txt")

data =
  contents
  |> String.split("\n", trim: true)
  |> Enum.map(fn s ->
    [range, letter, data] = String.split(s, " ", trim: true)

    range =
      range
      |> String.split("-", trim: true)
      |> Enum.map(fn s ->
        {i, _} = Integer.parse(s)
        i
      end)

    {range, letter, String.split(data, "", trim: true)}
  end)

results =
  Enum.map(data, fn {[min, max], letter, emes} ->
    letter = String.replace(letter, ":", "")
    count = Enum.count(emes, fn x -> x == letter end)
    IO.inspect({min, max, letter, count, emes})
    count >= min && count <= max
  end)

Enum.count(results, fn x -> x end)
|> IO.inspect()
