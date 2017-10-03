defmodule Chartkick do
  gen_chart_fn = fn (chart_type) ->
    def unquote(
      chart_type
      |> Macro.underscore
      |> String.to_atom
    )(data_source, options \\ []) do
      chartkick_chart(unquote(chart_type), data_source, options)
    end
  end

  Enum.map(
    ~w(LineChart PieChart BarChart AreaChart ColumnChart ComboChart GeoChart ScatterChart Timeline),
    gen_chart_fn
  )

  def chartkick_chart(klass, data_source, options \\ []) do
    id     = Keyword.get_lazy(options, :id, &UUID.uuid4/0)
    height = Keyword.get(options, :height, "300px")
    only   = Keyword.get(options, :only)
    case only do
      :html   -> chartkick_tag(id, height)
      :script -> chartkick_script(klass, id, data_source, options_json(options))
      _       -> """
                 #{ chartkick_tag(id, height) }
                 #{ chartkick_script(klass, id, data_source, options_json(options)) }
                 """
    end
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
