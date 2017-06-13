//
//  GameScene.swift
//  AppleInvaders
//
//  Created by DEVELOPER on 05/06/17.
//  Copyright © 2017 DEVELOPER. All rights reserved.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    

    let category🤡: UInt32 = 0x1 << 0
    let category😂: UInt32 = 0x1 << 1
    
    var enemies = [SKSpriteNode]()
    var canUpdate = false
    
    var player = SKSpriteNode(imageNamed: "player");
    var isTouchPressed = false, moveDirection = false;
    let speedPlayer:CGFloat = 400.0;
    
    override func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        enemies = createEnemies(padding: CGPoint(x: 100, y: 70))
        createPlayer();
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
                let enemy = createEnemy(CGPoint(x: positionX + (padding.x * pX), y: positionY + (padding.y * pY)))
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
  
    func createEnemy(_ location : CGPoint) -> SKSpriteNode{
        let box = SKSpriteNode(imageNamed: "enemy2");
        box.position = location
        box.setScale(0.3)
        return box;
    }

    
    func createPlayer()
    {
        player.setScale(0.5);
        player.position = CGPoint(x: self.frame.midX, y: player.size.height + 20);
        self.addChild(player);
    }
    
    var beginTouch = CGPoint.zero
    
  
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first
        {
            isTouchPressed = true;

            if touch.location(in: self).x > self.frame.midX
            {
                moveDirection = true;
            }
            else
            {
                moveDirection = false;
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first
        {
            isTouchPressed = false;
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first
        {
            isTouchPressed = false;
        }
    }
    
    
    var lastUpdateTime : TimeInterval = 0
    
    override func update(_ currentTime: TimeInterval) {
        if canUpdate == true{
            let deltaTime = currentTime - lastUpdateTime
            let deltaTimeFloat = CGFloat(deltaTime)
            if deltaTimeFloat < 1000 {
                
        
                for i in enemies{
                    i.position.x += 50 * deltaTimeFloat
            
                }
                
                updatePlayer(deltaTime : deltaTimeFloat);
                
            }
            
            
            lastUpdateTime = currentTime;
            
            
        }
    }
    
    
    func updatePlayer(deltaTime : CGFloat)
    {
        if isTouchPressed == true
        {
            if moveDirection == true
            {
                player.position.x += speedPlayer * deltaTime
            }
            else
            {
                player.position.x -= speedPlayer * deltaTime
            }
        }
        
        
        if player.position.x + (player.size.width/2) > self.frame.width
        {
            player.position.x = self.frame.width - (player.size.width/2);
        }
        
        if player.position.x - (player.size.width/2) < 0
        {
            player.position.x = (player.size.width/2);
        }

    }
    
  
}
