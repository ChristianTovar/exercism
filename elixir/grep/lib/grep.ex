defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, [file]) do
    text = File.read!(file)

    matches =
      ".*#{pattern}.*"
      |> Regex.compile!()
      |> set_regular_expression(flags)
      |> Regex.scan(text)

    cond do
      print_line_numbers?(flags) ->
        matches
        |> Enum.map_join("\n", fn [match | _] -> print_lines(match, text) end)
        |> add_line_feed()

      print_file_name?(flags) ->
        unless Enum.empty?(matches), do: file <> "\n", else: ""

      true ->
        matches
        |> Enum.map_join("\n", fn [match | _] -> match end)
        |> add_line_feed()
    end
  end

  def grep(pattern, flags, [_file | _] = files) do
    files
    |> Enum.map(fn file -> output_per_file(pattern, flags, file) end)
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&String.replace(&1, ~r/^\n/, ""))
    |> Enum.join("\n")
    |> String.replace(~r/^\n/, "")
    |> add_line_feed()
  end

  defp print_lines(match, text) do
    text
    |> String.split("\n")
    |> Enum.find_index(&(&1 == match))
    |> Kernel.+(1)
    |> Integer.to_string()
    |> (&"#{&1}:#{match}").()
  end

  defp output_per_file(pattern, flags, file) do
    pattern
    |> grep(flags, [file])
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> reduce_output(flags, file)
  end

  defp reduce_output(matches, flags, file) do
    case print_file_name?(flags) do
      true -> Enum.join(matches, "\n")
      false -> Enum.reduce(matches, "", &"#{&2}\n#{file}:#{&1}")
    end
  end

  defp set_regular_expression(initial_regex, []) do
    source = Regex.source(initial_regex)

    Regex.compile!(".*#{source}.*")
  end

  defp set_regular_expression(initial_regex, flags),
    do: Enum.reduce(flags, initial_regex, &set_behaviour/2)

  defp set_behaviour(flag, regex) when flag in ~w(-n -l), do: regex

  defp set_behaviour("-i", regex) do
    source = Regex.source(regex)
    opts = Regex.opts(regex)

    Regex.compile!(source, opts <> "i")
  end

  defp set_behaviour("-x", regex) do
    opts = Regex.opts(regex)

    regex
    |> Regex.source()
    |> String.replace(".*", "")
    |> (&"^(#{&1})$").()
    |> Regex.compile!(opts <> "m")
  end

  defp set_behaviour("-v", regex) do
    regex
    |> Regex.source()
    |> String.replace(".*", "")
    |> (&"^((?!#{&1}).)*$").()
    |> Regex.compile!("m")
  end

  defp print_line_numbers?(flags), do: "-n" in flags

  defp print_file_name?(flags), do: "-l" in flags

  defp add_line_feed(""), do: ""
  defp add_line_feed(text), do: text <> "\n"
end
