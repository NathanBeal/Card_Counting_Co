//
//  GameScene2.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/7/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class GameSceneFlop: SKScene
{
    let background = SKSpriteNode(imageNamed: "background")
    let diamonds = SKSpriteNode(imageNamed: "Diamond")
    let hearts = SKSpriteNode(imageNamed: "Heart")
    let clubs = SKSpriteNode(imageNamed: "Clubs")
    let spades = SKSpriteNode(imageNamed: "Spades")
    let selectLabel = SKLabelNode()
    let gameArea: CGRect
    var Scaler = CGFloat()
    
    var sceneToMoveTo = SKScene()
    
    var temp = SKSpriteNode()
    var temp2 = SKSpriteNode()
    var temp3 = SKSpriteNode()
    
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
        //print("stuck herer")
        checkHand()
        
        //Scalers
        if (defaults.double(forKey: "FrameWidth") == 896 && defaults.double(forKey: "FrameHeight") == 414) || (defaults.double(forKey: "FrameWidth") == 375 && defaults.double(forKey: "FrameHeight") == 812)
        {
            Scaler = 0.9
        }else{
            if (defaults.double(forKey: "FrameWidth") == 736 && defaults.double(forKey: "FrameHeight") == 414)
            {
                Scaler = CGFloat(0.82)
            }else{
                Scaler = CGFloat(scaleModifier)
            }
        }
        
        displayCards()
        
        //Background
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        //Cards
        hearts.setScale(CGFloat(0.33 * Scaler))
        hearts.position = CGPoint(x: 1.5 * self.size.width/6, y: self.size.height/2)
        hearts.zPosition = 1
        hearts.alpha = 0
        self.addChild(hearts)
    
        clubs.setScale(CGFloat(0.33 * Scaler))
        clubs.position = CGPoint(x: 2.5 * self.size.width/6, y: self.size.height/2)
        clubs.zPosition = 1
        clubs.alpha = 0
        self.addChild(clubs)
        
        diamonds.setScale(CGFloat(0.33 * Scaler))
        diamonds.position = CGPoint(x: 3.5 * self.size.width/6, y: self.size.height/2)
        diamonds.zPosition = 1
        diamonds.alpha = 0
        self.addChild(diamonds)
        
        spades.setScale(CGFloat(0.33 * Scaler))
        spades.position = CGPoint(x: 4.5 * self.size.width/6, y: self.size.height/2)
        spades.zPosition = 1
        spades.alpha = 0
        self.addChild(spades)
        
        selectLabel.fontName = "Copperplate-Light"
        selectLabel.text = "select flop cards"
        selectLabel.fontSize = (CGFloat(50 * Scaler))
        selectLabel.fontColor = SKColor.white
        selectLabel.position = CGPoint(x: self.size.width/2, y: 8 * self.size.height/10)
        selectLabel.zPosition = 10
        selectLabel.alpha = 0
        self.addChild(selectLabel)
        
        fadeIn()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            let cardWidth = hearts.size.width
            let cardHeight = hearts.size.height
            
            //Heart Card
            if (pointOfTouch.x > (1.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x < (1.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                fadeOut(exitNumber: 0)
            }
            
            //Club Card
            if (pointOfTouch.x > (2.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x < (2.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                fadeOut(exitNumber: 1)
            }
            
            //Diamond Card
            if (pointOfTouch.x > (3.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x < (3.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                fadeOut(exitNumber: 2)
            }
            
            //Spade Card
            if (pointOfTouch.x > (4.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x < (4.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                fadeOut(exitNumber: 3)
            }
        }
    }
    
    //**
    func checkHand()
    {
        if defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") != "None"
        {
            if defaults.double(forKey: "gameMode") == 0
            {
                SKIPOVER(exitNumber: 0)
            }else{
                if defaults.double(forKey: "gameMode") == 1
                {
                    SKIPOVER(exitNumber: 1)
                }
            }
        }
    }
    
    func displayCards()
    {
        let key1 = defaults.string(forKey: "Flop1")
        let key2 = defaults.string(forKey: "Flop2")
        let key3 = defaults.string(forKey: "Flop3")
        
        if key1 != "None" && key2 == "None" && key3 == "None"
        {
            temp = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop1")!)
            
            temp.setScale(CGFloat(0.1667 * Scaler))
            temp.position = CGPoint(x: self.size.width/2, y: 1.5 * self.size.height/10)
            temp.zPosition = 1
            temp.alpha = 0
            self.addChild(temp)
        }
        
        if key1 != "None" && key2 != "None" && key3 == "None"
        {
            temp = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop1")!)
            
            temp.setScale(CGFloat(0.1667 * Scaler))
            temp.position = CGPoint(x: self.size.width/2 - self.size.width/22, y: 1.5 * self.size.height/10)
            temp.zPosition = 1
            temp.alpha = 0
            self.addChild(temp)
            
            temp2 = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop2")!)
            temp2.setScale(CGFloat(0.1667 * Scaler))
            temp2.position = CGPoint(x: self.size.width/2 + self.size.width/22, y: 1.5 * self.size.height/10)
            temp2.zPosition = 1
            temp2.alpha = 0
            self.addChild(temp2)
        }
        
        if key1 != "None" && key2 != "None" && key3 != "None"
        {
            temp = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop1")!)
            
            temp.setScale(CGFloat(0.1667 * Scaler))
            temp.position = CGPoint(x: self.size.width/2.45, y: 1.5 * self.size.height/10)
            temp.zPosition = 1
            temp.alpha = 0
            self.addChild(temp)
            
            temp2 = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop2")!)
            temp2.setScale(CGFloat(0.1667 * Scaler))
            temp2.position = CGPoint(x: self.size.width/2, y: 1.5 * self.size.height/10)
            temp2.zPosition = 1
            temp2.alpha = 0
            self.addChild(temp2)
            
            temp3 = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop3")!)
            temp3.setScale(CGFloat(0.1667 * Scaler))
            temp3.position = CGPoint(x: self.size.width/1.65, y: 1.5 * self.size.height/10)
            temp3.zPosition = 1
            temp3.alpha = 0
            self.addChild(temp3)
        }
    }
    
    func fadeIn()
    {
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        hearts.run(fadeIn); clubs.run(fadeIn); diamonds.run(fadeIn); spades.run(fadeIn)
        selectLabel.run(fadeIn); //generatedHand.run(fadeIn)
        temp.run(fadeIn); temp2.run(fadeIn); temp3.run(fadeIn)
    }
    
    func fadeOut(exitNumber: Int)
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        hearts.run(fadeOut); clubs.run(fadeOut); diamonds.run(fadeOut); spades.run(fadeOut)
        selectLabel.run(fadeOut);//generatedHand.run(fadeOut)
        temp.run(fadeOut); temp2.run(fadeOut); temp3.run(fadeOut)
        
        if exitNumber == 0
        {
            sceneToMoveTo = heartSelectFlop(size: self.size)
        }
        if exitNumber == 1
        {
            sceneToMoveTo = clubSelectFlop(size: self.size)
        }
        if exitNumber == 2
        {
            sceneToMoveTo = diamondSelectFlop(size: self.size)
        }
        if exitNumber == 3
        {
            sceneToMoveTo = spadeSelectFlop(size: self.size)
        }
        
        let seq = SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run(exit)])
        self.run(seq)
    }
    
    func SKIPOVER(exitNumber: Int)
    {
        if exitNumber == 0
        {
            sceneToMoveTo = gamePlay(size: self.size)
        }
        if exitNumber == 1
        {
            sceneToMoveTo = gamePlaySim(size: self.size)
        }
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func exit()
    {
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
