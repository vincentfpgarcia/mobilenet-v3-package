public struct MobileNetV3Package {

    public init() {
    }

    public func predict() -> Float{
        Task {
            try? await Task.sleep(nanoseconds: 10_000_000)
        }
        return 33.33
    }
}
