defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception([]), do: %__MODULE__{message: "stack underflow occurred"}
    def exception(value), do: %__MODULE__{message: "stack underflow occurred, context: #{value}"}
  end

  def divide([]), do: raise(StackUnderflowError, "when dividing")
  def divide([_value]), do: raise(StackUnderflowError, "when dividing")
  def divide([0, _value]), do: raise(DivisionByZeroError)
  def divide([a, b]), do: div(b, a)
end
