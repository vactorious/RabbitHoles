//
//  GameScene.swift
//  RabbitHoles
//
//  Created by Victor Huang on 2/19/17.
//  Copyright © 2017 Victor Huang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    
    var time = 0.3
    
    var scoreLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        let bgImage = SKSpriteNode(imageNamed: "background")
        bgImage.position = CGPoint(x: 0, y: 0)
        bgImage.size = self.frame.size
        bgImage.zPosition = -1
        self.addChild(bgImage)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.fontSize = 96
        scoreLabel.position = CGPoint(x: -225, y: 550)
        addChild(scoreLabel)
        
        let title = SKSpriteNode(imageNamed: "titlecat")
        title.position = CGPoint(x: 0, y: 200)
        title.zPosition = 1
        title.setScale(3.5)
        title.name = "title"
        addChild(title)
        
        let play = SKSpriteNode(imageNamed: "play")
        play.position = CGPoint(x: 0, y: -300)
        play.name = "play"
        play.zPosition = 1
        addChild(play)
        
    }
    
    func spawnTime() {
        let wait = SKAction.wait(forDuration: self.time)
        let spawn = SKAction.run { self.spawn()
        }
        
        let sequence = SKAction.sequence([wait, spawn])
        self.run(SKAction.repeatForever(sequence))

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node : SKNode = self.atPoint(location)
            if node.name == "cat" {
                node.removeFromParent()
                self.score += 1
            }
            else if node.name == "retry" {
                restartGame()
                print("doot")
            }
            else if node.name == "play" {
                node.removeFromParent()
                let title: SKNode = self.atPoint(CGPoint(x: 0, y: 200))
                title.removeFromParent()
                spawnTime()
            }
        }
    }
        
    func spawn() {
        
        let catPos : CGPoint
        let coord = arc4random_uniform(16)
        switch coord {
        case 0:
            catPos = CGPoint(x: -225, y: 485)
        case 1:
            catPos = CGPoint(x: 15, y: 485)
        case 2:
            catPos = CGPoint(x: 245, y: 485)
        case 3:
            catPos = CGPoint(x: -225, y: 225)
        case 4:
            catPos = CGPoint(x: 15, y: 225)
        case 5:
            catPos = CGPoint(x: 245, y: 225)
        case 6:
            catPos = CGPoint(x: -225, y: -20)
        case 7:
            catPos = CGPoint(x: 10, y: -20)
        case 8:
            catPos = CGPoint(x: 250, y: -20)
        case 9:
            catPos = CGPoint(x: -225, y: -265)
        case 10:
            catPos = CGPoint(x: 10, y: -265)
        case 11:
            catPos = CGPoint(x: 250, y: -265)
        case 12:
            catPos = CGPoint(x: -225, y: -500)
        case 13:
            catPos = CGPoint(x: 20, y: -500)
        case 14:
            catPos = CGPoint(x: 255, y: -500)
        default:
            catPos = CGPoint(x: 10, y: -20)
        }
        let cat = SKSpriteNode(imageNamed: "cat")
        cat.position = catPos
        cat.zPosition = 0
        cat.setScale(0.35)
        cat.name = "cat"
        addChild(cat)
    }
    
    func gameOver() {
        
        let scaredyCat = SKSpriteNode(imageNamed: "gameover")
        scaredyCat.position = CGPoint(x: 0, y: 250)
        scaredyCat.zPosition = 65
        scaredyCat.setScale(1.4)
        scaredyCat.name = "scaredy"
        let retry = SKSpriteNode(imageNamed: "retry")
        retry.position = CGPoint(x: 0, y: -450)
        retry.zPosition = 65
        retry.name = "retry"
        addChild(scaredyCat)
        addChild(retry)
        
    }
    
    func restartGame() {
                self.scene?.isPaused = false
        print("deet")
        self.score = 0
        for child in self.children {
            if (child.name == "cat" || child.name == "retry" || child.name == "scaredy") {
                child.removeFromParent()
            }
        }
        
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if self.children.count > 12 {
            self.gameOver()
        }
    }
}
