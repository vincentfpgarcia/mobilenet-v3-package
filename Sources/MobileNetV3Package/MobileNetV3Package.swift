import CoreML
import Foundation
import UIKit

public struct MobileNetV3Package {
    
    private var model: MobileNetV3Model? = nil
    
    public init() {
        if let url = Bundle.module.url(forResource: "MobileNetV3Model", withExtension: "mlmodelc") {
            self.model = try! MobileNetV3Model(contentsOf: url, configuration: MLModelConfiguration())
        }
    }
    
    public func predict(input: UIImage?) -> String? {
        
        // Convert the UIImage into a CGImage
        guard let cgImage = input?.cgImage else {
            return nil
        }
        
        // Create the model input
        guard let modelInput = try? MobileNetV3ModelInput(my_inputWith: cgImage) else {
            return nil
        }
        
        // Inference
        guard let modelOutput = try? model!.prediction(input: modelInput).my_output else {
            return nil
        }

        // Argmax computation
        var max_val = -1000.0
        var max_arg = -1
        for i in 0..<1000 {
            let val = Double(truncating: modelOutput[i])
            if val > max_val {
                max_val = val
                max_arg = i
            }
        }

        // Return the label of the most probable class
        return labels[max_arg]
    }
}
