defmodule Chartkick do
  require EEx

  gen_chart_fn = fn chart_type ->
    def unquote(
          chart_type
          |> Macro.underscore()
          |> String.to_atom()
        )(
          data_source,
          options \\ []
        ) do
      chartkick_chart(unquote(chart_type), data_source, options)
    end
  end

  Enum.map(
    ~w(LineChart PieChart BarChart AreaChart ColumnChart ComboChart GeoChart ScatterChart Timeline),
    gen_chart_fn
  )

  def chartkick_chart(klass, data_source, options \\ []) do
    id = Keyword.get_lazy(options, :id, &generate_id_for_chart/0)
    height = Keyword.get(options, :height, "300px")
    width = Keyword.get(options, :width, "100%")
    only = Keyword.get(options, :only)

    case only do
      :html ->
        chartkick_tag(id, height, width)

      :script ->
        chartkick_script(klass, id, data_source, options)

      _ ->
        """
        #{chartkick_tag(id, height, width)}
        #{chartkick_script(klass, id, data_source, options)}
        """
    end
  end

  defp generate_id_for_chart do
    length = 36
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

  EEx.function_from_string(
    :def,
    :chartkick_script,
    ~s[<script type="text/javascript">
        (function() {
          function createChart() {
            <%= chartkick_create_js(klass, id, data_source, options) %>
          }

          if ("Chartkick" in window) {
            createChart();
          } else {
            window.addEventListener("chartkick:load", createChart, true);
          }
        })();
    </script>],
    ~w(klass id data_source options)a
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

  @options ~w(colors curve dataset decimal discrete donut download label legend library max messages min points prefix refresh stacked suffix thousands title xtitle xtype ytitle zeros round)a
  defp options_json(opts) when is_list(opts) do
    opts
    |> Keyword.take(@options)
    |> Enum.into(%{})
    |> json_serializer().encode!()
  end

  defp options_json(opts) when is_bitstring(opts) do
    opts
  end

  defp json_serializer do
    Application.get_env(:chartkick, :json_serializer) ||
      raise """
      We could not find any JSON serializer configured. You can add this
      configuration on your config file

        config :chartkick, json_serializer: <JsonSerializer>

      Choose your prefered json serializer and add it
      """
  end
end
