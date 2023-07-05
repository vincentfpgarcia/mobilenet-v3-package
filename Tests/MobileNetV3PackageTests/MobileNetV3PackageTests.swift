import XCTest
@testable import MobileNetV3Package

func empty() -> UIImage? {
    let rect = CGRectMake(0, 0, 224, 224)
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(224, 224), false, 0.0)
    UIColor.white.set()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}


final class MobileNetV3PackageTests: XCTestCase {
    func testExample() {
        let input = empty()
        XCTAssertEqual(MobileNetV3Package().predict(input: input), 245)
    }
}
