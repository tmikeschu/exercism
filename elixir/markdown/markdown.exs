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
  def parse(text) do
    text
    |> String.split("\n")
    |> Enum.map(&determine_tag/1)
    |> Enum.map(&wrap_text_with_tag/1)
    |> Enum.join()
    |> wrap_list_items
  end

  @spec determine_tag(String.t()) :: {String.t(), String.t()}
  defp determine_tag(text) do
    case String.first(text) do
      "#" -> parse_header_md_level(text)
      "*" -> parse_list_md_level(text)
      _ -> {"p", parse_emphasis_tags(String.split(text))}
    end
  end

  @spec parse_header_md_level(String.t()) :: {String.t(), String.t()}
  defp parse_header_md_level(header) do
    [tags | [text | _]] = String.split(header, " ", parts: 2)
    {"h#{String.length(tags)}", text}
  end

  @spec parse_list_md_level(String.t()) :: {String.t(), String.t()}
  defp parse_list_md_level(list_item) do
    list_item
    |> String.trim_leading("* ")
    |> String.split()
    |> parse_emphasis_tags
    |> (&{"li", &1}).()
  end

  @spec wrap_text_with_tag({String.t(), String.t()}) :: String.t()
  defp wrap_text_with_tag({tag, text}), do: "<#{tag}>#{text}</#{tag}>"

  @spec parse_emphasis_tags([String.t()]) :: String.t()
  defp parse_emphasis_tags(words) do
    words
    |> Enum.map(&parse_emphasis/1)
    |> Enum.join(" ")
  end

  defp parse_emphasis(word) do
    word
    |> String.replace_prefix("__", "<strong>")
    |> String.replace_suffix("__", "</strong>")
    |> String.replace_prefix("_", "<em>")
    |> String.replace_suffix("_", "</em>")
  end

  defp wrap_list_items(l) do
    l
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
