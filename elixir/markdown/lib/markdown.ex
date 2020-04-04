defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map_join(&parse_element/1)
    |> replace_list_tags()
  end

  defp parse_element(text) do
    cond do
      header?(text) ->
        parse_header(text)

      emphasis?(text) ->
        parse_list_md_level(text)

      true ->
        parse_normal_text(text)
    end
  end

  defp header?(string), do: String.starts_with?(string, "#")

  defp emphasis?(string), do: String.starts_with?(string, "*")

  defp parse_header(header) do
    header
    |> parse_header_md_level()
    |> enclose_with_header_tag()
  end

  defp parse_header_md_level(header_with_text) do
    [hashes, text] = String.split(header_with_text, " ", parts: 2)

    header_size =
      hashes
      |> String.length()
      |> to_string()

    {header_size, text}
  end

  defp enclose_with_header_tag({size, text}), do: "<h#{size}>#{text}</h#{size}>"

  defp parse_list_md_level(list) do
    tags =
      list
      |> String.trim_leading("* ")
      |> String.split()

    "<li>" <> join_words_with_tags(tags) <> "</li>"
  end

  defp join_words_with_tags(tags), do: Enum.map_join(tags, " ", &replace_md_with_tag/1)

  defp replace_md_with_tag(string) do
    string
    |> replace_prefix_md()
    |> replace_suffix_md()
  end

  defp replace_prefix_md(string) do
    cond do
      starting_strong_emphasis?(string) ->
        String.replace(string, ~r/^#{"__"}{1}/, "<strong>", global: false)

      starting_weak_emphasis?(string) ->
        String.replace(string, ~r/_/, "<em>", global: false)

      true ->
        string
    end
  end

  defp replace_suffix_md(string) do
    cond do
      ending_strong_emphasis?(string) -> String.replace(string, ~r/#{"__"}{1}$/, "</strong>")
      ending_weak_emphasis?(string) -> String.replace(string, ~r/_/, "</em>")
      true -> string
    end
  end

  defp starting_strong_emphasis?(string), do: String.starts_with?(string, "__")

  defp starting_weak_emphasis?(string), do: String.starts_with?(string, "_")

  defp ending_strong_emphasis?(string), do: String.ends_with?(string, "__")

  defp ending_weak_emphasis?(string), do: String.ends_with?(string, "_")

  defp parse_normal_text(string) do
    string
    |> String.split()
    |> enclose_with_paragraph_tag()
  end

  defp enclose_with_paragraph_tag(text), do: "<p>#{join_words_with_tags(text)}</p>"

  defp replace_list_tags(line) do
    line
    |> String.replace("<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end
