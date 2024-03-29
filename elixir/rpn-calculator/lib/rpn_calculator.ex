defmodule RPNCalculator do
  def calculate!(stack, operation) do
    try do
      operation.(stack)
    rescue
      _ -> raise "test error"
    end
  end

  def calculate(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      _ -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      _ -> {:error, "test error"}
    end
  end
end
