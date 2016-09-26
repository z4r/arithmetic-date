import Foundation

func combineComponents(_ lhs: DateComponents, rhs: DateComponents, _ multiplier: Int = 1) -> DateComponents {
    var result = DateComponents()    
    result.second = (lhs.second ?? 0) + (rhs.second ?? 0) * multiplier
    result.minute = (lhs.minute ?? 0) + (rhs.minute ?? 0) * multiplier
    result.hour = (lhs.hour ?? 0) + (rhs.hour ?? 0) * multiplier
    result.day = (lhs.day ?? 0) + (rhs.day ?? 0) * multiplier
    result.month = (lhs.month ?? 0) + (rhs.month ?? 0) * multiplier
    result.year = (lhs.year ?? 0) + (rhs.year ?? 0) * multiplier
    return result
}

public func +(lhs: DateComponents, rhs: DateComponents) -> DateComponents {
    return combineComponents(lhs, rhs: rhs)
}

public func -(lhs: DateComponents, rhs: DateComponents) -> DateComponents {
    return combineComponents(lhs, rhs: rhs, -1)
}

prefix func -(components: DateComponents) -> DateComponents {
    var result = DateComponents()
    if let second = components.second { result.second = -second }
    if let minute = components.minute { result.minute = -minute }
    if let hour = components.hour { result.hour = -hour }
    if let day = components.day { result.day = -day }
    if let month = components.month { result.month = -month }
    if let year = components.year { result.year = -year }
    return result
}

public extension Int {
    var seconds: DateComponents {
        var components = DateComponents()
        components.second = self;
        return components
    }
    
    var minutes: DateComponents {
        var components = DateComponents()
        components.minute = self;
        return components
    }
    
    var hours: DateComponents {
        var components = DateComponents()
        components.hour = self;
        return components
    }
    
    var days: DateComponents {
        var components = DateComponents()
        components.day = self;
        return components
    }
    
    var weeks: DateComponents {
        var components = DateComponents()
        components.day = 7 * self;
        return components
    }
    
    var months: DateComponents {
        var components = DateComponents()
        components.month = self;
        return components
    }
    
    var years: DateComponents {
        var components = DateComponents()
        components.year = self;
        return components
    }
}

public func +(lhs: Date, rhs: DateComponents) -> Date {
    return Calendar.current.date(byAdding: rhs, to: lhs)!
}

public func +(lhs: DateComponents, rhs: Date) -> Date {
    return rhs + lhs
}

public func -(lhs: Date, rhs: DateComponents) -> Date {
    return lhs + (-rhs)
}

public protocol DateProvider {
    func now() -> Date
}

struct NSDateProvider: DateProvider {
    func now() -> Date {
        return Date()
    }
}

public extension DateComponents {
    func fromNow(_ date: DateProvider = NSDateProvider()) -> Date {
        return Calendar.current.date(byAdding: self, to: date.now())!
    }
    
    func ago(_ date: DateProvider = NSDateProvider()) -> Date {
        return Calendar.current.date(byAdding: -self, to: date.now())!
    }
}
