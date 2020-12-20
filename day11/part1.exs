defmodule Day11 do
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
          # Above
          cell(rows, row - 1, col - 1),
          cell(rows, row - 1, col),
          cell(rows, row - 1, col + 1),
          # Same Row
          cell(rows, row, col - 1),
          cell(rows, row, col + 1),
          # Below
          cell(rows, row + 1, col - 1),
          cell(rows, row + 1, col),
          cell(rows, row + 1, col + 1)
        ]

        occupied = Enum.count(neighbors, fn cell -> cell == "#" end)

        case state do
          "." ->
            state

          _ ->
            case occupied do
              0 ->
                "#"

              x when x >= 4 ->
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
end

Day11.run()
