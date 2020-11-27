import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var carOutlet: UIImageView!
    @IBOutlet weak var obstacleOutlet: UIImageView!
    
    var obstacleArray = [UIImage(named: "bush")!, UIImage(named: "barrel")!]
    var carArray = [UIImage(named: "car")!, UIImage(named: "yellowcar")!]
    var settings = Settings()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapRecognized(_:)))
        self.view.addGestureRecognizer(recognizer)
        
        if let settingssetup = UserDefaults.standard.value(Settings.self, forKey: "settings") {
            settings.carColor = settingssetup.carColor
            settings.name = settingssetup.name
            settings.obstacle = settingssetup.obstacle
            
            
            if settings.carColor == "0" {
                carOutlet.image = carArray[0]
            } else {
                carOutlet.image = carArray[1]
            }
            
            if settings.obstacle == "0" {
                obstacleOutlet.image = obstacleArray[0]
            } else {
                obstacleOutlet.image = obstacleArray[1]
            }
            
            nameTextField.text = settings.name
            
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
        settings.name = nameTextField.text!
        UserDefaults.standard.set(encodable: settings, forKey: "settings")
        
        
    }
    
    @IBAction func previousCarButton(_ sender: UIButton) {
        let currentIndex = carArray.index(of: carOutlet.image ?? UIImage()) ?? -1
        var nextIndex = currentIndex - 1
        nextIndex = carArray.indices.contains(nextIndex) ? nextIndex : carArray.count - 1
        UIView.animate(withDuration: 0.3) {
            self.carOutlet.image = self.carArray[nextIndex]
        }
        self.settings.carColor = "\(nextIndex)"
        
    }
    
    @IBAction func nextCarButton(_ sender: UIButton) {
        let currentIndex = carArray.index(of: carOutlet.image ?? UIImage()) ?? -1
        var nextIndex = currentIndex + 1
        nextIndex = carArray.indices.contains(nextIndex) ? nextIndex : 0
        UIView.animate(withDuration: 0.3) {
            self.carOutlet.image = self.carArray[nextIndex]
        }
        self.settings.carColor = "\(nextIndex)"
    }
    
    @IBAction func nextObstacleButton(_ sender: UIButton) {
        
        let currentIndex = obstacleArray.index(of: obstacleOutlet.image ?? UIImage()) ?? -1
        var nextIndex = currentIndex + 1
        nextIndex = obstacleArray.indices.contains(nextIndex) ? nextIndex : 0
        UIView.animate(withDuration: 0.3) {
            self.obstacleOutlet.image = self.obstacleArray[nextIndex]
            
        }
        self.settings.obstacle = "\(nextIndex)"
        
    }
    @IBAction func previousObstacleButton(_ sender: UIButton) {
        let currentIndex = obstacleArray.index(of: obstacleOutlet.image ?? UIImage()) ?? -1
        var nextIndex = currentIndex - 1
        nextIndex = obstacleArray.indices.contains(nextIndex) ? nextIndex : obstacleArray.count - 1
        UIView.animate(withDuration: 0.3) {
            self.obstacleOutlet.image = self.obstacleArray[nextIndex]
        }
        self.settings.obstacle = "\(nextIndex)"
        
        
    }
    @IBAction func tapRecognized(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    
    
}


