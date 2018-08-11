
import Foundation
import CoreML


/// Model Prediction Input Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public class my_mnistInput : MLFeatureProvider {
    
    /// image (28x28) as grayscale (kCVPixelFormatType_OneComponent8) image buffer, 28 pixels wide by 28 pixels high
    var image__28x28_: CVPixelBuffer
    
    public var featureNames: Set<String> {
        get {
            return ["image (28x28)"]
        }
    }
    
    public func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "image (28x28)") {
            return MLFeatureValue(pixelBuffer: image__28x28_)
        }
        return nil
    }
    
    public init(image__28x28_: CVPixelBuffer) {
        self.image__28x28_ = image__28x28_
    }
}


/// Model Prediction Output Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public class my_mnistOutput : MLFeatureProvider {
    
    /// prediction as dictionary of strings to doubles
    public let prediction: [String : Double]
    
    /// classLabel as string value
    public let classLabel: String
    
    public var featureNames: Set<String> {
        get {
            return ["prediction", "classLabel"]
        }
    }
    
    public func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "prediction") {
            return try! MLFeatureValue(dictionary: prediction as [NSObject : NSNumber])
        }
        if (featureName == "classLabel") {
            return MLFeatureValue(string: classLabel)
        }
        return nil
    }
    
    public init(prediction: [String : Double], classLabel: String) {
        self.prediction = prediction
        self.classLabel = classLabel
    }
}


/// Class for model loading and prediction
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
public class my_mnist {
    public var model: MLModel
    
    /**
     Construct a model with explicit path to mlmodel file
     - parameters:
     - url: the file url of the model
     - throws: an NSError object that describes the problem
     */
    public init(contentsOf url: URL) throws {
        self.model = try MLModel(contentsOf: url)
    }
    
    /// Construct a model that automatically loads the model from the app's bundle
    public convenience init() {
        let bundle = Bundle(for: my_mnist.self)
        let assetPath = bundle.url(forResource: "my_mnist", withExtension:"mlmodelc")
        try! self.init(contentsOf: assetPath!)
    }
    
    /**
     Make a prediction using the structured interface
     - parameters:
     - input: the input to the prediction as my_mnistInput
     - throws: an NSError object that describes the problem
     - returns: the result of the prediction as my_mnistOutput
     */
    public func prediction(input: my_mnistInput) throws -> my_mnistOutput {
        let outFeatures = try model.prediction(from: input)
        let result = my_mnistOutput(prediction: outFeatures.featureValue(for: "prediction")!.dictionaryValue as! [String : Double], classLabel: outFeatures.featureValue(for: "classLabel")!.stringValue)
        return result
    }
    
    /**
     Make a prediction using the convenience interface
     - parameters:
     - image (28x28) as grayscale (kCVPixelFormatType_OneComponent8) image buffer, 28 pixels wide by 28 pixels high
     - throws: an NSError object that describes the problem
     - returns: the result of the prediction as my_mnistOutput
     */
    public func prediction(image__28x28_: CVPixelBuffer) throws -> my_mnistOutput {
        let input_ = my_mnistInput(image__28x28_: image__28x28_)
        return try self.prediction(input: input_)
    }
}
