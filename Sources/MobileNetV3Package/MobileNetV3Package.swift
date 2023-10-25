import CoreML
import Foundation
import UIKit
import os


private func getArgMax(array: MLMultiArray) -> Int {
    var argMax = 0
    var valMax = Double(truncating: array[0])
    for i in 1..<array.count {
        let val = Double(truncating: array[i])
        if val > valMax {
            argMax = i
            valMax = val
        }
    }
    return argMax
}


private func getProba(array: MLMultiArray, argMax: Int) -> Double {
    var sumExp = 0.0
    for i in 0..<array.count {
        sumExp += exp(Double(truncating: array[i]))
    }
    let proba = exp(Double(truncating: array[argMax])) / sumExp
    return proba
}


extension Array where Element: Comparable {
    func argmax() -> Index? {
        return indices.max(by: { self[$0] < self[$1] })
    }
}


private func getLabelAndProbability(mlArray: MLMultiArray) -> (label: String?, probability: Double?) {
    if let ptr = try? UnsafeBufferPointer<Float>(mlArray) {
        let array = Array(ptr)

        // Find arg max
        guard let argMax = array.argmax() else {
            return (nil, nil)
        }

        // Get the corresponding label
        let label = labels[argMax]

        // Compute probability
        let arrayExp = array.map{ exp(Double($0)) }
        let arrayExpSum = arrayExp.reduce(0, +)
        let proba = arrayExp[argMax] / arrayExpSum

        return (label, proba)
    }
    return (nil, nil)
}


public struct MobileNetV3Package {
    
    private var model: MobileNetV3_MLP_NoQuantization? = nil
    private var logger = Logger()

    public init?(computeUnits: MLComputeUnits = MLComputeUnits.all) {

        // Get the URL of the CoreML model
        guard let url = Bundle.module.url(forResource: "MobileNetV3_MLP_NoQuantization", withExtension: "mlmodelc") else {
            logger.error("Could not find the CoreML model file")
            return nil
        }

        // Create the configuration for the CoreML model
        let configuration = MLModelConfiguration()
        configuration.computeUnits = computeUnits

        // Load the CoreML model
        guard let model = try? MobileNetV3_MLP_NoQuantization(contentsOf: url, configuration: configuration) else {
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
        guard let modelInput = try? MobileNetV3_MLP_NoQuantizationInput(my_inputWith: cgImage) else {
            logger.error("Could not create the model's input")
            return (nil, nil)
        }
        
        // Inference
        guard let modelOutput = try? model!.prediction(input: modelInput).my_output else {
            logger.error("Could not process the model's input")
            return (nil, nil)
        }

        return getLabelAndProbability(mlArray: modelOutput)

//        // Get the arg max
//        let argMax = getArgMax(array: modelOutput)
//
//        // Get the associated label
//        let label = labels[argMax]
//
//        // Get the probability
//        let proba = getProba(array: modelOutput, argMax: argMax)
//
//        return (label, proba)
    }
}
