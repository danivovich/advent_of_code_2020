defmodule Part1 do
  def run do
    {:ok, contents} = File.read("input.txt")
    preamble_length = 25

    numbers =
      contents
      |> String.split("\n", trim: true)
      |> Enum.map(fn row ->
        {int, ""} = Integer.parse(row)
        int
      end)

    stop = length(numbers) - 1

    Enum.each(Range.new(preamble_length, stop), fn pos ->
      preamble = Enum.slice(numbers, pos - preamble_length, preamble_length)

      value = Enum.at(numbers, pos)

      case valid?(preamble, value) do
        true ->
          nil

        false ->
          IO.inspect(value)
      end
    end)
  end

  defp valid?(preamble, value) do
    sums =
      Enum.flat_map(preamble, fn a ->
        Enum.map(preamble, fn b ->
          a + b
        end)
      end)

    Enum.member?(sums, value)
  end
end

Part1.run()
