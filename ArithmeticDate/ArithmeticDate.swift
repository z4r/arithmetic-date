import Foundation

enum NSDateComponentsOperation {
    case Sum
    case Sub
    
    func accept(lhs: Int, rhs: Int) -> Int {
        let undefined = Int(NSDateComponentUndefined)
        let multiplier: Int
        switch self {
            case Sum: multiplier = 1
            case Sub: multiplier = -1
        }
        
        return (lhs != undefined ? lhs : 0) + (rhs != undefined ? rhs : 0) * multiplier
    }
}

func combineComponents(lhs: NSDateComponents, rhs: NSDateComponents, op: NSDateComponentsOperation) -> NSDateComponents {
    let result = NSDateComponents()
    
    result.second = op.accept(lhs.second, rhs: rhs.second)
    result.minute = op.accept(lhs.minute, rhs: rhs.minute)
    result.hour = op.accept(lhs.hour, rhs: rhs.hour)
    result.day = op.accept(lhs.day, rhs: rhs.day)
    result.month = op.accept(lhs.month, rhs: rhs.month)
    result.year = op.accept(lhs.year, rhs: rhs.year)
    result.second = op.accept(lhs.second, rhs: rhs.second)

    return result
}

public func +(lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
    return combineComponents(lhs, rhs: rhs, op: .Sum)
}

public func -(lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
    return combineComponents(lhs, rhs: rhs, op: .Sub)
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

public extension NSDateComponents {
    var fromNow: NSDate {
        let currentCalendar = NSCalendar.currentCalendar()
        return currentCalendar.dateByAddingComponents(self, toDate: NSDate(), options: [])!
    }
    
    var ago: NSDate {
        let currentCalendar = NSCalendar.currentCalendar()
        return currentCalendar.dateByAddingComponents(-self, toDate: NSDate(), options: [])!
    }
}

public func < (lhs : NSDate, rhs : NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

public func == (lhs : NSDate, rhs : NSDate) -> Bool {
    return lhs.isEqualToDate(rhs)
}

extension NSDate : Comparable {}
