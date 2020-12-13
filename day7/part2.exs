defmodule Part2 do
  def run do
    {:ok, contents} = File.read("input.txt")

    rules =
      contents
      |> String.split("\n", trim: true)
      |> Enum.reduce(%{}, fn row, map ->
        row
        |> parse_row()
        |> Map.merge(map)
      end)

    (count(rules["shiny gold"], rules) - 1)
    |> IO.inspect()
  end

  defp parse_row(row) do
    %{"container" => container, "content" => content} =
      Regex.named_captures(~r/^(?<container>.*) bags contain (?<content>.*)\.$/, row)

    clean_content =
      content
      |> String.split(",", trim: true)
      |> Enum.map(fn desc ->
        case desc do
          "no other bags" ->
            nil

          bag_desc ->
            %{"color" => color, "count" => count} =
              Regex.named_captures(~r/(?<count>\d+) (?<color>.*) bag.*/, bag_desc)

            {int_count, _} = Integer.parse(count)

            {int_count, color}
        end
      end)

    Map.put(%{}, container, clean_content)
  end

  defp count([], _rules) do
    1
  end

  defp count(nil, _rules) do
    0
  end

  defp count([nil], _rules) do
    1
  end

  defp count({count, color}, rules) do
    count * count(rules[color], rules)
  end

  defp count([bag | remaining], rules) do
    {count, color} = bag
    count * count(rules[color], rules) + count(remaining, rules)
  end
end

Part2.run()
