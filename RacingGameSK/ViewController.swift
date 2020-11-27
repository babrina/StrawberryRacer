import UIKit
import SpriteKit
class ViewController: UIViewController {
    
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var highScoresView: UIView!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var gameNameView: UIView!
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBOutlet weak var highScoresButtonOutlet: UIButton!
    @IBOutlet weak var settingsButtonOutlet: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.highScoresButtonOutlet.setTitle(NSLocalizedString("High Scores", comment: ""), for: .normal)
        
        backgroundImageView.addParalaxEffect()
        startView.cornerRadius()
        highScoresView.cornerRadius()
        settingsView.cornerRadius()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startView.dropShadow()
        highScoresView.dropShadow()
        settingsView.dropShadow()
       
        
    }
    @IBAction func startButton(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else {
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func highScoresButton(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "ScoresViewController") as? ScoresViewController else {
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func settingsButton(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}

extension UIView {
    func cornerRadius(_ radius: Int = 20) {
        self.layer.cornerRadius = CGFloat(radius)
    }
    
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
    
        layer.shadowRadius = 10
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
    }
}


extension UserDefaults {
    
    
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

extension UIView {
    func addParalaxEffect(amount: Int = 20) {
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        addMotionEffect(group)
    }
}
