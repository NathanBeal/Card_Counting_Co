//
//  gameScreen.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/7/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

//let defaults = UserDefaults()

class startScreen: SKScene
{
    
    let background = SKSpriteNode(imageNamed: "background")
    let author = SKSpriteNode(imageNamed: "StudioTitle")
    let mascot = SKSpriteNode(imageNamed: "SilhoutteClown")
    
    let chip1 = SKSpriteNode(imageNamed: "RedChip")
    let chip2 = SKSpriteNode(imageNamed: "RedChip")
    let chip3 = SKSpriteNode(imageNamed: "BlackChip")
    let chip4 = SKSpriteNode(imageNamed: "BlackChip")
    let chip5 = SKSpriteNode(imageNamed: "BlackChip")
    let chip6 = SKSpriteNode(imageNamed: "BlackChip")
    let chip7 = SKSpriteNode(imageNamed: "BlueChip")
    
    let ttpLabel = SKLabelNode()
    
    let gameTitle = SKLabelNode()
    let play = SKLabelNode()
    
    var nextScreen = false
    
    let gameArea: CGRect
    
    //Used for boundaries
    override init(size: CGSize)
    {
        gameArea = CGRect(x: 0, y: 0, width: defaults.double(forKey: "FrameWidth"), height: defaults.double(forKey: "FrameHeight"))
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView)
    {
        //Background
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        //Title
        gameTitle.fontName = "Copperplate-Light"
        gameTitle.fontColor = SKColor.white
        gameTitle.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        gameTitle.text = "Card Counting Co."
        gameTitle.fontSize = CGFloat(60 * scaleModifier)
        gameTitle.position = CGPoint(x: self.size.width * 0.50, y: 7.75 * self.size.height/10)
        gameTitle.zPosition = 1
        self.addChild(gameTitle)
        
        //Cards
        Cards.hAce.setScale(CGFloat(0.2 * scaleModifier))
        Cards.hAce.position = CGPoint(x: 7.4 * self.size.width/16, y: -1.5 * self.size.height/10)
        Cards.hAce.zPosition = 1
        self.addChild(Cards.hAce)
        
        Cards.sAce.setScale(CGFloat(0.2 * scaleModifier))
        Cards.sAce.position = CGPoint(x: 8.6 * self.size.width/16, y: -1.5 * self.size.height/10)
        Cards.sAce.zPosition = 2
        self.addChild(Cards.sAce)
        
        //Chips
        chip1.setScale(CGFloat(0.5 * scaleModifier))
        chip1.position = CGPoint(x: 1 * self.size.width/10, y: 12 * self.size.height/10)
        chip1.zPosition = 2
        self.addChild(chip1)
        chip2.setScale(CGFloat(0.5 * scaleModifier))
        chip2.position = CGPoint(x: 1.4 * self.size.width/10, y: 12 * self.size.height/10)
        chip2.zPosition = 2
        self.addChild(chip2)
        chip3.setScale(CGFloat(0.5 * scaleModifier))
        chip3.position = CGPoint(x: 1.4 * self.size.width/10, y: 12 * self.size.height/10)
        chip3.zPosition = 2
        self.addChild(chip3)
        chip4.setScale(CGFloat(0.5 * scaleModifier))
        chip4.position = CGPoint(x: 1.4 * self.size.width/10, y: 12 * self.size.height/10)
        chip4.zPosition = 2
        self.addChild(chip4)
        chip5.setScale(CGFloat(0.5 * scaleModifier))
        chip5.position = CGPoint(x: 1.4 * self.size.width/10, y: 12 * self.size.height/10)
        chip5.zPosition = 2
        self.addChild(chip5)
        chip6.setScale(CGFloat(0.5 * scaleModifier))
        chip6.position = CGPoint(x: 1.4 * self.size.width/10, y: 12 * self.size.height/10)
        chip6.zPosition = 2
        self.addChild(chip6)
        chip7.setScale(CGFloat(0.5 * scaleModifier))
        chip7.position = CGPoint(x: 1.4 * self.size.width/10, y: 12 * self.size.height/10)
        chip7.zPosition = 3
        self.addChild(chip7)
        
        if nextScreen == true
        {
            
        }
        
        moveCards()
    }
    
    func moveCards()
    {
        let randomX1 = CGFloat.random(in: -self.size.width/25 ... self.size.width/25)
        let randomX2 = CGFloat.random(in: -self.size.width/25 ... self.size.width/25)
        print(randomX1)
        print(randomX2)
        
        let moveSpadesAce = SKAction.moveBy(x: randomX1, y: 6.5/10 * self.size.height, duration: 0.8)
        let moveHeartsAce = SKAction.moveBy(x: randomX2, y: 6.5/10 * self.size.height, duration: 0.8)
        Cards.sAce.run(moveSpadesAce)
        Cards.hAce.run(moveHeartsAce)
        
        let waitForWin = SKAction.wait(forDuration: 1.4)
        let win = SKAction.run(winPot)
        let waitForNext = SKAction.wait(forDuration: 1.0)
        let next = SKAction.run(ableToTap)
        let winSequence = SKAction.sequence([waitForWin, win, waitForNext, next])
        self.run(winSequence)
    }
    
    func winPot()
    {
        let randomX1 = CGFloat.random(in: -self.size.width/18 ... self.size.width/18)
        let randomX2 = CGFloat.random(in: -self.size.width/18 ... self.size.width/18)
        let randomX3 = CGFloat.random(in: -self.size.width/18 ... self.size.width/18)
        let randomX4 = CGFloat.random(in: -self.size.width/18 ... self.size.width/18)
        let randomX5 = CGFloat.random(in: -self.size.width/18 ... self.size.width/18)
        let randomX6 = CGFloat.random(in: -self.size.width/18 ... self.size.width/18)
        let randomX7 = CGFloat.random(in: -self.size.width/18 ... self.size.width/18)
        
        
        let moveChip1 = SKAction.moveBy(x: randomX1, y: -9/10 * self.size.height, duration: 0.8)
        let moveChip2 = SKAction.moveBy(x: randomX2, y: -9/10 * self.size.height, duration: 0.8)
        let moveChip3 = SKAction.moveBy(x: randomX3, y: -8.6/10 * self.size.height, duration: 0.8)
        let moveChip4 = SKAction.moveBy(x: randomX4, y: -8.7/10 * self.size.height, duration: 0.8)
        let moveChip5 = SKAction.moveBy(x: randomX5, y: -8.8/10 * self.size.height, duration: 0.8)
        let moveChip6 = SKAction.moveBy(x: randomX6, y: -9.4/10 * self.size.height, duration: 0.8)
        let moveChip7 = SKAction.moveBy(x: randomX7, y: -9/10 * self.size.height, duration: 0.8)
        
        chip1.run(moveChip1)
        chip2.run(moveChip2)
        chip3.run(moveChip3)
        chip4.run(moveChip4)
        chip5.run(moveChip5)
        chip6.run(moveChip6)
        chip7.run(moveChip7)
    }
    
    func ableToTap()
    {
        nextScreen = true
        ttpLabel.fontName = "Copperplate-Light"
        ttpLabel.text = "Tap to Progress"
        ttpLabel.fontSize = CGFloat(38 * scaleModifier)
        ttpLabel.fontColor = SKColor.white
        ttpLabel.position = CGPoint(x: self.size.width/2, y: 1.5 * self.size.height/10)
        ttpLabel.zPosition = 10
        
        let fadeInFadeOut = SKAction.sequence([SKAction.fadeIn(withDuration: 1.0),SKAction.fadeOut(withDuration: 1.0)])
        ttpLabel.run( SKAction.repeatForever(fadeInFadeOut))
        self.addChild(ttpLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for _: AnyObject in touches
        {
            if nextScreen == true
            {
                self.removeAllChildren()
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
    }
}
