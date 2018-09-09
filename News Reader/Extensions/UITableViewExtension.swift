import UIKit

extension UITableView {
    
    func message(_ message: String, isHidden hidden: Bool) {
        
        let messageLabel = UILabel(frame: self.frame)
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        messageLabel.isHidden = hidden
        
        backgroundView = messageLabel
        separatorStyle = .none
        
    }
    
}
