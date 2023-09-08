import XCTest
import os
@testable import MobileNetV3Package

final class MobileNetV3PackageTests: XCTestCase {
    func testExample() {

        let logger = Logger()

        guard let url = Bundle.module.url(forResource: "bulldog", withExtension: "jpg") else {
            logger.error("Cannot access bulldog image")
            return
        }

        guard let data = try? Data(contentsOf: url) else {
            logger.error("Cannot create Data")
            return
        }

        guard let input = UIImage(data: data) else {
            logger.error("Cannot build UIImage from data")
            return
        }

        guard let model = MobileNetV3Package() else {
            logger.error("Cannot initialize the model")
            return
        }

        let (label, probability) = model.predict(input: input)
        XCTAssertEqual(label!, "French bulldog")
    }
}
