{:ok, contents} = File.read("input.txt")

contents
|> String.replace("\n\n", "-----")
|> String.replace("\n", " ")
|> String.replace("-----", "\n")
|> String.split("\n", trim: true)
|> Enum.map(fn row ->
  row
  |> String.split(" ", trim: true)
  |> Enum.map(fn fieldvalue ->
    [field, _] = String.split(fieldvalue, ":", trim: true)
    field
  end)
end)
|> Enum.filter(fn row ->
  ["ecl", "pid", "eyr", "hcl", "byr", "iyr", "hgt"]
  |> Enum.all?(fn req ->
    Enum.any?(row, fn f -> f == req end)
  end)
end)
|> length()
|> IO.inspect()
