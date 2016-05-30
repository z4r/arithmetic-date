import XCTest
@testable import ArithmeticDate

class IntExtensionTests: XCTestCase {
    func testIntExtensionSecond() {
        let expected = NSDateComponents()
        expected.second = 1
        XCTAssertEqual(1.seconds, expected)
    }
    
    func testIntExtensionMinute() {
        let expected = NSDateComponents()
        expected.minute = 1
        XCTAssertEqual(1.minutes, expected)
    }
    
    func testIntExtensionHour() {
        let expected = NSDateComponents()
        expected.hour = 1
        XCTAssertEqual(1.hours, expected)
    }
    
    func testIntExtensionDay() {
        let expected = NSDateComponents()
        expected.day = 1
        XCTAssertEqual(1.days, expected)
    }
    
    func testIntExtensionMonth() {
        let expected = NSDateComponents()
        expected.month = 1
        XCTAssertEqual(1.months, expected)
    }
    
    func testIntExtensionYear() {
        let expected = NSDateComponents()
        expected.year = 1
        XCTAssertEqual(1.years, expected)
    }
}

class ArithmeticDateComponentsTests: XCTestCase {
    var lhs: NSDateComponents!
    var rhs: NSDateComponents!
    
    override func setUp() {
        self.lhs = NSDateComponents()
        self.lhs.second = 1
        self.lhs.minute = 1
        self.lhs.hour = 1
        self.lhs.day = 1
        self.lhs.month = 1
        self.lhs.year = 1
        
        self.rhs = NSDateComponents()
        self.rhs.second = 2
        self.rhs.minute = 2
        self.rhs.hour = 2
        self.rhs.day = 2
        self.rhs.month = 2
        self.rhs.year = 2
    }
    
    func testCombineSum() {
        let got = combineComponents(self.lhs, rhs: self.rhs, op: .Sum)
        XCTAssertEqual(got.second, 3)
        XCTAssertEqual(got.minute, 3)
        XCTAssertEqual(got.hour, 3)
        XCTAssertEqual(got.day, 3)
        XCTAssertEqual(got.month, 3)
        XCTAssertEqual(got.year, 3)
    }
    
    func testCombineSub() {
        let got = combineComponents(self.lhs, rhs: self.rhs, op: .Sub)
        XCTAssertEqual(got.second, -1)
        XCTAssertEqual(got.minute, -1)
        XCTAssertEqual(got.hour, -1)
        XCTAssertEqual(got.day, -1)
        XCTAssertEqual(got.month, -1)
        XCTAssertEqual(got.year, -1)
    }
    
    func testSum() {
        let got = self.lhs + self.rhs
        XCTAssertEqual(got.second, 3)
        XCTAssertEqual(got.minute, 3)
        XCTAssertEqual(got.hour, 3)
        XCTAssertEqual(got.day, 3)
        XCTAssertEqual(got.month, 3)
        XCTAssertEqual(got.year, 3)
    }
    
    func testSumCommutative() {
        let got = self.rhs + self.lhs
        XCTAssertEqual(got.second, 3)
        XCTAssertEqual(got.minute, 3)
        XCTAssertEqual(got.hour, 3)
        XCTAssertEqual(got.day, 3)
        XCTAssertEqual(got.month, 3)
        XCTAssertEqual(got.year, 3)
    }
    
    func testSub() {
        let got = self.lhs - self.rhs
        XCTAssertEqual(got.second, -1)
        XCTAssertEqual(got.minute, -1)
        XCTAssertEqual(got.hour, -1)
        XCTAssertEqual(got.day, -1)
        XCTAssertEqual(got.month, -1)
        XCTAssertEqual(got.year, -1)
    }
    
    func testSubInverse() {
        let got = self.rhs - self.lhs
        XCTAssertEqual(got.second, 1)
        XCTAssertEqual(got.minute, 1)
        XCTAssertEqual(got.hour, 1)
        XCTAssertEqual(got.day, 1)
        XCTAssertEqual(got.month, 1)
        XCTAssertEqual(got.year, 1)
    }
    
    func testInverse() {
        let got = -self.rhs
        XCTAssertEqual(got.second, -2)
        XCTAssertEqual(got.minute, -2)
        XCTAssertEqual(got.hour, -2)
        XCTAssertEqual(got.day, -2)
        XCTAssertEqual(got.month, -2)
        XCTAssertEqual(got.year, -2)
    }
}

class ArithmeticDateTests: XCTestCase {
    var date: NSDate!
    var delta: NSDateComponents!
    
    override func setUp() {
        self.date = NSDate(timeIntervalSince1970: 1464604716)
        
        self.delta = NSDateComponents()
        self.delta.second = 2
        self.delta.minute = 2
        self.delta.hour = 2
        self.delta.day = 2
        self.delta.month = 2
        self.delta.year = 2
    }
    
    func testDateSum() {
        let got = self.date + self.delta
        XCTAssertEqual(got.timeIntervalSince1970, 1533127238)
    }
    
    func testDateSumCommutative() {
        let got = self.delta + self.date
        XCTAssertEqual(got.timeIntervalSince1970, 1533127238)
    }
    
    func testDateSub() {
        let got = self.date - self.delta
        XCTAssertEqual(got.timeIntervalSince1970, 1, NSCalendar.currentCalendar().calendarIdentifier)
    }
    
    func lt() {
        let date = NSDate(timeIntervalSince1970: 1464604716)
        let sum = self.date + self.delta
        let sub = self.date - self.delta
        
        XCTAssert(sum > self.date)
        XCTAssert(sub < self.date)
        XCTAssert(sub < sum)
        XCTAssert(date <= self.date)
        XCTAssert(date >= self.date)
        XCTAssertEqual(self.date, date)
        XCTAssertNotEqual(self.date, sum)
        XCTAssertNotEqual(self.date, sub)
    }
}

