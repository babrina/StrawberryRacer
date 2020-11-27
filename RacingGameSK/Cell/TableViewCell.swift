import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configure(with text: String) {
        self.myLabel.text = "\(text)"
    }

    
}
