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

    public func predict(input: UIImage?) -> Int {
        
        print(input?.size)
        
        
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
}
