import XCTest
@testable import ArithmeticDate

class IntExtensionTests: XCTestCase {
    func testIntExtensionSecond() {
        var expected = DateComponents()
        expected.second = 1
        XCTAssertEqual(1.seconds, expected)
    }
    
    func testIntExtensionMinute() {
        var expected = DateComponents()
        expected.minute = 1
        XCTAssertEqual(1.minutes, expected)
    }
    
    func testIntExtensionHour() {
        var expected = DateComponents()
        expected.hour = 1
        XCTAssertEqual(1.hours, expected)
    }
    
    func testIntExtensionDay() {
        var expected = DateComponents()
        expected.day = 1
        XCTAssertEqual(1.days, expected)
    }
    
    func testIntExtensionMonth() {
        var expected = DateComponents()
        expected.month = 1
        XCTAssertEqual(1.months, expected)
    }
    
    func testIntExtensionYear() {
        var expected = DateComponents()
        expected.year = 1
        XCTAssertEqual(1.years, expected)
    }
}

class ArithmeticDateComponentsTests: XCTestCase {
    var lhs: DateComponents!
    var rhs: DateComponents!
    
    override func setUp() {
        self.lhs = DateComponents()
        self.lhs.second = 1
        self.lhs.minute = 1
        self.lhs.hour = 1
        self.lhs.day = 1
        self.lhs.month = 1
        self.lhs.year = 1
        
        self.rhs = DateComponents()
        self.rhs.second = 2
        self.rhs.minute = 2
        self.rhs.hour = 2
        self.rhs.day = 2
        self.rhs.month = 2
        self.rhs.year = 2
    }
    
    func testInline() {
        let got: DateComponents = 2.seconds + 2.minutes + 2.hours + 2.days + 2.months + 2.years
        XCTAssertEqual(got, self.rhs)
    }
    
    func testCombineSum() {
        let got = combineComponents(self.lhs, rhs: self.rhs)
        XCTAssertEqual(got.second, 3)
        XCTAssertEqual(got.minute, 3)
        XCTAssertEqual(got.hour, 3)
        XCTAssertEqual(got.day, 3)
        XCTAssertEqual(got.month, 3)
        XCTAssertEqual(got.year, 3)
    }
    
    func testCombineSub() {
        let got = combineComponents(self.lhs, rhs: self.rhs, -1)
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
    let dateFormatter = DateFormatter()
    var date: Date!
    var delta: DateComponents!
    
    override func setUp() {
        self.dateFormatter.dateFormat = "dd-MM-yy HH:mm:ss"
        self.date = self.dateFormatter.date(from: "04-11-14 23:04:00")!
        
        self.delta = DateComponents()
        self.delta.second = 1
        self.delta.minute = 1
        self.delta.hour = 1
        self.delta.day = 1
        self.delta.month = 1
        self.delta.year = 1
    }
    
    func testDateSum() {
        let got = self.date + self.delta
        XCTAssertEqual(self.dateFormatter.string(from: got), "06-12-15 00:05:01")
    }
    
    func testDateSumCommutative() {
        let got = self.delta + self.date
        XCTAssertEqual(self.dateFormatter.string(from: got), "06-12-15 00:05:01")
    }
    
    func testDateSub() {
        let got = self.date - delta
        XCTAssertEqual(self.dateFormatter.string(from: got), "03-10-13 22:02:59")
    }
    
    func testLT() {
        let sum = self.date + self.delta
        let sub = self.date - self.delta
        
        XCTAssert(sum > self.date)
        XCTAssert(sub < self.date)
        XCTAssert(sub < sum)
        XCTAssert(self.date <= self.date)
        XCTAssert(self.date >= self.date)
        XCTAssertEqual(self.date, self.date)
        XCTAssertNotEqual(self.date, sum)
        XCTAssertNotEqual(self.date, sub)
    }
}

struct TestDateProvider: DateProvider {
    let date: Date
    func now() -> Date {
        return date
    }
}

class DateProviderTests: XCTestCase {
    let dateFormatter = DateFormatter()
    var provider: TestDateProvider!
    var delta: DateComponents!
    
    override func setUp() {
        self.dateFormatter.dateFormat = "dd-MM-yy HH:mm:ss"
        let date = self.dateFormatter.date(from: "04-11-14 23:04:00")!
        self.provider = TestDateProvider(date: date)
        
        self.delta = DateComponents()
        self.delta.second = 1
        self.delta.minute = 1
        self.delta.hour = 1
        self.delta.day = 1
        self.delta.month = 1
        self.delta.year = 1
    }
    
    func testAgo() {
        let got = delta.ago(self.provider)
        XCTAssertEqual(self.dateFormatter.string(from: got), "03-10-13 22:02:59")
    }
    
    func testFromNow() {
        let got = delta.fromNow(self.provider)
        XCTAssertEqual(self.dateFormatter.string(from: got), "06-12-15 00:05:01")
    }
}
