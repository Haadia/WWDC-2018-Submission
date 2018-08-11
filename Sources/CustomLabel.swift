import Foundation
import UIKit

@IBDesignable public class CustomLabel: UILabel {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func drawText(in rect: CGRect) {
        
        guard text != nil else {
            return super.drawText(in: rect)
        }
        
        let height = self.sizeThatFits(rect.size).height
        let y = rect.origin.y + rect.height - height
        super.drawText(in: CGRect(x: 0, y: y, width: rect.width-15, height: height))
    }
}
