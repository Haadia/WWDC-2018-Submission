import Foundation

public var flag = false

public var currentValue: String = "0" {
    didSet {
//
//        if floor(currentValue as! Double) == (currentValue as! Double) {
//            var intValue = currentValue as! Int
//        label.text = "\(intValue)"
//        }
//        else {
            label.text = "\(currentValue)"
     //   }
    }
}

public var currentExpression: String = "0"

public func evaluateExpression() {
    
    flag = true
    let index = currentExpression.index(currentExpression.endIndex, offsetBy: -1)
    let newStr = String(currentExpression[..<index])
    if currentExpression[index] == "+" || currentExpression[index] == "-" || currentExpression[index] == "*" || currentExpression[index] == "/" {
        currentExpression.append(newStr)
    }
    
    //print("Evaluating \(currentExpression)")
    
    let mathExpression = NSExpression(format: currentExpression)
    
    let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double
    
    //print(mathValue)
    
    if mathValue!.truncatingRemainder(dividingBy: 1) == 0 {
    currentValue = "\(Int(mathValue!))"
    currentExpression = "\(Int(mathValue!))"
    }
    else {
        if String(mathValue!) == "inf" {
            currentValue = "\(mathValue!)"
        }
        else {
    currentValue = "\(mathValue!)"
    currentExpression = "\(mathValue!)"
    
        }
    }
//    currentExpression = "0"
//    flag = true
}
