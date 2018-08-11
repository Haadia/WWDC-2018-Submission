import Foundation
import UIKit

public extension UIView {
    
    public func addButton(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, title: String, backgroundColor: UIColor, image: UIImage?, tag: Int) {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: x, y: y, width: width, height: height)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 30, weight: .light)
        if tag == 8 {
        //print(button.titleLabel!.text!)
        button.layer.cornerRadius = 10
        }
        else {
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        }
        button.clipsToBounds = true
        button.backgroundColor = backgroundColor
        button.addTarget(button, action: #selector(self.buttonPressed), for: .touchUpInside)
        button.tag = tag
        if backgroundColor == .orange {
            button.setTitleColor(UIColor.white, for: .normal)
        }
        else {
            button.setTitleColor(UIColor.black, for: .normal)
        }
        if let image = image {
            button.setImage(image, for: .normal)
        }
        
        self.addSubview(button)
    }
    
    @objc public func buttonPressed(sender: UIButton) {
        //print(sender.tag)
        let index = currentExpression.index(currentExpression.endIndex, offsetBy: -1)

        if flag == true {
            flag = false
        }
        if currentExpression[index] == "+" || currentExpression[index] == "-" || currentExpression[index] == "*" || currentExpression[index] == "/" {
            currentExpression.remove(at: index)
        }
        
        let color = sender.backgroundColor
        
        if let b = sender.titleLabel!.text {
        
        if b == "+" || b == "-" {
        currentExpression.append(b)
            
        }
        else if b == "=" {
            evaluateExpression()
        }
            
        else if b == "AC" {
            currentExpression = "0"
            currentValue = "0"
        }
        else if b == "C" {
            sender.setTitle("AC", for: .normal)
            currentExpression = "0"
            currentValue = "0"
        }
        else if b == "." {
            if currentValue.characters.contains(".") {
                
            }
            else {
            currentExpression.append(b)
            currentValue.append(b)
            }
        }
        else if b == "%" {
            //print(Double(currentValue)!)
            currentValue = "\(Double(currentValue)! / 100.0)";
            flag = true
            currentExpression = "\(Double(currentValue)! / 100.0)"
            }
        }
        if sender.tag == 3 {
            //print("Divided")
            currentExpression.append("/")
        }
        else if sender.tag == 4 {
            currentExpression.append("*")
        }
        
    }
}


