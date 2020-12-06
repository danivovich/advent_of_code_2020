defmodule Part2 do
  def main do
    {:ok, contents} = File.read("input.txt")

    contents
    |> String.replace("\n\n", "-----")
    |> String.replace("\n", " ")
    |> String.replace("-----", "\n")
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      row
      |> String.split(" ", trim: true)
      |> Enum.map(fn fieldvalue ->
        [field, value] = String.split(fieldvalue, ":", trim: true)
        {field, value}
      end)
    end)
    |> Enum.filter(fn data ->
      row = Enum.map(data, fn {field, _value} -> field end)

      ["ecl", "pid", "eyr", "hcl", "byr", "iyr", "hgt"]
      |> Enum.all?(fn req ->
        Enum.any?(row, fn f -> f == req end)
      end)
    end)
    |> Enum.filter(fn data ->
      data
      |> Enum.all?(fn e -> valid?(e) end)
    end)
    |> length()
    |> IO.inspect()
  end

  def valid?({"byr", value}) do
    case Integer.parse(value) do
      :error ->
        false

      {v, _} ->
        v >= 1920 and v <= 2002
    end
  end

  def valid?({"iyr", value}) do
    case Integer.parse(value) do
      :error ->
        false

      {v, _} ->
        v >= 2010 and v <= 2020
    end
  end

  def valid?({"eyr", value}) do
    case Integer.parse(value) do
      :error ->
        false

      {v, _} ->
        v >= 2020 and v <= 2030
    end
  end

  def valid?({"pid", value}) do
    case Integer.parse(value) do
      :error ->
        false

      _ ->
        String.length(value) == 9
    end
  end

  def valid?({"hcl", value}) do
    String.match?(value, ~r/#[a-f0-9]{6}/)
  end

  def valid?({"hgt", value}) do
    case String.match?(value, ~r/cm/) do
      true ->
        value
        |> String.replace("cm", "")
        |> valid_cm()

      false ->
        case String.match?(value, ~r/in/) do
          true ->
            value
            |> String.replace("in", "")
            |> valid_in()

          false ->
            false
        end
    end
  end

  def valid?({"ecl", "amb"}), do: true
  def valid?({"ecl", "blu"}), do: true
  def valid?({"ecl", "brn"}), do: true
  def valid?({"ecl", "gry"}), do: true
  def valid?({"ecl", "grn"}), do: true
  def valid?({"ecl", "hzl"}), do: true
  def valid?({"ecl", "oth"}), do: true

  def valid?({"cid", _}), do: true

  def valid?(_), do: false

  def valid_cm(value) do
    case Integer.parse(value) do
      :error ->
        false

      {v, _} ->
        v >= 150 and v <= 193
    end
  end

  def valid_in(value) do
    case Integer.parse(value) do
      :error ->
        false

      {v, _} ->
        v >= 59 and v <= 76
    end
  end
end

Part2.main()
