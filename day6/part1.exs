{:ok, contents} = File.read("input.txt")

contents
|> String.replace("\n\n", "-----")
|> String.replace("\n", " ")
|> String.replace("-----", "\n")
|> String.split("\n", trim: true)
|> Enum.map(fn row ->
  row
  |> String.replace(" ", "")
  |> String.split("", trim: true)
  |> Enum.uniq()
  |> length
end)
|> Enum.sum()
|> IO.inspect()
