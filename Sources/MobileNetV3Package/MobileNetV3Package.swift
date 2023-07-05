import Foundation

public struct MobileNetV3Package {

    public init() {
    }

    public func predict() -> Int {
        Thread.sleep(until: Date().addingTimeInterval(0.01))
        return 245
    }
}
