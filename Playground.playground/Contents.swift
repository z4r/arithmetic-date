import ArithmeticDate

let dateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "dd-MM-yy HH:mm:ss"
let date = dateFormatter.dateFromString("04-11-14 23:04:00")!

let delta: NSDateComponents = 1.years + 2.months + 3.days + 4.hours + 5.minutes + 6.seconds
let newDate = date + delta

1.years.fromNow()

2.days.ago()
