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
    
    var enemies = [SKSpriteNode]()
    var canUpdate = false
    
    var player = SKSpriteNode(imageNamed: "player");
    var isTouchPressed = false, moveDirection = false;
    let speedPlayer:CGFloat = 400.0;
    var listBullets = [SKSpriteNode]();
    var speedCreateBullets : CGFloat = 0.8;
    var timeBullet : CGFloat = 0.8;
    var speedBullet : CGFloat = 30;
    
    let categoryBullet: UInt32 = 0x1 << 0
    let categoryEnemy: UInt32 = 0x1 << 1
    let categoryPlayer: UInt32 = 0x1 << 2
    
    let enemiesSpeed : CGFloat = 100;
    let enemiesSpeedY : CGFloat = 3000;
    var right : Bool = true
    var down : Bool = false
    
    var score = 0;
    var highScore = 0;
    let scoreLabel = SKLabelNode(fontNamed: "Arial")
    let maxScoreLabel = SKLabelNode(fontNamed: "Arial")
    
    var playerDead = false;
    
    override func didMove(to view: SKView)
    {
        initScene();
    }
    
    func RestartScene()
    {
        self.removeAllChildren();
        
        playerDead = false;
        score = 0;
        listBullets.removeAll();
        enemies.removeAll();
        
        initScene();
        
    }
    
    func initScene()
    {
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        enemies = createEnemies(padding: CGPoint(x: 100, y: 70))
        createPlayer();
        canUpdate = true
        
        physicsWorld.contactDelegate = self
        
        scoreLabel.fontColor = SKColor.white;
        scoreLabel.fontSize = 50
        scoreLabel.position = CGPoint(x: self.frame.midX, y: frame.height - 100);
        scoreLabel.text = "Score: " + String(score);
        
        maxScoreLabel.fontColor = SKColor.white;
        maxScoreLabel.fontSize = 24
        maxScoreLabel.position = CGPoint(x: self.frame.midX + 200, y: frame.height - 100);
        updateHighScore();
        
        self.addChild(scoreLabel)
        self.addChild(maxScoreLabel)

    }
    
    func updateHighScore()
    {
        if highScore < score
        {
            highScore = score;
        }
        maxScoreLabel.text = "HighScore: " + String(highScore);
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == categoryEnemy | categoryBullet
        {
            guard let node1 = contact.bodyA.node as? SKSpriteNode,
                let node2 = contact.bodyB.node as? SKSpriteNode else {
                    return
            }
            
            if node1.name == "enemy"{
                enemies.remove(at: enemies.index(of: node1)!)
                
            }
            else  if node1.name == "bullet"
            {
                listBullets.remove(at: listBullets.index(of: node1)!)
            }
            
            if node2.name == "enemy"{
                enemies.remove(at: enemies.index(of: node2)!)
                
            }
            else  if node2.name == "bullet"
            {
                listBullets.remove(at: listBullets.index(of: node2)!)
            }
            
            score += 1;
            node1.removeFromParent()
            node2.removeFromParent()
            
            
            
        }
        
        if collision == categoryPlayer | categoryEnemy
        {
            guard let node1 = contact.bodyA.node as? SKSpriteNode,
                let node2 = contact.bodyB.node as? SKSpriteNode else {
                    return
            }
            
            if node1.name == "player"
            {
                node1.removeFromParent()
            }
            
            if node2.name == "player"
            {
                node2.removeFromParent()
            }
            
            
            updateHighScore();
            playerDead = true;
            RestartScene();
        }

        
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
        let box = SKSpriteNode(imageNamed: "enemy");
        box.position = location
        box.setScale(0.3)
       
        box.physicsBody = SKPhysicsBody(rectangleOf: box.frame.size, center: CGPoint(x: 0, y: box.frame.height * 0.4 ))
        box.physicsBody?.isDynamic = true
        box.physicsBody?.categoryBitMask = categoryEnemy
        box.physicsBody?.contactTestBitMask = categoryBullet
        box.physicsBody?.affectedByGravity = false;
        box.name = "enemy"
        
        return box;
    }

    
    func createPlayer()
    {
        player.setScale(0.4);
        player.position = CGPoint(x: self.frame.midX, y: player.size.height + 20);
        
        player.physicsBody = SKPhysicsBody(rectangleOf: player.frame.size, center: CGPoint(x: 0, y: player.frame.height * 0.4 ))
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = categoryPlayer
        player.physicsBody?.contactTestBitMask = categoryEnemy
        player.physicsBody?.allowsRotation = false;
        player.physicsBody?.affectedByGravity = false;
        player.name = "player"
        
        self.addChild(player);
    }
    
    func createBullet()
    {
        var bullet = SKSpriteNode(imageNamed: "Projetil");
        bullet.setScale(0.4);
        bullet.position = CGPoint(x: player.position.x, y: player.position.y);
        
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.frame.size, center: CGPoint(x: 0, y: bullet.frame.height * 0.4 ))
        bullet.physicsBody?.isDynamic = true
        bullet.physicsBody?.categoryBitMask = categoryBullet
        bullet.physicsBody?.contactTestBitMask = categoryEnemy
        bullet.physicsBody?.allowsRotation = false;
        bullet.physicsBody?.affectedByGravity = false;
        bullet.name = "bullet"
        
        
        listBullets.append(bullet);
        
        self.addChild(bullet);
        
        
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
                
                updateScore()
                updateEnemies(deltaTime : deltaTimeFloat);
                updatePlayer(deltaTime : deltaTimeFloat);
                updateBullet(deltaTime: deltaTimeFloat);

                
            }
            
            lastUpdateTime = currentTime;
            
        }
    }
    
    
    func updateEnemies(deltaTime : CGFloat){
        for i in enemies{
            if i.position.x + (i.size.width / 2) > frame.width && right{
                right = false;
                down = true;
                break;
            }
            if i.position.x - (i.size.width / 2) < 0 && !right{
                right = true;
                down = true;
                break;
            }
        }
        
        
        for i in enemies{
            

            if down{
                i.position.y -= enemiesSpeedY * deltaTime
                

            }
            
            if right{
                i.position.x += enemiesSpeed * deltaTime
            }
            
            else if !right{
                i.position.x -= enemiesSpeed * deltaTime
            }
            
            
        }
            if down{
                down = false
            }
    }
   
    
    func updateBullet(deltaTime : CGFloat)
    {
        timeBullet += deltaTime;
     
        if timeBullet > speedCreateBullets && playerDead == false
        {
            createBullet();
            
            timeBullet = 0;
        }
        
        var indexBullets = 0;
        
        for i in listBullets
        {
           
            i.position.y += speedBullet;
            
            if i.position.y > self.frame.height
            {
                listBullets.remove(at: indexBullets)
                i.removeFromParent();
            }
            
            indexBullets += 1;
            
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
    
    func updateScore()
    {
        scoreLabel.text = "Score: " + String(score)
    }
    
  
}
