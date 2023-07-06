import CoreML
import Foundation
import UIKit

public struct MobileNetV3Package {
    
    private var model: MLModel? = nil
    
    public init() {
        if let url = Bundle.module.url(forResource: "Foo", withExtension: "mlmodelc") {
            self.model = try! MLModel(contentsOf: url, configuration: MLModelConfiguration())
        }
    }
    
    public func predict(input: UIImage?) -> Int? {
        
        // Convert the UIImage into a CGImage
        guard let cgImage = input?.cgImage else {
            return nil
        }
        
        // Create the model input
        let modelInput = try! FooInput(my_inputWith: cgImage)
        
        // Inference options
        let options = MLPredictionOptions()
        
        // Inference
        let modelOutput = try! model?.prediction(from: modelInput, options: options)
        let output = FooOutput(features: modelOutput!).my_output

        // Argmax computation
        var max_val = -1000.0
        var max_arg = -1
        for i in 0..<1000 {
            let val = Double(truncating: output[i])
            if val > max_val {
                max_val = val
                max_arg = i
            }
        }
        
        return Int(max_arg)
    }
}
