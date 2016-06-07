import Foundation

func combineComponents(lhs: NSDateComponents, rhs: NSDateComponents, _ multiplier: Int = 1) -> NSDateComponents {
    let result = NSDateComponents()
    let undefined = Int(NSDateComponentUndefined)
    
    result.second = ((lhs.second != undefined ? lhs.second : 0) + (rhs.second != undefined ? rhs.second : 0) * multiplier)
    result.minute = ((lhs.minute != undefined ? lhs.minute : 0) + (rhs.minute != undefined ? rhs.minute : 0) * multiplier)
    result.hour = ((lhs.hour != undefined ? lhs.hour : 0) + (rhs.hour != undefined ? rhs.hour : 0) * multiplier)
    result.day = ((lhs.day != undefined ? lhs.day : 0) + (rhs.day != undefined ? rhs.day : 0) * multiplier)
    result.month = ((lhs.month != undefined ? lhs.month : 0) + (rhs.month != undefined ? rhs.month : 0) * multiplier)
    result.year = ((lhs.year != undefined ? lhs.year : 0) + (rhs.year != undefined ? rhs.year : 0) * multiplier)
    return result
}

public func +(lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
    return combineComponents(lhs, rhs: rhs)
}

public func -(lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
    return combineComponents(lhs, rhs: rhs, -1)
}

prefix func -(components: NSDateComponents) -> NSDateComponents {
    let result = NSDateComponents()
    let undefined = Int(NSDateComponentUndefined)
    if(components.second != undefined) { result.second = -components.second }
    if(components.minute != undefined) { result.minute = -components.minute }
    if(components.hour != undefined) { result.hour = -components.hour }
    if(components.day != undefined) { result.day = -components.day }
    if(components.month != undefined) { result.month = -components.month }
    if(components.year != undefined) { result.year = -components.year }
    return result
}

public extension Int {
    var seconds: NSDateComponents {
        let components = NSDateComponents()
        components.second = self;
        return components
    }
    
    var minutes: NSDateComponents {
        let components = NSDateComponents()
        components.minute = self;
        return components
    }
    
    var hours: NSDateComponents {
        let components = NSDateComponents()
        components.hour = self;
        return components
    }
    
    var days: NSDateComponents {
        let components = NSDateComponents()
        components.day = self;
        return components
    }
    
    var weeks: NSDateComponents {
        let components = NSDateComponents()
        components.day = 7 * self;
        return components
    }
    
    var months: NSDateComponents {
        let components = NSDateComponents()
        components.month = self;
        return components
    }
    
    var years: NSDateComponents {
        let components = NSDateComponents()
        components.year = self;
        return components
    }
}

public func +(lhs: NSDate, rhs: NSDateComponents) -> NSDate {
    return NSCalendar.currentCalendar().dateByAddingComponents(rhs, toDate: lhs, options: [])!
}

public func +(lhs: NSDateComponents, rhs: NSDate) -> NSDate {
    return rhs + lhs
}

public func -(lhs: NSDate, rhs: NSDateComponents) -> NSDate {
    return lhs + (-rhs)
}

public protocol DateProvider {
    func now() -> NSDate
}

struct NSDateProvider: DateProvider {
    func now() -> NSDate {
        return NSDate()
    }
}

public extension NSDateComponents {
    func fromNow(date: DateProvider = NSDateProvider()) -> NSDate {
        let currentCalendar = NSCalendar.currentCalendar()
        return currentCalendar.dateByAddingComponents(self, toDate: date.now(), options: [])!
    }
    
    func ago(date: DateProvider = NSDateProvider()) -> NSDate {
        let currentCalendar = NSCalendar.currentCalendar()
        return currentCalendar.dateByAddingComponents(-self, toDate: date.now(), options: [])!
    }
}

public func < (lhs : NSDate, rhs : NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

public func == (lhs : NSDate, rhs : NSDate) -> Bool {
    return lhs.isEqualToDate(rhs)
}

extension NSDate : Comparable {}
