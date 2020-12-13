defmodule Part2 do
  def run do
    {:ok, contents} = File.read("input.txt")
    # target = 127
    target = 23_278_925

    numbers =
      contents
      |> String.split("\n", trim: true)
      |> Enum.map(fn row ->
        {int, ""} = Integer.parse(row)
        int
      end)

    stop = length(numbers) - 1

    Enum.each(Range.new(0, stop), fn start ->
      Enum.each(Range.new(0, stop - start), fn length ->
        subset =
          numbers
          |> Enum.slice(start, length)

        total =
          subset
          |> Enum.sum()

        case total do
          ^target ->
            min = Enum.min(subset)
            max = Enum.max(subset)
            IO.inspect(min + max, label: "Answer")

          _ ->
            nil
        end
      end)
    end)
  end
end

Part2.run()
