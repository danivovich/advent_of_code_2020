defmodule Part1 do
  def run do
    {:ok, contents} = File.read("input.txt")

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

    # What is the number of 1-jolt differences multiplied by the number of 3-jolt differences?
    differences =
      chain(numbers ++ [device], 0, %{})
      |> IO.inspect()

    IO.inspect(differences[1] * differences[3], label: "Answer")
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
    v = Map.get(acc, diff, 0)
    new = Map.put(acc, diff, v + 1)
    chain(rest, head, new)
  end
end

Part1.run()
