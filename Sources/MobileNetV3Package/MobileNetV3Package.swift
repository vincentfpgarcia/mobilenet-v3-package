import CoreML
import Foundation
import UIKit
import os

public struct MobileNetV3Package {
    
    private var model: MobileNetV3Model? = nil

    public init?() {

        guard let url = Bundle.module.url(forResource: "MobileNetV3Model", withExtension: "mlmodelc") else {
            return nil
        }

        guard let model = try? MobileNetV3Model(contentsOf: url, configuration: MLModelConfiguration()) else {
            return nil
        }

        self.model = model
    }
    
    public func predict(input: UIImage?) -> (label: String?, probability: Double?) {

        let logger = Logger()
        
        // Convert the UIImage into a CGImage
        guard let cgImage = input?.cgImage else {
            logger.error("Could not convert the UIImage into a CGImage")
            return (nil, nil)
        }
        
        // Create the model input
        guard let modelInput = try? MobileNetV3ModelInput(my_inputWith: cgImage) else {
            logger.error("Could not create the model's input")
            return (nil, nil)
        }
        
        // Inference
        guard let modelOutput = try? model!.prediction(input: modelInput).my_output else {
            logger.error("Could not process the model's input")
            return (nil, nil)
        }

        // Argmax computation
        var maxVal = -1000.0
        var maxArg = -1
        for i in 0..<1000 {
            let val = Double(truncating: modelOutput[i])
            if val > maxVal {
                maxVal = val
                maxArg = i
            }
        }

        // Get the associated label
        let label = labels[maxArg]

        // Compute the probability (softmax value)
        var sumExp = 0.0
        for i in 0..<1000 {
            sumExp += exp(Double(truncating: modelOutput[i]))
        }
        let proba = exp(Double(truncating: modelOutput[maxArg])) / sumExp

        return (label, proba)
    }
}
