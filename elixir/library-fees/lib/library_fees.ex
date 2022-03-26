defmodule LibraryFees do
  @one_day 86400

  def datetime_from_string(string) do
    {:ok, date} = NaiveDateTime.from_iso8601(string)

    date
  end

  def before_noon?(%NaiveDateTime{hour: hour}) when hour < 12, do: true
  def before_noon?(_date), do: false

  def return_date(checkout_datetime) do
    addition = if before_noon?(checkout_datetime), do: 28, else: 29

    checkout_datetime
    |> NaiveDateTime.add(addition * @one_day)
    |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    diff = Date.diff(actual_return_datetime, planned_return_date)
    if diff < 0, do: 0, else: diff
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    |> Kernel.==(1)
  end

  def calculate_late_fee(checkout, return, rate) do
    {:ok, checkout_datetime} = NaiveDateTime.from_iso8601(checkout)
    {:ok, return_datetime} = NaiveDateTime.from_iso8601(return)

    days = days_late(checkout_datetime, return_datetime)

    cond do
      days == 29 and before_noon?(checkout_datetime) -> rate
      days == 30 -> rate
      days > 30 and monday?(return_datetime) -> trunc(0.5 * (rate * (days - 28)))
      days > 30 -> rate * (days - 28)
      true -> 0
    end
  end
end
