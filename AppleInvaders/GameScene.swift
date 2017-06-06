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
    
    let 😂 = SKLabelNode(fontNamed: "Apple Color Emoji")
    let 🤡 = SKLabelNode(fontNamed: "Apple Color Emoji")
    let 🦉 = SKLabelNode(fontNamed: "Apple Color Emoji")
    let redCircle = SKShapeNode(circleOfRadius: 10)
    let category🤡: UInt32 = 0x1 << 0
    let category😂: UInt32 = 0x1 << 1
    
    override func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        let edge = SKShapeNode()
        let edgePath = CGPath(rect: self.frame, transform: nil)
        edge.path = edgePath
        edge.strokeColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        edge.alpha = 0
        edge.lineWidth = 10.0
        edge.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.addChild(edge)
        
        let floor = SKSpriteNode(color: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), size: CGSize(width: self.frame.width, height: 20))
        floor.anchorPoint = .zero
        floor.position = .zero
        floor.physicsBody = SKPhysicsBody(edgeLoopFrom: floor.frame)
        floor.physicsBody?.isDynamic = false
        
        floor.physicsBody?.friction = 1
        self.addChild(floor)
        
        for i in 1...12{
            addChild(createBox(CGPoint(x: 1200, y: 51*i)))
        }
        
        self.😂.fontSize = 48
        self.😂.text = "🌝"
        self.😂.position = CGPoint(x: 1200, y: 51*12)
        self.😂.physicsBody = SKPhysicsBody(rectangleOf: self.😂.frame.size, center: CGPoint(x: 0, y: self.😂.frame.height * 0.4 ))
        self.😂.physicsBody?.isDynamic = true
        self.😂.physicsBody?.categoryBitMask = category😂
        self.😂.physicsBody?.contactTestBitMask = category🤡
        
        
        addChild(self.😂)
        
        self.🤡.fontSize = 48
        self.🤡.text = "🌚"
        self.🤡.position = CGPoint(x: 1000, y: 20)
        self.🤡.physicsBody = SKPhysicsBody(rectangleOf: self.🤡.frame.size, center: CGPoint(x: 0, y: self.🤡.frame.height * 0.4 ))
        self.🤡.physicsBody?.isDynamic = true
        self.🤡.physicsBody?.categoryBitMask = category🤡
        self.🤡.physicsBody?.contactTestBitMask = category😂
        
        addChild(self.🤡)
        
        let sling = SKSpriteNode(color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), size: CGSize(width: 20, height: 150))
        sling.anchorPoint = .zero
        sling.position = CGPoint(x: 140, y: 0)
        addChild(sling)
        
        self.🦉.fontSize = 48
        self.🦉.text = "🦉"
        self.🦉.position = CGPoint(x: 150, y: 150)
        self.🦉.physicsBody = SKPhysicsBody(rectangleOf: self.🦉.frame.size, center: CGPoint(x: 0, y: self.🦉.frame.height * 0.4 ))
        self.🦉.physicsBody?.isDynamic = false
        self.🦉.physicsBody?.allowsRotation = false
        self.🦉.physicsBody?.friction = 1
        addChild(self.🦉)
        
        redCircle.fillColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        
        physicsWorld.contactDelegate = self;
        
        if let particle = SKEmitterNode(fileNamed: "✨.sks"){
            particle.zPosition = 4
            🤡.addChild(particle)
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == category🤡 | category😂{
            print("voce ganhou:")
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
        }
    }
    
    func createBox(_ location : CGPoint) -> SKSpriteNode{
        let box = SKSpriteNode(color: #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1), size: CGSize(width: 50, height: 50))
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        box.physicsBody?.isDynamic = true
        return box;
    }
    
    var beginTouch = CGPoint.zero
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            beginTouch = touch.location(in: self)
            redCircle.position = beginTouch;
            self.addChild(redCircle)
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            redCircle.position = touch.location(in: self);
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            redCircle.removeFromParent()
            let endTouchPoistion = touch.location(in: self)
            let diffX = beginTouch.x - endTouchPoistion.x;
            let diffY = beginTouch.y - endTouchPoistion.y;
            self.🦉.physicsBody?.isDynamic = true
            self.🦉.physicsBody?.applyForce(CGVector(dx : 50 * diffX, dy: 50 * diffY))
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        redCircle.removeFromParent()
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
