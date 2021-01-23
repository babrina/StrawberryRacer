import UIKit
import FirebaseCrashlytics

class ScoresViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var playerScores: [ScoreList] = []
    var key = "gameScores"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaults()
     
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        saveDefaults()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func saveDefaults() {
        
        UserDefaults.standard.set(encodable: playerScores, forKey: key)
    }
    
    func loadDefaults() {
        if let playerScores = UserDefaults.standard.value([ScoreList].self, forKey: "gameScores") {
            self.playerScores = playerScores
            print(playerScores)
    }

}
}
extension ScoresViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScoresTableViewCell") as? ScoresTableViewCell else {
            return UITableViewCell()
            
        }
        cell.configure(with: playerScores[indexPath.row].name, score: playerScores[indexPath.row].score, date: playerScores[indexPath.row].date)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                self.playerScores.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .right)
            }
        }
    
    
    
}
