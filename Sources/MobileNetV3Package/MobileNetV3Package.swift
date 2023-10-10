import CoreML
import Foundation
import UIKit
import os

public struct MobileNetV3Package {
    
    private var model: MobileNetV3Model? = nil
    private var logger = Logger()

    public init?(computeUnits: MLComputeUnits = MLComputeUnits.all) {

        // Get the URL of the CoreML model
        guard let url = Bundle.module.url(forResource: "MobileNetV3Model", withExtension: "mlmodelc") else {
            logger.error("Could not find the CoreML model file")
            return nil
        }

        // Create the configuration for the CoreML model
        let configuration = MLModelConfiguration()
        configuration.computeUnits = computeUnits

        // Load the CoreML model
        guard let model = try? MobileNetV3Model(contentsOf: url, configuration: configuration) else {
            logger.error("Could not create the CoreML model instance")
            return nil
        }
        self.model = model
    }
    
    public func predict(input: UIImage?) -> (label: String?, probability: Double?) {
        
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

        // Number of classes
        let nbClasses = modelOutput.count

        // Argmax computation
        var maxArg = 0
        var maxVal = Double(truncating: modelOutput[0])
        for i in 1..<nbClasses {
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
        for i in 0..<nbClasses {
            sumExp += exp(Double(truncating: modelOutput[i]))
        }
        let proba = exp(Double(truncating: modelOutput[maxArg])) / sumExp

        return (label, proba)
    }
}
