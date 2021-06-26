//
//  spadeSelectFlop.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/8/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class spadeSelectFlop: SKScene
{
    let gameArea: CGRect
    let background = SKSpriteNode(imageNamed: "background")
    
    override init(size: CGSize)
    {
        let maxAspectRatio : CGFloat = 16.0/9.0
        let playableWidth = size.height/maxAspectRatio
        let margin = (size.width - playableWidth)/4
        gameArea = CGRect(x: margin, y: 0, width: playableWidth + margin, height: size.height)
        
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
        
        Cards.sAce.setScale(0.10)
        Cards.sAce.position = CGPoint(x: 2 * self.size.width/16, y: self.size.height/2)
        Cards.sAce.zPosition = 1
        self.addChild(Cards.sAce)
        
        Cards.sTwo.setScale(0.10)
        Cards.sTwo.position = CGPoint(x:  3 * self.size.width/16, y: self.size.height/2)
        Cards.sTwo.zPosition = 1
        self.addChild(Cards.sTwo)
        
        Cards.sThree.setScale(0.10)
        Cards.sThree.position = CGPoint(x: 4 * self.size.width/16, y: self.size.height/2)
        Cards.sThree.zPosition = 1
        self.addChild(Cards.sThree)
        
        Cards.sFour.setScale(0.10)
        Cards.sFour.position = CGPoint(x: 5 * self.size.width/16, y: self.size.height/2)
        Cards.sFour.zPosition = 1
        self.addChild(Cards.sFour)
        
        Cards.sFive.setScale(0.10)
        Cards.sFive.position = CGPoint(x: 6 * self.size.width/16, y: self.size.height/2)
        Cards.sFive.zPosition = 1
        self.addChild(Cards.sFive)
        
        Cards.sSix.setScale(0.10)
        Cards.sSix.position = CGPoint(x: 7 * self.size.width/16, y: self.size.height/2)
        Cards.sSix.zPosition = 1
        self.addChild(Cards.sSix)
        
        Cards.sSeven.setScale(0.10)
        Cards.sSeven.position = CGPoint(x: 8 * self.size.width/16, y: self.size.height/2)
        Cards.sSeven.zPosition = 1
        self.addChild(Cards.sSeven)
        
        Cards.sEight.setScale(0.10)
        Cards.sEight.position = CGPoint(x: 9 * self.size.width/16, y: self.size.height/2)
        Cards.sEight.zPosition = 1
        self.addChild(Cards.sEight)
        
        Cards.sNine.setScale(0.10)
        Cards.sNine.position = CGPoint(x: 10 * self.size.width/16, y: self.size.height/2)
        Cards.sNine.zPosition = 1
        self.addChild(Cards.sNine)
        
        Cards.sTen.setScale(0.10)
        Cards.sTen.position = CGPoint(x: 11 * self.size.width/16, y: self.size.height/2)
        Cards.sTen.zPosition = 1
        self.addChild(Cards.sTen)
        
        Cards.sJack.setScale(0.10)
        Cards.sJack.position = CGPoint(x: 12 * self.size.width/16, y: self.size.height/2)
        Cards.sJack.zPosition = 1
        self.addChild(Cards.sJack)
        
        Cards.sQueen.setScale(0.10)
        Cards.sQueen.position = CGPoint(x: 13 * self.size.width/16, y: self.size.height/2)
        Cards.sQueen.zPosition = 1
        self.addChild(Cards.sQueen)
        
        Cards.sKing.setScale(0.10)
        Cards.sKing.position = CGPoint(x: 14 * self.size.width/16, y: self.size.height/2)
        Cards.sKing.zPosition = 1
        self.addChild(Cards.sKing)
    }
    
    func changeScene()
    {
        let sceneToMoveTo = GameSceneFlop(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  1.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            //print("\(pointOfTouch.x)   \(pointOfTouch.y)")
            let cardWidth = Cards.hAce.size.width
            let cardHeight = Cards.hAce.size.height
            
            //Choose Spade Card
            if (pointOfTouch.x > (2 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (2 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "Flop1") == "None")
                {
                    defaults.set("Spades - Ace", forKey: "Flop1")
                }else{
                    if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") == "None")
                    {
                        defaults.set("Spades - Ace", forKey: "Flop2")
                    }else{
                        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") == "None" )
                        {
                            defaults.set("Spades - Ace", forKey: "Flop3")
                        }
                    }
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.sAce.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            //Two
            if (pointOfTouch.x > (3 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (3 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "Flop1") == "None")
                {
                    defaults.set("Spades - Two", forKey: "Flop1")
                }else{
                    if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") == "None")
                    {
                        defaults.set("Spades - Two", forKey: "Flop2")
                    }else{
                        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") == "None" )
                        {
                            defaults.set("Spades - Two", forKey: "Flop3")
                        }
                    }
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.sTwo.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (4 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (4 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "Flop1") == "None")
                {
                    defaults.set("Spades - Three", forKey: "Flop1")
                }else{
                    if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") == "None")
                    {
                        defaults.set("Spades - Three", forKey: "Flop2")
                    }else{
                        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") == "None" )
                        {
                            defaults.set("Spades - Three", forKey: "Flop3")
                        }
                    }
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.sThree.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (5 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (5 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "Flop1") == "None")
                {
                    defaults.set("Spades - Four", forKey: "Flop1")
                }else{
                    if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") == "None")
                    {
                        defaults.set("Spades - Four", forKey: "Flop2")
                    }else{
                        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") == "None" )
                        {
                            defaults.set("Spades - Four", forKey: "Flop3")
                        }
                    }
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.sFour.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (6 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (6 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "Flop1") == "None")
                {
                    defaults.set("Spades - Five", forKey: "Flop1")
                }else{
                    if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") == "None")
                    {
                        defaults.set("Spades - Five", forKey: "Flop2")
                    }else{
                        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") == "None" )
                        {
                            defaults.set("Spades - Five", forKey: "Flop3")
                        }
                    }
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.sFive.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (7 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (7 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "Flop1") == "None")
                {
                    defaults.set("Spades - Six", forKey: "Flop1")
                }else{
                    if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") == "None")
                    {
                        defaults.set("Spades - Six", forKey: "Flop2")
                    }else{
                        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") == "None" )
                        {
                            defaults.set("Spades - Six", forKey: "Flop3")
                        }
                    }
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.sSix.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (8 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (8 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "Flop1") == "None")
                {
                    defaults.set("Spades - Seven", forKey: "Flop1")
                }else{
                    if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") == "None")
                    {
                        defaults.set("Spades - Seven", forKey: "Flop2")
                    }else{
                        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") == "None" )
                        {
                            defaults.set("Spades - Seven", forKey: "Flop3")
                        }
                    }
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.sSeven.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (9 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (9 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "Flop1") == "None")
                {
                    defaults.set("Spades - Eight", forKey: "Flop1")
                }else{
                    if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") == "None")
                    {
                        defaults.set("Spades - Eight", forKey: "Flop2")
                    }else{
                        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") == "None" )
                        {
                            defaults.set("Spades - Eight", forKey: "Flop3")
                        }
                    }
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.sEight.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (10 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (10 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "Flop1") == "None")
                {
                    defaults.set("Spades - Nine", forKey: "Flop1")
                }else{
                    if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") == "None")
                    {
                        defaults.set("Spades - Nine", forKey: "Flop2")
                    }else{
                        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") == "None" )
                        {
                            defaults.set("Spades - Nine", forKey: "Flop3")
                        }
                    }
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.sNine.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (11 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (11 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "Flop1") == "None")
                {
                    defaults.set("Spades - Ten", forKey: "Flop1")
                }else{
                    if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") == "None")
                    {
                        defaults.set("Spades - Ten", forKey: "Flop2")
                    }else{
                        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") == "None" )
                        {
                            defaults.set("Spades - Ten", forKey: "Flop3")
                        }
                    }
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.sTen.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (12 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (12 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "Flop1") == "None")
                {
                    defaults.set("Spades - Jack", forKey: "Flop1")
                }else{
                    if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") == "None")
                    {
                        defaults.set("Spades - Jack", forKey: "Flop2")
                    }else{
                        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") == "None" )
                        {
                            defaults.set("Spades - Jack", forKey: "Flop3")
                        }
                    }
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.sJack.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (13 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (13 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "Flop1") == "None")
                {
                    defaults.set("Spades - Queen", forKey: "Flop1")
                }else{
                    if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") == "None")
                    {
                        defaults.set("Spades - Queen", forKey: "Flop2")
                    }else{
                        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") == "None" )
                        {
                            defaults.set("Spades - Queen", forKey: "Flop3")
                        }
                    }
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.sQueen.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (14 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (14 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                
                if (defaults.string(forKey: "Flop1") == "None")
                {
                    defaults.set("Spades - King", forKey: "Flop1")
                }else{
                    if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") == "None")
                    {
                        defaults.set("Spades - King", forKey: "Flop2")
                    }else{
                        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") == "None" )
                        {
                            defaults.set("Spades - King", forKey: "Flop3")
                        }
                    }
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.sKing.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
        }
    }
}

