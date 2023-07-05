import XCTest
@testable import MobileNetV3Package

final class MobileNetV3PackageTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(MobileNetV3Package().predict(), 33.33)
    }
}
