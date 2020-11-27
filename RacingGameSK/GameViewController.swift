import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var gameView: SKView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let currentDateTime = Date()
    var score = 0
    var name = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadName()
        addScore()
        
        NotificationCenter.default.addObserver(self, selector: #selector(processNotification), name: Notification.Name.gameStop, object: nil)
    }
    
    //    override var shouldAutorotate: Bool {
    //        return true
    //    }
    //
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        if UIDevice.current.userInterfaceIdiom == .phone {
    //            return .allButUpsideDown
    //        } else {
    //            return .all
    //        }
    //    }
    //
    //    override var prefersStatusBarHidden: Bool {
    //        return true
    //    }
    
    
    @IBAction func processNotification() {
        stopGame()
    }
    
    
    func loadName() {
        if let settingssetup = UserDefaults.standard.value(Settings.self, forKey: "settings") {
            name = settingssetup.name
            
        }
    }
    func takeCurrentTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "HH:mm MMM d, yyyy"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    func addScore() {
        let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: true) { (_) in
            self.score += 1
            
            UIView.animate(withDuration: 0.3) {
                self.scoreLabel.text = String(self.score)
            }
        }
        
    }
    
    func stopGame() {
        let date = takeCurrentTime()
        let currentScore = ScoreList(name: name, score: score, date: date)
        
        let key = "gameScores"
        if var scoreList = UserDefaults.standard.value([ScoreList].self, forKey: key) {
            scoreList.append(currentScore)
            UserDefaults.standard.set(encodable: scoreList, forKey: key)
        } else {
            var scoreList: [ScoreList] = []
            scoreList.append(currentScore)
            UserDefaults.standard.set(encodable: scoreList, forKey: key)
        }
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "YouDiedViewController") as? YouDiedViewController else {
            return
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
}

