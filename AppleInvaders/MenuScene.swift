//
//  MenuScene.swift
//  AppleInvaders
//
//  Created by DEVELOPER on 19/06/17.
//  Copyright © 2017 DEVELOPER. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene: SKScene, SKPhysicsContactDelegate
{
    var button: SKNode! = nil
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        addButtons()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
   
    
    var beginTouch = CGPoint.zero
    
    func addButtons(){
        button = SKSpriteNode(color: SKColor.red, size: CGSize(width: 400, height: 100))
        let txtStart = SKLabelNode(fontNamed: "Arial")
        txtStart.text = "Start"
        txtStart.fontSize = 65
        txtStart.fontColor = SKColor.white
        txtStart.position = CGPoint(x:self.frame.midX, y:self.frame.midY - 30)

        
        // Put it in the center of the scene
        button.position = CGPoint(x:self.frame.midX, y:self.frame.midY);
        
        self.addChild(button)
        self.addChild(txtStart)
    }
    
    private func startGame() {
        let gameScene = GameScene(size: view!.bounds.size)
        let transition = SKTransition.fade(withDuration: 0.15)
        view!.presentScene(gameScene, transition: transition)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
       
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        // Check if the location of the touch is within the button's bounds
        if button.contains(touchLocation) {
            startGame()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
    }
    
    
    var lastUpdateTime : TimeInterval = 0
    
    override func update(_ currentTime: TimeInterval) {
        
    }



}
