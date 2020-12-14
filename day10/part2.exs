defmodule Part2 do
  def run do
    {:ok, contents} = File.read("sample2.txt")

    numbers =
      contents
      |> String.split("\n", trim: true)
      |> Enum.map(fn row ->
        {int, ""} = Integer.parse(row)
        int
      end)
      |> Enum.sort()

    max = Enum.max(numbers)
    device = max + 3

    IO.inspect(max, label: "Max")
    IO.inspect(device, label: "Device")

    range = Range.new(round(max / 3), length(numbers))

    Enum.flat_map(range, fn size ->
      combos = combinations(size, numbers)
      IO.inspect({size, length(combos)}, label: "Size and # of combos")

      Enum.map(combos, fn nums ->
        chain(nums ++ [device], 0, %{})
      end)
    end)
    |> Enum.count(fn result -> result != false end)
    |> IO.inspect()
  end

  defp combinations(0, _), do: [[]]
  defp combinations(_, []), do: []

  defp combinations(size, [head | tail]) do
    for(elem <- combinations(size - 1, tail), do: [head | elem]) ++ combinations(size, tail)
  end

  defp chain([], _, acc) do
    acc
  end

  defp chain([nil], _, acc) do
    acc
  end

  defp chain(nil, _, acc) do
    acc
  end

  defp chain([head | rest], prior, acc) do
    diff = head - prior

    case diff <= 3 do
      true ->
        v = Map.get(acc, diff, 0)
        new = Map.put(acc, diff, v + 1)
        chain(rest, head, new)

      false ->
        false
    end
  end
end

Part2.run()
