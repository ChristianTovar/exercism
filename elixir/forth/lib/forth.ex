defmodule Forth do
  import String, only: [to_integer: 1]

  @opaque evaluator :: map()
  @integer_arithmetic ~W(- + * /)
  @stack_manipulation ~W(DUP dup drop swap over)

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new(), do: %{}

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(ev, ":" <> _ = string) do
    ~r/:\s([^\s]+)\s(.+)\s;\s?([^\s]+)?/
    |> Regex.run(string, capture: :all_but_first)
    |> check_evaluation(ev)
  end

  def eval(ev, s) do
    s
    |> clean_string()
    |> replace_words(ev)
    |> String.split(" ", trim: true)
    |> Enum.map(&format/1)
    |> validate_juxtaposition()
  end

  defp check_evaluation([key, value, key], _ev), do: [value]

  defp check_evaluation([key, value], ev) when is_binary(key) do
    case key =~ ~r/\d/ do
      true -> raise(__MODULE__.InvalidWord)
      false -> Map.put(ev, key, value)
    end
  end

  defp clean_string(string),
    do: String.replace(string, ~r/[\x00|\x01\n\r \t]/, " ")

  defp replace_words(s, ev) when map_size(ev) > 0 do
    Enum.reduce(ev, "", fn {key, value}, _acc -> String.replace(s, compile_regex(key), value) end)
  end

  defp replace_words(s, _ev), do: s

  defp compile_regex(string), do: Regex.compile!(string)

  defp format(element) do
    case element =~ ~r/\d/ do
      true -> to_integer(element)
      false -> element
    end
  end

  defp validate_juxtaposition([_a, _b, _c, operator | _]) when operator in @integer_arithmetic,
    do: raise(__MODULE__.DivisionByZero)

  defp validate_juxtaposition([manipulation]) when manipulation in @stack_manipulation,
    do: raise(__MODULE__.StackUnderflow)

  defp validate_juxtaposition([_a, "swap"]), do: raise(__MODULE__.StackUnderflow)
  defp validate_juxtaposition([_a, "over"]), do: raise(__MODULE__.StackUnderflow)

  defp validate_juxtaposition([_a, manipulation]) when manipulation not in @stack_manipulation,
    do: raise(__MODULE__.UnknownWord)

  defp validate_juxtaposition(list), do: list

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack([]), do: ""
  def format_stack(s), do: process_stack(s)

  defp process_stack([a, b, "+" | tail]), do: process_stack([a + b | tail])
  defp process_stack([a, b, "-" | tail]), do: process_stack([a - b | tail])
  defp process_stack([a, b, "*" | tail]), do: process_stack([a * b | tail])
  defp process_stack([a, b, "/" | tail]), do: process_stack([div(a, b) | tail])
  defp process_stack([a, "DUP" | tail]), do: process_stack([a, a | tail])
  defp process_stack([a, "dup" | tail]), do: process_stack([a, a | tail])
  defp process_stack([a, b, "dup" | tail]), do: process_stack([a, b, b | tail])
  defp process_stack([a, b, "Dup" | tail]), do: process_stack([a, b, b | tail])
  defp process_stack([_a, "drop" | tail]), do: process_stack(tail)
  defp process_stack([a, _b, "drop" | tail]), do: process_stack([a | tail])
  defp process_stack([a, b, "swap" | tail]), do: process_stack([b, a | tail])
  defp process_stack([a, b, c, "swap" | tail]), do: process_stack([a, c, b | tail])
  defp process_stack([a, b, "over" | tail]), do: process_stack([a, b, a | tail])
  defp process_stack([a, b, c, "over" | tail]), do: process_stack([a, b, c, b | tail])
  defp process_stack(s), do: Enum.join(s, " ")

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
