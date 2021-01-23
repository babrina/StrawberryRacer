import UIKit
import FirebaseCrashlytics

class YouDiedViewController: UIViewController {
    
    @IBOutlet weak var youDiedImage: UIImageView!
    @IBOutlet weak var menuButtonOutlet: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 2) {
            self.youDiedImage.alpha = 100
        } completion: { (_) in
            self.menuButtonOutlet.isHidden = false

        }
    }
    
    
    @IBAction func menuButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
  
}
