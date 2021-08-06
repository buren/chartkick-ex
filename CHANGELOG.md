### HEAD

_No unreleased features..._

### 1.0.0-rc.0

* :warning: `json_serializer` must be specified since the dependency on `poison` has been removed
  ```
  # config.exs
  config :chartkick, json_serializer: Jason
  ```
  _Replace `Jason` with the encoder of your choice_. \
  [PR#28](https://github.com/buren/chartkick-ex/pull/28)
* Chart Options: `round` and `zeros` [PR#35](https://github.com/buren/chartkick-ex/pull/35)
* `thousands` wasn't correct with the code shown [PR#34](https://github.com/buren/chartkick-ex/pull/34)
* Replace `uuid` with `elixir_uuid` as it was renamed [PR#24](https://github.com/buren/chartkick-ex/pull/24)

### 0.4.0

* Support `Jason` serializer configuration option

### 0.3.0

* Support `defer` option [PR#8](https://github.com/buren/chartkick-ex/pull/8)
* Support `width` option [PR#7](https://github.com/buren/chartkick-ex/pull/7)

### 0.2.0

* Support all Chartkick chart options; adds
  - curve
  - dataset
  - decimal
  - donut
  - download
  - label
  - legend
  - library
  - messages
  - points
  - prefix
  - refresh
  - suffix
  - thousands
  - title
  - xtype

### 0.1.0

* See [PR#3](https://github.com/buren/chartkick-ex/pull/3) - Thank you @mbenatti and @nimish-mehta

### 0.0.2

* Removed defunct `ChartOptions` module.

### 0.0.1

Initial release.
