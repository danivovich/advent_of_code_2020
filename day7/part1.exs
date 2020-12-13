defmodule Part1 do
  def run do
    {:ok, contents} = File.read("sample.txt")

    rules =
      contents
      |> String.split("\n", trim: true)
      |> Enum.reduce(%{}, fn row, map ->
        row
        |> parse_row()
        |> Map.merge(map)
      end)

    collapsed_rules =
      rules
      |> Map.keys()
      |> Enum.reduce(%{}, fn container, map ->
        {:ok, content} = Map.fetch(rules, container)

        collapsed =
          Enum.reduce(content, [], fn bag, sum ->
            sum ++ collapse_rule(bag, rules)
          end)
          |> List.flatten()
          |> Enum.reject(fn x -> x == nil end)

        Map.put(map, container, collapsed)
      end)

    Enum.filter(Map.values(collapsed_rules), fn content ->
      Enum.any?(content, fn x -> x == "shiny gold" end)
    end)
    |> length
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
            %{"color" => color} = Regex.named_captures(~r/\d+ (?<color>.*) bag.*/, bag_desc)
            color
        end
      end)

    Map.put(%{}, container, clean_content)
  end

  defp collapse_rule(nil, _rules) do
    []
  end

  defp collapse_rule(bag, rules) do
    [bag, collapse_rule(rules[bag], rules)]
  end
end

Part1.run()
