defmodule Part1 do
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

    Enum.count(Map.keys(rules), fn bag ->
      can_hold(rules[bag], rules)
    end)
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

  defp can_hold([nil], _rules) do
    false
  end

  defp can_hold([], _rules) do
    false
  end

  defp can_hold(["shiny gold" | _bags], _rules) do
    true
  end

  defp can_hold([bag | bags], rules) do
    can_hold(bags, rules) || can_hold(rules[bag], rules)
  end
end

Part1.run()
