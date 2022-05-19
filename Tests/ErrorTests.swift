import XCTest
@testable import FlightPrices

final class ErrorTests: XCTestCase {

    func testError1() {
        let error = Test1.error1() as NSError

        XCTAssertEqual(error.domain, "Tests.Test1")
        XCTAssertEqual(error.code, 999)
        XCTAssertEqual(error.userInfo["nserror-name"] as? String, "error1")
        XCTAssertEqual(error.userInfo["nserror-info"] as? String, "()")
    }

    func testError2() {
        let error = Test1.error2(testParam: 1) as NSError

        XCTAssertEqual(error.domain, "Tests.Test1")
        XCTAssertEqual(error.code, 999)
        XCTAssertEqual(error.userInfo["nserror-name"] as? String, "error2")
        XCTAssertEqual(error.userInfo["nserror-info"] as? String, "(testParam: 1)")
    }

    func testError3() {
        let error = Test2.error3(testParam1: 1, testParam2: 2) as NSError

        XCTAssertEqual(error.domain, "Tests.Test2")
        XCTAssertEqual(error.code, 0)
        XCTAssertEqual(error.userInfo["nserror-name"] as? String, "error3")
        XCTAssertEqual(error.userInfo["nserror-info"] as? String, "(testParam1: 1, testParam2: 2)")
    }
}

enum Test1: EnumError {
    case error1(Void = ())
    case error2(testParam: Int)

    var errorCode: Int { return 999 }
}

enum Test2: EnumError {
    case error3(testParam1: Int, testParam2: Int)
}
