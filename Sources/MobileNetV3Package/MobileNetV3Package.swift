import CoreML
import Foundation
import UIKit

public struct MobileNetV3Package {
    
    private var model: MLModel? = nil
//    private var model: Foo? = Foo(configuration: MLModelConfiguration())
    
    public init() {
        if let url = Bundle.module.url(forResource: "Foo", withExtension: "mlmodelc") {
            self.model = try! MLModel(contentsOf: url, configuration: MLModelConfiguration())
//            self.model = try? Foo(configuration: MLModelConfiguration())
        }
//        self.model = try? Foo(configuration: MLModelConfiguration())
    }
    
    public func predict(input: UIImage?) -> Int {
        
        
        
        
        
        //        print("Loading the model")
        //
        //        if model != nil {
        //            print("Model is not nil")
        //        }
        //        else {
        //            print("Model is nil")
        //        }
        //
        //
        //        // Create a dummy input
        //        let array = try! MLMultiArray(shape: [1, 224, 224], dataType: .float32)
        
        //        let input = FooInput(my_input: array)
        
        //        model?.prediction(from: <#T##MLFeatureProvider#>)
        
        //        print(Bundle.module.url(forResource: "Foo", withExtension: "mlmodelc"))
        
        //        if let url = Bundle.module.url(forResource: "Foo", withExtension: "mlmodel") {
        //
        //            print("Compiling the model")
        //            let compiledURL = try! MLModel.compileModel(at: url)
        //            print(compiledURL)
        //
        //            print("Creating the model")
        //            let model = try! MLModel(contentsOf: compiledURL, configuration: MLModelConfiguration())
        //
        //            if model != nil {
        //                print("Model is not nil")
        //            }
        //            else {
        //                print("Model is nil")
        //            }
        //        }
        
        //        if let url = Bundle.module.url(forResource: "Foo", withExtension: "mlmodelc") {
        //            let model = try! MLModel(contentsOf: url, configuration: MLModelConfiguration())
        //
        //
        ////                    if model != nil {
        ////                        print("Model is not nil")
        ////                    }
        ////                    else {
        ////                        print("Model is nil")
        ////                    }
        //
        //        }
        
        Thread.sleep(until: Date().addingTimeInterval(0.01))
        
        return 245
    }
    
    public func predict2(input: UIImage?) -> Int? {
        
        // Get the CGImage
        guard let cgImage = input?.cgImage else {
            return nil
        }
        
        // Create the actual model input
        let model_input = try! FooInput(my_inputWith: cgImage)
        
        // Prediction option: CPU vs. GPU
        let options = MLPredictionOptions()
        options.usesCPUOnly = false
        
        // Prediction
        do {
            
//            let prediction = try! model?.prediction(input: model_input, options: options)
            let outFeatures = try! model?.prediction(from: model_input, options: options)
            let output = FooOutput(features: outFeatures!).my_output
            
//            print(output)
//            print(output[0])
            
            var max_val = -1000.0
            var max_arg = -1
            
            for i in 0..<1000 {
                
                let val = Double(output[i])
                if val > max_val {
                    max_val = val
                    max_arg = i
                }
            }
            
            print("arg max : \(max_arg)")
            
            return Int(max_arg)
            
        }
    }
    
}
