//
//  GameScene.swift
//  Project17
//
//  Created by Todor Dimitrov on 12.08.20.
//  Copyright © 2020 Todor Dimitrov. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var gameOverLabel: SKLabelNode!
    
    var possibleEnemies = ["ball", "hammer", "tv"]
    var gameTimer: Timer?
    var isGameOver = false
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var counter = 0
    var i = 0.0
    var k = 1
    
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        starfield = SKEmitterNode(fileNamed: "starfield")!
        starfield.position = CGPoint(x: 1024, y: 384)
        starfield.advanceSimulationTime(10)
        addChild(starfield)
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameOverLabel.text = "Game Over"
        gameOverLabel.zPosition = 1
        gameOverLabel.isHidden = true
        gameOverLabel.position = CGPoint(x: 500, y: 350)
        gameOverLabel.fontSize = 150
        addChild(gameOverLabel)
        
        
        
        
        score = 0
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1 - Double(i), target: self, selector: #selector(createEnemy), userInfo: nil, repeats: false)
        
        
        
        
    }
    
    @objc func createEnemy() {
        self.counter += 1
        
        if counter == 20*k {
            
            i += 0.1
            k += 1
            print("Counter: \(counter)")
        
        }
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1 - Double(i), target: self, selector: #selector(createEnemy), userInfo: nil, repeats: false)
        
        guard let enemy = possibleEnemies.randomElement() else { return }
        
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
        
        if !isGameOver {
            score += 1
            
        }
    }
    var flag = true
    var tempLocation: CGPoint!
    var location: CGPoint!
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        location = touch.location(in: self)
        
        if flag || (abs(location.x - tempLocation.x) <= 50 && abs(location.y - tempLocation.y) <= 50) {
            
        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }
  
            player.position = location
            flag = true
        }
       
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)
        player.removeFromParent()
        isGameOver = true
        gameTimer?.invalidate()
        gameOverLabel.isHidden = false
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        tempLocation = location
        flag = false
       
    }
   
}
