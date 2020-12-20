defmodule Part2 do
  def run do
    {:ok, contents} = File.read("input.txt")

    rows =
      contents
      |> String.split("\n", trim: true)
      |> Enum.map(fn row ->
        String.split(row, "", trim: true)
      end)

    calculate(rows, iterate(rows))
    |> IO.inspect(label: "Stable")
    |> count_occupied()
    |> IO.inspect(label: "Count")
  end

  defp calculate(one, one) do
    one
  end

  defp calculate(_one, two) do
    calculate(two, iterate(two))
  end

  defp iterate(rows) do
    height = length(rows)

    width = length(Enum.at(rows, 0))

    Enum.map(Range.new(0, height - 1), fn row ->
      Enum.map(Range.new(0, width - 1), fn col ->
        state = cell(rows, row, col)

        neighbors = [
          see(rows, :nw, row, col),
          see(rows, :n, row, col),
          see(rows, :ne, row, col),
          see(rows, :e, row, col),
          see(rows, :se, row, col),
          see(rows, :s, row, col),
          see(rows, :sw, row, col),
          see(rows, :w, row, col)
        ]

        occupied = Enum.count(neighbors, fn cell -> cell == "#" end)

        case state do
          "." ->
            state

          _ ->
            case occupied do
              0 ->
                "#"

              x when x >= 5 ->
                "L"

              _ ->
                state
            end
        end
      end)
    end)
  end

  defp cell(_, -1, _) do
    nil
  end

  defp cell(_, _, -1) do
    nil
  end

  defp cell(rows, row, col) do
    case Enum.at(rows, row) do
      nil ->
        nil

      cols ->
        Enum.at(cols, col)
    end
  end

  defp count_occupied(rows) do
    height = length(rows)
    width = length(Enum.at(rows, 0))

    Enum.reduce(Range.new(0, height - 1), 0, fn row, row_acc ->
      row_count =
        Enum.reduce(Range.new(0, width - 1), 0, fn col, cell_acc ->
          cell = cell(rows, row, col)

          case cell do
            "#" ->
              1 + cell_acc

            _ ->
              0 + cell_acc
          end
        end)

      row_count + row_acc
    end)
  end

  def see(rows, dir, row, col) do
    {row_shift, col_shift} = shift(dir)

    case cell(rows, row + row_shift, col + col_shift) do
      nil ->
        nil

      "." ->
        see(rows, dir, row + row_shift, col + col_shift)

      other ->
        other
    end
  end

  def shift(:nw), do: {-1, -1}
  def shift(:n), do: {-1, 0}
  def shift(:ne), do: {-1, +1}
  def shift(:e), do: {0, +1}
  def shift(:se), do: {+1, +1}
  def shift(:s), do: {+1, 0}
  def shift(:sw), do: {+1, -1}
  def shift(:w), do: {0, -1}
end

Part2.run()
