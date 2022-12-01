defmodule Day12Part2 do
  def run do
    {:ok, contents} = File.read("sample.txt")

    instructions =
      contents
      |> String.split("\n", trim: true)
      |> Enum.map(fn row ->
        parts = String.split(row, "", trim: true)
        [command | value_parts] = parts
        value_string = Enum.join(value_parts)
        {value, _} = Integer.parse(value_string)
        {command, value}
      end)

    start = {10, 1, 0, 0}

    Enum.reduce(instructions, start, fn command, pos ->
      next_position(pos, command)
      |> IO.inspect()
    end)
    |> IO.inspect()
  end

  defp next_position({wpe, wpn, e, n}, {"F", v}) do
    {wpe, wpn, e + v * wpe, n + v * wpn}
  end

  defp next_position({wpe, wpn, e, n}, {"E", v}) do
    {wpe + v, wpn, e, n}
  end

  defp next_position({wpe, wpn, e, n}, {"N", v}) do
    {wpe, wpn + v, e, n}
  end

  defp next_position({wpe, wpn, e, n}, {"W", v}) do
    {wpe - v, wpn, e, n}
  end

  defp next_position({wpe, wpn, e, n}, {"S", v}) do
    {wpe, wpn - v, e, n}
  end

  defp next_position({wpe, wpn, e, n}, {"L", 90}) when wpe >= 0 and wpn >= 0 do
    {-1 * wpn, wpe, e, n}
  end

  defp next_position({wpe, wpn, e, n}, {"L", 90}) when wpe < 0 and wpn < 0 do
    {-1 * wpn, wpe, e, n}
  end

  defp next_position({wpe, wpn, e, n}, {"L", 90}) when wpe < 0 and wpn >= 0 do
    {wpn, -1 * wpe, e, n}
  end

  defp next_position({wpe, wpn, e, n}, {"L", 90}) when wpe >= 0 and wpn < 0 do
    {-1 * wpn, wpe, e, n}
  end

  defp next_position(pos, {"R", 90}) do
    pos
    |> next_position({"L", 90})
    |> next_position({"L", 90})
    |> next_position({"L", 90})
  end

  defp next_position(pos, {"L", 180}) do
    pos
    |> next_position({"L", 90})
    |> next_position({"L", 90})
  end

  defp next_position(pos, {"R", 180}) do
    pos
    |> next_position({"R", 90})
    |> next_position({"R", 90})
  end

  defp next_position(pos, {"L", 270}) do
    pos
    |> next_position({"L", 90})
    |> next_position({"L", 90})
    |> next_position({"L", 90})
  end

  defp next_position(pos, {"R", 270}) do
    pos
    |> next_position({"R", 90})
    |> next_position({"R", 90})
    |> next_position({"R", 90})
  end
end

Day12Part2.run()
