# Chartkick [![Build Status](https://travis-ci.com/buren/chartkick-ex.svg?branch=master)](https://travis-ci.com/buren/chartkick-ex)

Create beautiful Javascript charts with one line of Elixir. No more fighting with charting libraries!

[See it in action](http://buren.github.io/chartkick-ex/), you can find the example phoenix app that generates that page [here](https://github.com/buren/chartkick-phoenix-example).

Works with Phoenix, plain Elixir and most browsers.

Any feedback, suggestions or comments please open an issue or PR.

## Charts

All charts expect a JSON string.

```elixir
data = Poison.encode!([[175, 60], [190, 80], [180, 75]])
```

Line chart

```elixir
Chartkick.line_chart data
```

Pie chart

```elixir
Chartkick.pie_chart data
```

Column chart

```elixir
Chartkick.column_chart data
```

Bar chart

```elixir
Chartkick.bar_chart data
```

Area chart

```elixir
Chartkick.area_chart data
```

Scatter chart

```elixir
Chartkick.scatter_chart data
```

Geo chart

```elixir
Chartkick.geo_chart Poison.encode!("[[\"United States\",44],[\"Germany\",23]]")
```

Timeline

```elixir
Chartkick.timeline "[
  [\"Washington\", \"1789-04-29\", \"1797-03-03\"],
  [\"Adams\", \"1797-03-03\", \"1801-03-03\"],
  [\"Jefferson\", \"1801-03-03\", \"1809-03-03\"]
]"
```

### Say Goodbye To Timeouts

Make your pages load super fast and stop worrying about timeouts. Give each chart its own endpoint.

```elixir
Chartkick.line_chart "/path/to/chart.json"
```

And respond with data as JSON.

### Options

:information_source: _This implementation aims to support all options that [chartkick.js](https://github.com/ankane/chartkick.js) supports. If there are any missing, please open an issue or a PR._

Id, width and height

```elixir
Chartkick.line_chart data, id: "users-chart", height: "500px", width: "50%"
```

Min and max values

```elixir
Chartkick.line_chart data, min: 1000, max: 5000
```

`min` defaults to 0 for charts with non-negative values. Use `nil` to let the charting library decide.

Colors

```elixir
Chartkick.line_chart data, colors: ["pink", "#999"]
```

Stacked columns or bars

```elixir
Chartkick.column_chart data, stacked: true
```

Discrete axis

```elixir
Chartkick.line_chart data, discrete: true
```

Axis titles

```elixir
Chartkick.line_chart data, xtitle: "Time", ytitle: "Population"
```

Straight lines between points instead of a curve

```elixir
Chartkick.line_chart data, curve: false
```

Hide points

```elixir
Chartkick.line_chart data, points: false
```

Show or hide legend

```elixir
Chartkick.line_chart data, legend: false
```

Specify legend position

```elixir
Chartkick.line_chart data, legend: "bottom"
```

Defer chart creation until after the page loads

```elixir
Chartkick.line_chart data, defer: true
```

Donut chart

```elixir
Chartkick.pie_chart data, donut: true
```

Prefix, useful for currency - _Chart.js, Highcharts_

```elixir
Chartkick.line_chart data, prefix: "$"
```

Suffix, useful for percentages - _Chart.js, Highcharts_

```elixir
Chartkick.line_chart data, suffix: "%"
```

Set a thousands separator - _Chart.js, Highcharts_

```elixir
Chartkick.line_chart data, decimal: ","
```

Show a message when data is empty

```elixir
Chartkick.line_chart data, messages: %{ empty: "My message.."}
```

Refresh data from a remote source every `n` seconds

```elixir
Chartkick.line_chart data, refresh: 60
```

You can pass options directly to the charting library with:

```elixir
Chartkick.line_chart data, library: %{ backgroundColor: "#eee" }
```

See the documentation for [Google Charts](https://developers.google.com/chart/interactive/docs/gallery) and [Highcharts](http://api.highcharts.com/highcharts) for more info.

To customize datasets in Chart.js, use:

```elixir
Chartkick.line_chart data, dataset: %{ borderWidth: 10 }
```

### Data

Pass data as a JSON string.

```elixir
Chartkick.pie_chart "{\"Football\" => 10, \"Basketball\" => 5}"
Chartkick.pie_chart "[[\"Football\", 10], [\"Basketball\", 5]]"
```

For multiple series, use the format

```elixir
Chartkick.line_chart "[
  {name: \"Series A\", data: []},
  {name: \"Series B\", data: []}
]"
```

Times can be a time, a timestamp, or a string (strings are parsed)

```elixir
Chartkick.line_chart "{
  1368174456 => 4,
  \"2013-05-07 00:00:00 UTC\" => 7
}"
```

## Installation

Add the following to your project :deps list:

```elixir
{:chartkick, "~>0.4.0"}
```

Optionally, you can set different JSON encoder, by default it's Poison.
It's used to encode options passed to Chartkick.
```
# config.exs
config :chartkick, json_serializer: Jason
```

By default when you render a chart it will return both the HTML-element and JS that initializes the chart.
This will only work if you load Chartkick in the `<head>` tag.
You can chose to render the JS & HTML separately using the `only: :html` or `only: :script` option.
Note that if you use those options you need to pass `id` otherwise it wont work.

```elixir
line_chart data, id: "my-line-chart", only: :html
line_chart data, id: "my-line-chart", only: :script
```

For Google Charts, use:

```html
<script src="//www.google.com/jsapi"></script>
<script src="path/to/chartkick.js"></script>
```

If you prefer Highcharts, use:

```html
<script src="/path/to/highcharts.js"></script>
<script src="path/to/chartkick.js"></script>
```

### Localization

To specify a language for Google Charts, add:

```html
<script>
  var Chartkick = {"language": "de"};
</script>
```

**before** the javascript files.

## No Elixir? No Problem

Check out

* [JavaScript](https://github.com/ankane/chartkick.js)
  - [React](https://github.com/yfractal/chartkick)
  - [Vue.js](https://github.com/yfractal/chartkick)
* [Ruby](https://github.com/ankane/chartkick)
* [Python](https://github.com/mher/chartkick.py)
* [Clojure](https://github.com/yfractal/chartkick)

## History

View the [changelog](https://github.com/buren/chartkick-ex/blob/master/CHANGELOG.md)

Chartkick follows [Semantic Versioning](http://semver.org/)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/buren/chartkick-ex/issues)
- Fix bugs and [submit pull requests](https://github.com/buren/chartkick-ex/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
