//
// MobileNetV3Model.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class MobileNetV3ModelInput : MLFeatureProvider {

    /// my_input as color (kCVPixelFormatType_32BGRA) image buffer, 224 pixels wide by 224 pixels high
    var my_input: CVPixelBuffer

    var featureNames: Set<String> {
        get {
            return ["my_input"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "my_input") {
            return MLFeatureValue(pixelBuffer: my_input)
        }
        return nil
    }
    
    init(my_input: CVPixelBuffer) {
        self.my_input = my_input
    }

    convenience init(my_inputWith my_input: CGImage) throws {
        self.init(my_input: try MLFeatureValue(cgImage: my_input, pixelsWide: 224, pixelsHigh: 224, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!)
    }

    convenience init(my_inputAt my_input: URL) throws {
        self.init(my_input: try MLFeatureValue(imageAt: my_input, pixelsWide: 224, pixelsHigh: 224, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!)
    }

    func setMy_input(with my_input: CGImage) throws  {
        self.my_input = try MLFeatureValue(cgImage: my_input, pixelsWide: 224, pixelsHigh: 224, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!
    }

    func setMy_input(with my_input: URL) throws  {
        self.my_input = try MLFeatureValue(imageAt: my_input, pixelsWide: 224, pixelsHigh: 224, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!
    }

}


/// Model Prediction Output Type
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class MobileNetV3ModelOutput : MLFeatureProvider {

    /// Source provided by CoreML
    private let provider : MLFeatureProvider

    /// my_output as multidimensional array of floats
    var my_output: MLMultiArray {
        return self.provider.featureValue(for: "my_output")!.multiArrayValue!
    }

    /// my_output as multidimensional array of floats
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    var my_outputShapedArray: MLShapedArray<Float> {
        return MLShapedArray<Float>(self.my_output)
    }

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(my_output: MLMultiArray) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["my_output" : MLFeatureValue(multiArray: my_output)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
class MobileNetV3Model {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: self)
        return bundle.url(forResource: "MobileNetV3Model", withExtension:"mlmodelc")!
    }

    /**
        Construct MobileNetV3Model instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of MobileNetV3Model.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `MobileNetV3Model.urlOfModelInThisBundle` to create a MLModel object to pass-in.

        - parameters:
          - model: MLModel object
    */
    init(model: MLModel) {
        self.model = model
    }

    /**
        Construct MobileNetV3Model instance by automatically loading the model from the app's bundle.
    */
    @available(*, deprecated, message: "Use init(configuration:) instead and handle errors appropriately.")
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration

        - parameters:
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct MobileNetV3Model instance with explicit path to mlmodelc file
        - parameters:
           - modelURL: the file url of the model

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }

    /**
        Construct a model with URL of the .mlmodelc directory and configuration

        - parameters:
           - modelURL: the file url of the model
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }

    /**
        Construct MobileNetV3Model instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<MobileNetV3Model, Error>) -> Void) {
        return self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct MobileNetV3Model instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> MobileNetV3Model {
        return try await self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct MobileNetV3Model instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<MobileNetV3Model, Error>) -> Void) {
        MLModel.load(contentsOf: modelURL, configuration: configuration) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let model):
                handler(.success(MobileNetV3Model(model: model)))
            }
        }
    }

    /**
        Construct MobileNetV3Model instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> MobileNetV3Model {
        let model = try await MLModel.load(contentsOf: modelURL, configuration: configuration)
        return MobileNetV3Model(model: model)
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as MobileNetV3ModelInput

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as MobileNetV3ModelOutput
    */
    func prediction(input: MobileNetV3ModelInput) throws -> MobileNetV3ModelOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as MobileNetV3ModelInput
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as MobileNetV3ModelOutput
    */
    func prediction(input: MobileNetV3ModelInput, options: MLPredictionOptions) throws -> MobileNetV3ModelOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return MobileNetV3ModelOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - my_input as color (kCVPixelFormatType_32BGRA) image buffer, 224 pixels wide by 224 pixels high

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as MobileNetV3ModelOutput
    */
    func prediction(my_input: CVPixelBuffer) throws -> MobileNetV3ModelOutput {
        let input_ = MobileNetV3ModelInput(my_input: my_input)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        - parameters:
           - inputs: the inputs to the prediction as [MobileNetV3ModelInput]
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [MobileNetV3ModelOutput]
    */
    func predictions(inputs: [MobileNetV3ModelInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [MobileNetV3ModelOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [MobileNetV3ModelOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  MobileNetV3ModelOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
