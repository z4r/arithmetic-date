# ArithmeticDate

[![Build Status](https://travis-ci.org/z4r/arithmetic-date.svg?branch=master)](https://travis-ci.org/z4r/arithmetic-date)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![swiftyness](https://img.shields.io/badge/pure-swift-ff3f26.svg?style=flat)](https://swift.org/)

This framework helps with Arithmetic date manipulation using `Date` and `DateComponents`:

## Installation

ArithmeticDate is compatible with [Carthage](http://github.com/Carthage/Carthage).
Just add this to your Cartfile:

```ruby
github "z4r/arithmetic-date"
```

## Examples

```Swift
import ArithmeticDate

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "dd-MM-yy HH:mm:ss"
let date = dateFormatter.date(from: "04-11-14 23:04:00")!

let delta: DateComponents = 1.years + 2.months + 3.days + 4.hours + 5.minutes + 6.seconds
let newDate = date + delta

1.years.fromNow()

2.days.ago()
```

## License

This project is distributed under an Apache 2.0 license. See the LICENSE file
for details.
