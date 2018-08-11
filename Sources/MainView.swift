import Foundation
import UIKit

public let label = CustomLabel()

public class MainView: UIView {
 
    public override func layoutSubviews() {
        
        label.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 190)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.text = "\(currentValue)"
        label.font = UIFont.systemFont(ofSize: 60, weight: .light)
        label.textColor = .white
        self.addSubview(label)
        
        label.isUserInteractionEnabled = true

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedToLeft))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        label.addGestureRecognizer(swipeLeft)
        
        self.addButton(x: 15, y: label.bounds.height+10, width: 75, height: 75, title: "AC", backgroundColor: .lightGray, image: nil, tag: 0)
        self.addButton(x: 100, y: label.bounds.height+10, width: 75, height: 75, title: ".", backgroundColor: .lightGray, image: nil, tag: 1)
        self.addButton(x: 185, y: label.bounds.height+10, width: 75, height: 75, title: "%", backgroundColor: .lightGray, image: nil, tag: 2)
        self.addButton(x: 270, y: label.bounds.height+10, width: 75, height: 75, title: "÷", backgroundColor: .orange, image: nil, tag: 3)
        self.addButton(x: 270, y: label.bounds.height+95, width: 75, height: 75, title: "", backgroundColor: .orange, image: UIImage(named: "multiply.png"), tag: 4)
        
        self.addButton(x: 270, y: label.bounds.height+180, width: 75, height: 75, title: "-", backgroundColor: .orange, image: nil, tag: 5)
        self.addButton(x: 270, y: label.bounds.height+265, width: 75, height: 75, title: "+", backgroundColor: .orange, image: nil, tag: 6)
        self.addButton(x: 270, y: label.bounds.height+350, width: 75, height: 75, title: "=", backgroundColor: .orange, image: nil, tag: 7)
        
   //     self.addButton(x: 15, y: label.bounds.height + 365, width: 225, height: 50, title: "Draw here ⬆️", backgroundColor: .lightGray, image: nil, tag: 8)

        let view2 = DrawingView(frame: CGRect(x: 15, y: label.bounds.height+95, width: 245, height: (label.bounds.height+350)-(label.bounds.height+10)))
        view2.backgroundColor = UIColor.darkGray
        view2.layer.cornerRadius = 10
        self.addSubview(view2)
    }
    
    @objc func swipedToLeft(sender: UISwipeGestureRecognizer) {
        if currentValue != "0" {
            let index = currentValue.index(currentValue.endIndex, offsetBy: -1)
            currentValue.remove(at: index)
            
            if currentValue.count == 0 {
                currentValue.append("0")
            }
        }
    }
}
