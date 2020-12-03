defmodule Part2 do
  def count(data, down, right) do
    Enum.reduce_while(data, {1, 0, 0}, fn data_row, {row, col, trees} ->
      current_col =
        case Enum.at(data_row, col) do
          nil ->
            col - length(data_row)

          _ ->
            col
        end

      IO.inspect({row, current_col})

      case rem(row + 1, down) do
        0 ->
          case Enum.at(data_row, current_col) do
            nil ->
              IO.puts("OOOPS")

            "#" ->
              {:cont, {row + 1, current_col + right, trees + 1}}

            _ ->
              {:cont, {row + 1, current_col + right, trees}}
          end

        _ ->
          IO.puts("skip")
          {:cont, {row + 1, current_col, trees}}
      end
    end)
  end

  def run do
    {:ok, contents} = File.read("input.txt")

    data =
      contents
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        String.split(line, "", trim: true)
      end)

    {_, _, tree1} = count(data, 1, 1) |> IO.inspect()
    {_, _, tree2} = count(data, 1, 3) |> IO.inspect()
    {_, _, tree3} = count(data, 1, 5) |> IO.inspect()
    {_, _, tree4} = count(data, 1, 7) |> IO.inspect()
    {_, _, tree5} = count(data, 2, 1) |> IO.inspect()

    IO.inspect(tree1 * tree2 * tree3 * tree4 * tree5)
  end
end

Part2.run()
