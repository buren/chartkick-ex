defmodule Chartkick do
  def line_chart(data_source, options \\ []) do
    chartkick_chart("LineChart", data_source, options)
  end

  def pie_chart(data_source, options \\ []) do
    chartkick_chart("PieChart", data_source, options)
  end

  def column_chart(data_source, options \\ []) do
    chartkick_chart("ColumnChart", data_source, options)
  end

  def bar_chart(data_source, options \\ []) do
    chartkick_chart("BarChart", data_source, options)
  end

  def area_chart(data_source, options \\ []) do
    chartkick_chart("AreaChart", data_source, options)
  end

  def combo_chart(data_source, options \\ []) do
    chartkick_chart("ComboChart", data_source, options)
  end

  def geo_chart(data_source, options \\ []) do
    chartkick_chart("GeoChart", data_source, options)
  end

  def scatter_chart(data_source, options \\ []) do
    chartkick_chart("ScatterChart", data_source, options)
  end

  def timeline(data_source, options \\ []) do
    chartkick_chart("Timeline", data_source, options)
  end

  def chartkick_chart(klass, data_source, options \\ []) do
    id     = options[:id] || generate_element_id()
    height = options[:height] || "300px"
    only   = options[:only]
    """
    #{unless only == :script, do: chartkick_tag(id, height)}
    #{unless only == :html, do: chartkick_script(klass, id, data_source, options_json(options))}
    """
  end

  def chartkick_script(klass, id, data_source, options_json) do
    "<script type=\"text/javascript\">new Chartkick.#{klass}('#{id}', #{data_source}, #{options_json});</script>"
  end

  def chartkick_tag(id, height) do
    "<div id=\"#{id}\" style=\"height: #{height}; text-align: center; color: #999; line-height: #{height}; font-size: 14px; font-family: 'Lucida Grande', 'Lucida Sans Unicode', Verdana, Arial, Helvetica, sans-serif;\">Loading...</div>"
  end

  defp generate_element_id do
    UUID.uuid4()
  end

  @options ~w(min max colors stacked discrete xtitle ytitle)a
  defp options_json(opts) do
    opts
    |> Keyword.take(@options)
    |> Enum.into(%{})
    |> Poison.encode!()
  end

end
