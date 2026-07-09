//
//  checkHand.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/7/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class checkYourCards: SKScene
{
    let gameArea: CGRect
    
    let background = SKSpriteNode(imageNamed: "background")
    let card1 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card1")!)
    let card2 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card2")!)
    let questionLabel = SKLabelNode()
    
    let yesLabel = SKLabelNode()
    let noLabel = SKLabelNode()
    let yesButton = SKSpriteNode(imageNamed: "yesLabel")
    let noButton = SKSpriteNode(imageNamed: "noLabel")
    
    var sceneToMoveTo = SKScene()
    var Scaler = CGFloat()
    
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
        //Scalers
        if (defaults.double(forKey: "FrameWidth") == 896 && defaults.double(forKey: "FrameHeight") == 414) || (defaults.double(forKey: "FrameWidth") == 375 && defaults.double(forKey: "FrameHeight") == 812)
        {
            Scaler = 1
        }else{
            if (defaults.double(forKey: "FrameWidth") == 736 && defaults.double(forKey: "FrameHeight") == 414)
            {
                Scaler = CGFloat(0.86)
            }else{
                Scaler = CGFloat(scaleModifier)
            }
        }
        
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        card1.setScale(0.25 * Scaler)
        card1.position = CGPoint(x: 2.5 * self.size.width/6, y: self.size.height/2)
        card1.zPosition = 1
        card1.alpha = 0
        self.addChild(card1)
        
        card2.setScale(0.25 * Scaler)
        card2.position = CGPoint(x: 3.5 * self.size.width/6, y: self.size.height/2)
        card2.zPosition = 1
        card2.alpha = 0
        self.addChild(card2)
        
        //Labels
        questionLabel.fontName = "Copperplate-Light"
        questionLabel.text = "is this your hand?"
        questionLabel.fontSize = 50 * Scaler
        questionLabel.fontColor = SKColor.white
        questionLabel.position = CGPoint(x: self.size.width/2, y: 8 * self.size.height/10)
        questionLabel.zPosition = 10
        questionLabel.alpha = 0
        self.addChild(questionLabel)
        
        //Labels
        yesButton.setScale(0.8 * Scaler)
        yesButton.position = CGPoint(x: 2.5 * self.size.width/6, y: 1.7 * self.size.height/10)
        yesButton.zPosition = 1
        //self.addChild(yesButton)
        noButton.setScale(0.8 * Scaler)
        noButton.position = CGPoint(x: 3.5 * self.size.width/6, y: 1.7 * self.size.height/10)
        noButton.zPosition = 1
        //self.addChild(noButton)
        
        yesLabel.fontName = "Copperplate-Light"
        yesLabel.text = "yes"
        yesLabel.fontSize = 50 * Scaler
        yesLabel.fontColor = SKColor.white
        yesLabel.position = CGPoint(x: 2.5 * self.size.width/6, y: 1.7 * self.size.height/10)
        yesLabel.zPosition = 10
        yesLabel.alpha = 0
        self.addChild(yesLabel)
        
        noLabel.fontName = "Copperplate-Light"
        noLabel.text = "no"
        noLabel.fontSize = 50 * Scaler
        noLabel.fontColor = SKColor.white
        noLabel.position = CGPoint(x: 3.5 * self.size.width/6, y: 1.7 * self.size.height/10)
        noLabel.zPosition = 10
        noLabel.alpha = 0
        self.addChild(noLabel)
        
        fadeIn()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            let buttonWidth = yesButton.size.width
            let buttonHeight = noButton.size.height
            
            if (pointOfTouch.x > (2.5 * self.size.width/6 - buttonWidth/2) && pointOfTouch.x < (2.5 * self.size.width/6 + buttonWidth/2)) && (pointOfTouch.y > (8.3 * self.size.height/10 - buttonHeight/2) && pointOfTouch.y < (8.3 * self.size.height/10 + buttonHeight/2))
            {
                //self.removeAllChildren()
                if defaults.double(forKey: "gameMode") == 0
                {
                    fadeOut(exitNumber: 0)
                }else{
                    if defaults.double(forKey: "gameMode") == 1
                    {
                        fadeOut(exitNumber: 1)
                    }
                }
            }
            
            if (pointOfTouch.x > (3.5 * self.size.width/6 - buttonWidth/2) && pointOfTouch.x < (3.5 * self.size.width/6 + buttonWidth/2)) && (pointOfTouch.y > (8.3 * self.size.height/10 - buttonHeight/2) && pointOfTouch.y < (8.3 * self.size.height/10 + buttonHeight/2))
            {
                defaults.set("None", forKey: "Card1")
                defaults.set("None", forKey: "Card2")
                //print(defaults.string(forKey: "Card1") as Any)
                fadeOut(exitNumber: 2)
            }
        }
    }
    
    func fadeIn()
    {
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        
        card1.run(fadeIn); card2.run(fadeIn)
        questionLabel.run(fadeIn); yesLabel.run(fadeIn); noLabel.run(fadeIn)
    }
    
    func fadeOut(exitNumber: Int)
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        card1.run(fadeOut); card2.run(fadeOut)
        questionLabel.run(fadeOut); yesLabel.run(fadeOut); noLabel.run(fadeOut)
        
        if exitNumber == 0
        {
            sceneToMoveTo = gamePlay(size: self.size)
        }
        if exitNumber == 1
        {
            sceneToMoveTo = gamePlaySim(size: self.size)
        }
        if exitNumber == 2
        {
            sceneToMoveTo = GameScene(size: self.size)
        }
        
        let seq = SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run(exit)])
        self.run(seq)
    }
    
    func exit()
    {
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
