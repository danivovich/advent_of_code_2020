defmodule Part1 do
  def run do
    {:ok, contents} = File.read("input.txt")

    instructions =
      contents
      |> String.split("\n", trim: true)
      |> Enum.map(fn row ->
        parse_row(row)
      end)
      |> Stream.with_index(1)
      |> Enum.reduce(%{}, fn {v, k}, acc -> Map.put(acc, k, v) end)

    IO.inspect(instructions)

    run_program(instructions, 1, 0, [])
  end

  defp parse_row(row) do
    [command, arg] = String.split(row, " ", trim: true)
    {command, arg}
  end

  defp run_program(instructions, line, accumulator, visted) do
    {command, arg} = instructions[line]

    case Enum.member?(visted, line) do
      true ->
        IO.inspect(accumulator)

      false ->
        new_visted = visted ++ [line]

        case command do
          "nop" ->
            run_program(instructions, line + 1, accumulator, new_visted)

          "acc" ->
            run_program(instructions, line + 1, new_accumulator(accumulator, arg), new_visted)

          "jmp" ->
            run_program(instructions, new_line(line, arg), accumulator, new_visted)
        end
    end
  end

  defp new_accumulator(acc, "+" <> value) do
    {int, _} = Integer.parse(value)
    acc + int
  end

  defp new_accumulator(acc, "-" <> value) do
    {int, _} = Integer.parse(value)
    acc - int
  end

  defp new_line(line, "+" <> value) do
    {int, _} = Integer.parse(value)
    line + int
  end

  defp new_line(line, "-" <> value) do
    {int, _} = Integer.parse(value)
    line - int
  end
end

Part1.run()
