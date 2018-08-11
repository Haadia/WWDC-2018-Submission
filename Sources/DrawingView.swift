import Foundation
import UIKit
import Vision
import CoreML

public class DrawingView: UIView {
    
    var lastPoint = CGPoint.zero
    var red: CGFloat = 255.0
    var green: CGFloat = 255.0
    var blue: CGFloat = 255.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var imageView: UIImageView?
    
    public override func layoutSubviews() {
        imageView = UIImageView()
        imageView?.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        
        self.backgroundColor = UIColor.darkGray
        imageView?.backgroundColor = UIColor.black

        self.addSubview(imageView!)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first as? UITouch {
            lastPoint = touch.location(in: self)
        
        }
    }
    
    public func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        if #available(iOS 10.0, *) {
            let renderer1 = UIGraphicsImageRenderer(size: self.frame.size)
            let img1 = renderer1.image { ctx in
                ctx.cgContext.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
                ctx.cgContext.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
                ctx.cgContext.setLineCap(.round)
                ctx.cgContext.setLineWidth(brushWidth)
                ctx.cgContext.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
                ctx.cgContext.setBlendMode(.normal)
                ctx.cgContext.strokePath()
                
                imageView!.image?.draw(in: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
                
                
                imageView?.image = ctx.currentImage
                imageView?.alpha = opacity
                
            }
        } else {
        
        }
    }
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first as? UITouch {
            let currentPoint = touch.location(in: self)
            drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            // draw a single point
            drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
            
        }
       // print("touches ended")
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //textImage.image = image
        
        do {
            
            let model = try VNCoreMLModel(for: my_mnist().model)
            let request = VNCoreMLRequest(model: model, completionHandler: myResultsMethod)
            
            let handler = VNImageRequestHandler(cgImage: image.cgImage!)
            imageView?.image = nil
            
            try handler.perform([request])
        }
            
        catch {
            //print(error.localizedDescription)
        }
    }
    
    public func myResultsMethod(request: VNRequest, error: Error?)  {
        guard let results = request.results as? [VNClassificationObservation]
            else { fatalError("huh") }
        var highest = "0"
        var highestScore: Float = 0.0
        for classification in results {
           // print(classification.identifier, // the scene label
             //   classification.confidence)
            if classification.confidence > highestScore {
                highestScore = classification.confidence
                
                highest = classification.identifier
            }
        }
    //    print(highest)
//        currentValue = highest
        updateCurrent(value: highest)
//        label.text? = highest
    }
    
    public func updateCurrent(value: String) {
        
        
        let index = currentExpression.index(currentExpression.endIndex, offsetBy: -1)
        if currentExpression[index] != "+" && currentExpression[index] != "-" && currentExpression[index] != "*" && currentExpression[index] != "/" {
            if currentValue == "0" {
                currentValue = value
                
                
                let myViews = self.superview!.subviews.filter{$0 is UIButton}
                for view1 in myViews {
                    let button = view1 as! UIButton
                    if button.titleLabel?.text != nil {
                        
                    if (button.titleLabel!.text!) == "AC" {
                        button.setTitle("C", for: .normal)
                        button.titleLabel?.textAlignment = .center
                    }
                }
                }
            }
                else {
                if flag == false {
                    currentValue.append(value)
                }
                else {
                    flag = false
                    currentValue = value
                }
                }
                currentExpression.append("\(Double(value)!)")
            }
        else {
                currentValue = value
            currentExpression.append("\(Double(value)!)")
        }
    }
    }
