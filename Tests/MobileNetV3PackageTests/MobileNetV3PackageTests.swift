import XCTest
@testable import MobileNetV3Package


func createDummyUIImage() -> UIImage? {
    let size = CGFloat(224)
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), true, 0.0)
    UIColor.white.set()
    let rect = CGRectMake(0, 0, size, size)
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}


final class MobileNetV3PackageTests: XCTestCase {
    func testExample() {
        let input = createDummyUIImage()
        XCTAssertGreaterThan(MobileNetV3Package().predict(input: input)!, -1)
    }
}
