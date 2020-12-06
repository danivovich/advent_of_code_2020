defmodule Part2 do
  def main do
    {:ok, contents} = File.read("input.txt")

    contents
    |> String.replace("\n\n", "-----")
    |> String.replace("\n", " ")
    |> String.replace("-----", "\n")
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      row
      |> String.split(" ", trim: true)
      |> intersections()
      |> MapSet.to_list()
      |> length()
    end)
    |> Enum.sum()
    |> IO.inspect()
  end

  def intersections([first | answers]) do
    start = String.split(first, "", trim: true)

    Enum.reduce(answers, MapSet.new(start), fn person_answers, set ->
      as = String.split(person_answers, "", trim: true)
      MapSet.intersection(set, MapSet.new(as))
    end)
  end
end

Part2.main()
