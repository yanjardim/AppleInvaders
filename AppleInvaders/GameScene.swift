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
    
    var player = SKSpriteNode(imageNamed: "player");
    var isTouchPressed = false, moveDirection = false;
    let speedPlayer:CGFloat = 400.0;
    
    override func didMove(to view: SKView)
    {
        createPlayer();
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
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
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        

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
    
    var lastUpdateTime:TimeInterval = 0;
    
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
    
    override func update(_ currentTime: TimeInterval)
    {
        
        let deltaTime = currentTime - lastUpdateTime;
        let deltaTimeFloat = CGFloat(deltaTime);
        lastUpdateTime = currentTime;
        updatePlayer(deltaTime : deltaTimeFloat);
        
        
    }
}
