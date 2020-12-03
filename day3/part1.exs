{:ok, contents} = File.read("sample.txt")

# def cell(data, r, d) do
# data[d][r]
# end

data =
  contents
  |> String.split("\n", trim: true)
  |> Enum.map(fn line ->
    Enum.flat_map(1..1000, fn _ ->
      String.split(line, "", trim: true)
    end)
  end)

Enum.reduce_while(data, {0, 0}, fn row, {col, trees} ->
  case Enum.at(row, col) do
    nil ->
      IO.puts("END")
      {:halt, {col, trees}}

    "#" ->
      IO.puts("TREEEE")
      {:cont, {col + 3, trees + 1}}

    _ ->
      IO.puts(".")
      {:cont, {col + 3, trees}}
  end
end)
|> IO.inspect()

# results =
# Enum.map(data, fn {[min, max], letter, emes} ->
# letter = String.replace(letter, ":", "")
# count = Enum.count(emes, fn x -> x == letter end)
# IO.inspect({min, max, letter, count, emes})
# count >= min && count <= max
# end)

# Enum.count(results, fn x -> x end)
# |> IO.inspect()
