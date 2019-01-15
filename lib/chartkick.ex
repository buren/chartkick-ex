defmodule Chartkick do
  require EEx

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
    width  = Keyword.get(options, :width, "100%")
    only   = Keyword.get(options, :only)
    defer  = Keyword.get(options, :defer, false)
    case only do
      :html   -> chartkick_tag(id, height, width)
      :script -> chartkick_script(klass, id, data_source, options, defer)
      _       -> """
                 #{ chartkick_tag(id, height, width) }
                 #{ chartkick_script(klass, id, data_source, options, defer) }
                 """
    end
  end

  EEx.function_from_string(
    :def,
    :chartkick_script,
    ~s[<script type="text/javascript">
      <%= if defer do
          chartkick_defer_create_js(klass, id, data_source, options)
        else
          chartkick_create_js(klass, id, data_source, options)
        end
      %>
    </script>],
    ~w(klass id data_source options defer)a
  )

  EEx.function_from_string(
    :def,
    :chartkick_tag,
    ~s[<div id="<%= id %>" style="width: <%= width %>; height: <%= height %>; text-align: center; color: #999; line-height: <%= height %>; font-size: 14px; font-family: 'Lucida Grande', 'Lucida Sans Unicode', Verdana, Arial, Helvetica, sans-serif;">Loading...</div>],
    ~w(id height width)a
  )

  EEx.function_from_string(
    :def,
    :chartkick_create_js,
    ~s[new Chartkick.<%= klass %>('<%= id %>', <%= data_source %>, <%= options_json(options) %>);],
    ~w(klass id data_source options)a
  )

  EEx.function_from_string(
    :def,
    :chartkick_defer_create_js,
    ~s[
      (function() {
        var createChart = function() { <%= chartkick_create_js(klass, id, data_source, options) %> };
        if (window.addEventListener) {
          window.addEventListener("load", createChart, true);
        } else if (window.attachEvent) {
          window.attachEvent("onload", createChart);
        } else {
          createChart();
        }
      })();
    ],
    ~w(klass id data_source options)a
  )

  @options ~w(colors curve dataset decimal discrete donut download label legend library max messages min points prefix refresh stacked suffix thousands title xtitle xtype ytitle)a
  defp options_json(opts) when is_list(opts) do
    opts
    |> Keyword.take(@options)
    |> Enum.into(%{})
    |> Poison.encode!()
  end

  defp options_json(opts) when is_bitstring(opts) do
    opts
  end
end
