import CoreML
import Foundation
import UIKit
import os

public struct MobileNetV3Package {
    
    private var model: MobileNetV3Model? = nil
    
    public init() {
        if let url = Bundle.module.url(forResource: "MobileNetV3Model", withExtension: "mlmodelc") {
            self.model = try! MobileNetV3Model(contentsOf: url, configuration: MLModelConfiguration())
        }
    }
    
    public func predict(input: UIImage?) -> String? {

        let logger = Logger()
        
        // Convert the UIImage into a CGImage
        guard let cgImage = input?.cgImage else {
            logger.error("Could not convert the UIImage into a CGImage")
            return nil
        }
        
        // Create the model input
        guard let modelInput = try? MobileNetV3ModelInput(my_inputWith: cgImage) else {
            logger.error("Could not create the model's input")
            return nil
        }
        
        // Inference
        guard let modelOutput = try? model!.prediction(input: modelInput).my_output else {
            logger.error("Could not process the model's input")
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
        let output = labels[max_arg]
        logger.info("Class predicted: \(output)")
        return output
    }
}
