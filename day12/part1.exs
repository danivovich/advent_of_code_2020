defmodule Day12Part1 do
  def run do
    {:ok, contents} = File.read("input.txt")

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

    start = {"E", 0, 0}

    Enum.reduce(instructions, start, fn command, pos ->
      next_position(pos, command)
    end)
    |> IO.inspect()
  end

  defp next_position({dir, e, n}, {"F", v}) do
    case dir do
      "N" ->
        {dir, e, n + v}

      "S" ->
        {dir, e, n - v}

      "E" ->
        {dir, e + v, n}

      "W" ->
        {dir, e - v, n}
    end
  end

  defp next_position({dir, e, n}, {"E", v}) do
    {dir, e + v, n}
  end

  defp next_position({dir, e, n}, {"N", v}) do
    {dir, e, n + v}
  end

  defp next_position({dir, e, n}, {"W", v}) do
    {dir, e - v, n}
  end

  defp next_position({dir, e, n}, {"S", v}) do
    {dir, e, n - v}
  end

  defp next_position({dir, e, n}, {"L", 90}) do
    case dir do
      "N" ->
        {"W", e, n}

      "W" ->
        {"S", e, n}

      "E" ->
        {"N", e, n}

      "S" ->
        {"E", e, n}
    end
  end

  defp next_position({dir, e, n}, {"R", 90}) do
    case dir do
      "N" ->
        {"E", e, n}

      "W" ->
        {"N", e, n}

      "E" ->
        {"S", e, n}

      "S" ->
        {"W", e, n}
    end
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

Day12Part1.run()
