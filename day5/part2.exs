defmodule Part2 do
  def main do
    {:ok, contents} = File.read("input.txt")

    ids =
      contents
      |> String.split("\n", trim: true)
      |> Enum.map(fn data_row ->
        steps =
          data_row
          |> String.split("", trim: true)

        row =
          steps
          |> Enum.slice(0, 7)
          |> find_row(0, 127)

        seat =
          steps
          |> Enum.slice(7, 3)
          |> find_seat(0, 7)

        {row, seat, row * 8 + seat}
      end)
      |> Enum.map(fn {_, _, id} -> Kernel.trunc(id) end)

    Enum.map(0..915, fn id ->
      {id, Enum.member?(ids, id)}
    end)
    |> Enum.filter(fn {_id, tf} -> !tf end)
    |> IO.inspect()
  end

  defp find_row([step], row_min, row_max) do
    case step do
      "F" ->
        row_min

      "B" ->
        row_max
    end
  end

  defp find_row([step | rest], row_min, row_max) do
    h = Float.floor((row_max - row_min) / 2) + row_min

    case step do
      "F" ->
        find_row(rest, row_min, h)

      "B" ->
        find_row(rest, h + 1, row_max)
    end
  end

  defp find_seat([step | []], seat_min, seat_max) do
    case step do
      "L" ->
        seat_min

      "R" ->
        seat_max
    end
  end

  defp find_seat([step | rest], seat_min, seat_max) do
    h = Float.floor((seat_max - seat_min) / 2) + seat_min

    case step do
      "L" ->
        find_seat(rest, seat_min, h)

      "R" ->
        find_seat(rest, h + 1, seat_max)
    end
  end
end

Part2.main()
