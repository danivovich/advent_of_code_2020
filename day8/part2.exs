defmodule Part2 do
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

    Range.new(0, length(Map.keys(instructions)))
    |> Enum.each(fn i ->
      run_program(instructions, 1, 0, [], i)
    end)
  end

  defp parse_row(row) do
    [command, arg] = String.split(row, " ", trim: true)
    {command, arg}
  end

  defp run_program(instructions, line, accumulator, visted, change) do
    case instructions[line] do
      nil ->
        IO.inspect("END: ")
        IO.inspect(accumulator)

      {command, arg} ->
        case change do
          ^line ->
            run_line(swap_command(command), arg, instructions, line, accumulator, visted, change)

          _ ->
            run_line(command, arg, instructions, line, accumulator, visted, change)
        end
    end
  end

  defp run_line(command, arg, instructions, line, accumulator, visted, change) do
    case Enum.member?(visted, line) do
      true ->
        nil

      false ->
        new_visted = visted ++ [line]

        case command do
          "nop" ->
            run_program(instructions, line + 1, accumulator, new_visted, change)

          "acc" ->
            run_program(
              instructions,
              line + 1,
              new_accumulator(accumulator, arg),
              new_visted,
              change
            )

          "jmp" ->
            run_program(instructions, new_line(line, arg), accumulator, new_visted, change)
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

  defp swap_command("jmp") do
    "nop"
  end

  defp swap_command("nop") do
    "jmp"
  end

  defp swap_command(cmd) do
    cmd
  end
end

Part2.run()
