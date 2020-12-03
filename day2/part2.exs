{:ok, contents} = File.read("input.txt")

data =
  contents
  |> String.split("\n", trim: true)
  |> Enum.map(fn s ->
    [pos, letter, data] = String.split(s, " ", trim: true)

    pos =
      pos
      |> String.split("-", trim: true)
      |> Enum.map(fn s ->
        {i, _} = Integer.parse(s)
        i
      end)

    {pos, letter, String.split(data, "", trim: true)}
  end)

results =
  Enum.map(data, fn {[one, two], letter, emes} ->
    letter = String.replace(letter, ":", "")
    at_one = Enum.at(emes, one - 1)
    at_two = Enum.at(emes, two - 1)
    IO.inspect({one, two, letter, at_one, at_two, emes})

    (at_one == letter && at_two != letter) ||
      (at_one != letter && at_two == letter)
  end)

Enum.count(results, fn x -> x end)
|> IO.inspect()
