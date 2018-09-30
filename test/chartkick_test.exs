defmodule ChartkickTest do
  use ExUnit.Case

  test "pie_chart" do
    script = Chartkick.pie_chart("{}")
    expected = "new Chartkick.PieChart("
    assert String.contains?(script, expected)
  end

  test "column_chart" do
    script = Chartkick.column_chart("{}")
    expected = "new Chartkick.ColumnChart("
    assert String.contains?(script, expected)
  end

  test "bar_chart" do
    script = Chartkick.bar_chart("{}")
    expected = "new Chartkick.BarChart("
    assert String.contains?(script, expected)
  end

  test "area_chart" do
    script = Chartkick.area_chart("{}")
    expected = "new Chartkick.AreaChart("
    assert String.contains?(script, expected)
  end

  test "combo_chart" do
    script = Chartkick.combo_chart("{}")
    expected = "new Chartkick.ComboChart("
    assert String.contains?(script, expected)
  end

  test "geo_chart" do
    script = Chartkick.geo_chart("{}")
    expected = "new Chartkick.GeoChart("
    assert String.contains?(script, expected)
  end

  test "scatter_chart" do
    script = Chartkick.scatter_chart("{}")
    expected = "new Chartkick.ScatterChart("
    assert String.contains?(script, expected)
  end

  test "timeline" do
    script = Chartkick.timeline("{}")
    expected = "new Chartkick.Timeline("
    assert String.contains?(script, expected)
  end


  test "line_chart returns LineChart" do
    script = Chartkick.line_chart("{}")
    expected  = "new Chartkick.LineChart("
    assert String.contains?(script, expected)
  end

  test "chartkick_chart contains HTML-tag styling" do
    height = "42px"
    script = Chartkick.chartkick_chart("", "{}", height: height)
    expected = "style=\"width: 100%; height: #{height}; text-align: center; color: #999; line-height: #{height};"
    assert String.contains?(script, expected)
  end

  test "chartkick_chart returns with default height set" do
    script = Chartkick.chartkick_chart("", "{}")
    expected  = "height: 300px"
    assert String.contains?(script, expected)
  end

  test "chartkick_chart returns with custom height set" do
    script = Chartkick.chartkick_chart("", "{}", height: "400px")
    expected  = "height: 400px"
    assert String.contains?(script, expected)
  end

  test "chartkick_chart returns with custom width set" do
    script = Chartkick.chartkick_chart("", "{}", width: "99%")
    expected  = "width: 99%"
    assert String.contains?(script, expected)
  end

  test "chartkick_chart with only script option does not render html-tag" do
    script = Chartkick.chartkick_chart("", "{}", only: :script)
    expected = "</div>"
    assert !String.contains?(script, expected)
  end

  test "chartkick_chart with only html option does not render script-tag" do
    html = Chartkick.chartkick_chart("", "{}", only: :html)
    expected = "<script type=\"text/javascript\">"
    assert !String.contains?(html, expected)
  end

  test "chartkick_script contains script open tag" do
    script = Chartkick.chartkick_script("", "", "{}", "{}", false)
    expected = "<script type=\"text/javascript\">"
    assert String.contains?(script, expected)
  end

  test "chartkick_script ends with closing script tag" do
    script = Chartkick.chartkick_script("", "", "{}", "{}", false)
    expected = "</script>"
    assert String.ends_with?(script, expected)
  end

  test "chartkick_script defer adds event listener JS code" do
    script = Chartkick.chartkick_script("LineChart", "", "{}", "{}", true)
    expected = "window.addEventListener(\"load\", createChart, true);"
    assert String.contains?(script, expected)
  end

  test "chartkick_script defer adds createChart JS function" do
    script = Chartkick.chartkick_script("LineChart", "", "{}", "{}", true)
    expected = "var createChart = function() { new Chartkick.LineChart('', {}, {}); };"
    assert String.contains?(script, expected)
  end

  test "chartkick_script defer returns script with correct chart class" do
    script = Chartkick.chartkick_script("LineChart", "", "{}", "{}", true)
    expected = "new Chartkick.LineChart"
    assert String.contains?(script, expected)
  end

  test "chartkick_script returns script with correct chart class" do
    script = Chartkick.chartkick_script("LineChart", "", "{}", "{}", false)
    expected = "new Chartkick.LineChart"
    assert String.contains?(script, expected)
  end

  test "chartkick_script returns script with custom id set" do
    id = "my-chart-id"
    script = Chartkick.chartkick_script("klass", id, "{}", "{}", false)
    expected  = "new Chartkick.klass('#{id}"
    assert String.contains?(script, expected)
  end

  test "chartkick_chart with chart options" do
    script = Chartkick.chartkick_chart("", "{}", stacked: true, min: nil, legend: false)
    expected  = "{\"stacked\":true,\"min\":null,\"legend\":false}"
    assert String.contains?(script, expected)
  end

  test "chartkick_chart with chart defer option" do
    script = Chartkick.chartkick_chart("", "{}", defer: true)
    expected = "window.addEventListener(\"load\", createChart, true);"
    assert String.contains?(script, expected)
  end

  test "chartkick_chart with chart library option" do
    script = Chartkick.chartkick_chart("", "{}", library: %{ backgroundColor: "#eee" })
    expected  = "{\"library\":{\"backgroundColor\":\"#eee\"}}"
    assert String.contains?(script, expected)
  end
end
