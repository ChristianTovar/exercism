defmodule FreelancerRates do
  @daily_hours 8.0
  @billable_days 22

  def daily_rate(hourly_rate), do: hourly_rate * @daily_hours

  def apply_discount(before_discount, discount),
    do: before_discount - before_discount * discount / 100

  def monthly_rate(hourly_rate, discount) do
    hourly_rate
    |> daily_rate()
    |> Kernel.*(@billable_days)
    |> apply_discount(discount)
    |> Float.ceil()
    |> Kernel.trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    hourly_rate
    |> monthly_rate(discount)
    |> then(fn monthly_rate -> Kernel./(budget, monthly_rate) end)
    |> Kernel.*(@billable_days)
    |> Float.floor(1)
  end
end
