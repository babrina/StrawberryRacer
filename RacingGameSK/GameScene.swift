import UIKit
import SpriteKit
import GameplayKit

enum Direction {
    case left
    case right
}

class GameScene: SKScene {
    
    var car = SKSpriteNode()
    var bush = SKSpriteNode()
    var gameSpeed: CGFloat = 0.3
    var leftGrass = SKSpriteNode()
    var movement: CGFloat = 30
    var obstacleSpeed = 10
    var died = false
    
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        guard let mycar = self.childNode(withName: "car") as? SKSpriteNode else {return}
        car = mycar
        
        createRoadStrip()
        pushTimer()
        
        
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeDetected(_:)))
        leftSwipe.direction = .left
        self.view?.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeDetected(_:)))
        rightSwipe.direction = .right
        self.view?.addGestureRecognizer(rightSwipe)
        
    }
    
    //MARK: - Swipe Detection
    
    @IBAction func leftSwipeDetected(_ sender: UISwipeGestureRecognizer) {
        moveCar(direction: .left)
    }
    
    @IBAction func rightSwipeDetected(_ sender: UISwipeGestureRecognizer) {
        
        moveCar(direction: .right)
        
    }
    
    func didEvaluateActions(for scene: SKScene) {
        if car.position.x == -135 {
            stopGame()
            sendData()
        }
       
    }
    override func update(_ currentTime: TimeInterval) {
        
        showRoadStrip()
        removeItems()
        checkObstacle()
        print(car.position.x)
        
    }
    
    func makePause() {
        isPaused = true
    }

    func checkObstacle() {
        guard let obstacle = self.childNode(withName: "obstacleCar") as? SKSpriteNode else {return}
        var obstacleCar = obstacle
        
        if car.intersects(obstacleCar) {
            died = true
            makePause()
            stopGame()
            sendData()
        }
        
        guard let leftLine = childNode(withName: "leftLine") else {return}
        guard let rightLine = childNode(withName: "rightLine") else {return}
        
        if car.position.x <= -135 {
            stopGame()
            sendData()
        }
        
        
    }
    func createLaunchBushes() {
        let bush = SKSpriteNode(imageNamed: "bush")
        bush.name = "bush"
        bush.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        bush.zPosition = 10
        bush.position.x = 0
        bush.position.y = 700
        addChild(bush)
    }
    
    func pushTimer() {
        let roadStripTimer = Timer.scheduledTimer(timeInterval: TimeInterval(gameSpeed), target: self, selector: #selector(GameScene.createRoadStrip), userInfo: nil, repeats: true)
        let bushTimer = Timer.scheduledTimer(timeInterval: TimeInterval(gameSpeed), target: self, selector: #selector(GameScene.createBush), userInfo: nil, repeats: true)
        let secondBushTimer = Timer.scheduledTimer(timeInterval: TimeInterval(gameSpeed), target: self, selector: #selector(GameScene.createRightBush), userInfo: nil, repeats: true)
        let obstacleTimer = Timer.scheduledTimer(timeInterval: TimeInterval(4), target: self, selector: #selector(GameScene.createCarObstacle), userInfo: nil, repeats: true)
        
        if died {
            obstacleTimer.invalidate()
            roadStripTimer.invalidate()
            bushTimer.invalidate()
            secondBushTimer.invalidate()
        }
    }
    
    @objc func createBush() {
        let bush = SKSpriteNode(imageNamed: "bush")
        bush.name = "bush"
        bush.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        bush.size.width = 50
        bush.size.height = 50
        bush.zPosition = 10
        bush.position.x = CGFloat.random(in: (-200)...(-170))
        bush.position.y = 1000
        addChild(bush)
    }
    @objc func createRightBush() {
        let rightBush = SKSpriteNode(imageNamed: "bush")
        rightBush.name = "rightBush"
        rightBush.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rightBush.size.width = 50
        rightBush.size.height = 50
        rightBush.zPosition = 10
        rightBush.position.x = CGFloat.random(in: 170...200)
        rightBush.position.y = 1000
        addChild(rightBush)
    }
    
    @objc func createRoadStrip() {
        let roadStrip = SKShapeNode(rectOf: CGSize(width: 10, height: 100))
        roadStrip.strokeColor = .white
        roadStrip.fillColor = .white
        roadStrip.alpha = 1
        roadStrip.name = "roadStrip"
        roadStrip.zPosition = 0
        roadStrip.position.x = 0
        roadStrip.position.y = 1000
        addChild(roadStrip)
    }
    
    @objc func createCarObstacle() {
        let obstacleCar = SKSpriteNode(imageNamed: "car")
        obstacleCar.name = "obstacleCar"
        obstacleCar.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        obstacleCar.size.width = 60
        obstacleCar.size.height = 80
        obstacleCar.zPosition = 1
        obstacleCar.position.x = CGFloat.random(in: (-150)...150)
        obstacleCar.position.y = 1000
        addChild(obstacleCar)
    }
    
    func showRoadStrip() {
        enumerateChildNodes(withName: "roadStrip") { (roadStrip, stop) in
            guard let strip = roadStrip as? SKShapeNode else {return}
            strip.position.y -= 30
            
        }
        enumerateChildNodes(withName: "bush") { (bush, stop) in
            guard let bush = bush as? SKSpriteNode else {return}
            bush.position.y -= 30
        }
        enumerateChildNodes(withName: "rightBush") { (rightBush, stop) in
            guard let rightBush = rightBush as? SKSpriteNode else {return}
            rightBush.position.y -= 30
        }
        enumerateChildNodes(withName: "obstacleCar") { (obstacleCar, stop) in
            guard let obstacleCar = obstacleCar as? SKSpriteNode else {return}
            obstacleCar.position.y -= CGFloat(self.obstacleSpeed)
        }
    }
    
    
    
    func moveCar(direction: Direction) {
        switch direction {
        case .left:
            UIView.animate(withDuration: 0.3) {
                self.car.position.x -= self.movement
            }
        case .right:
            UIView.animate(withDuration: 0.3) {
                self.car.position.x += self.movement
            }
        }
    }
    
    func removeItems() {
        for child in children {
            if child.position.y < -self.size.height - 100 {
                child.removeFromParent()
            }
        }
    }
    
    func stopGame() {
        for child in children {
            child.removeFromParent()
            child.removeAllActions()
            
            
           
        }
    }
    
    func sendData() {
        
        NotificationCenter.default.post(name: Notification.Name.gameStop, object: nil, userInfo: nil)

    }
}


extension Notification.Name {
    static let gameStop = Notification.Name("gameStop")
}
