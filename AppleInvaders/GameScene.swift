//
//  GameScene.swift
//  AppleInvaders
//
//  Created by DEVELOPER on 05/06/17.
//  Copyright © 2017 DEVELOPER. All rights reserved.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    

    let category🤡: UInt32 = 0x1 << 0
    let category😂: UInt32 = 0x1 << 1
    
    var enemies = [SKSpriteNode]()
    var canUpdate = false
    
    override func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        enemies = createEnemies(padding: CGPoint(x: 100, y: 70))
        
        canUpdate = true
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
    
    func createEnemies(padding : CGPoint) -> Array<SKSpriteNode>{

        let positionX = CGFloat(frame.height - (frame.height / 1.01))
        print(positionX)
        let positionY = CGFloat(frame.height - (frame.height / 3))
        var enemies = [SKSpriteNode]()
        for x in 1...4{
            for y in 1...5{
                let pX = CGFloat(x)
                let pY = CGFloat(y)
                let enemy = createBox(CGPoint(x: positionX + (padding.x * pX), y: positionY + (padding.y * pY)))
                self.addChild(enemy)
                enemies.append(enemy)
            }
        }
        return enemies
        
        
    }
    
    func createBox(_ location : CGPoint) -> SKSpriteNode{
        let box = SKSpriteNode(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), size: CGSize(width: 50, height: 50))
        box.position = location
        return box;
    }
    
    var beginTouch = CGPoint.zero
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    var lastUpdateTime : TimeInterval = 0
    
    override func update(_ currentTime: TimeInterval) {
        if canUpdate == true{
            var deltaTime = currentTime - lastUpdateTime
            var deltaTimeFloat = CGFloat(deltaTime)
            if deltaTimeFloat < 1000 {
            
                print("Deltatime: " + String(describing: deltaTimeFloat))
        
        
                for i in enemies{
                    i.position.x += 50 * deltaTimeFloat
            
                }
            }
            lastUpdateTime = currentTime;
        }
        
        
        
    }
}
