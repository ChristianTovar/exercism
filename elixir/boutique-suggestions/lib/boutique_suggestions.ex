defmodule BoutiqueSuggestions do
  @max_price 100.00

  def get_combinations(tops, bottoms, options \\ []) do
    for %{base_color: top_color, price: top_price} = top <- tops,
        %{base_color: bottom_color, price: bottom_price} = bottom <- bottoms,
        top_color != bottom_color,
        top_price + bottom_price < Keyword.get(options, :maximum_price, @max_price),
        do: {top, bottom}
  end
end
