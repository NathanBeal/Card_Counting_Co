//
//  clubSelect.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/5/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class clubSelect: SKScene
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
        
        Cards.cAce.setScale(0.10)
        Cards.cAce.position = CGPoint(x: 2 * self.size.width/16, y: self.size.height/2)
        Cards.cAce.zPosition = 1
        self.addChild(Cards.cAce)
        
        Cards.cTwo.setScale(0.10)
        Cards.cTwo.position = CGPoint(x:  3 * self.size.width/16, y: self.size.height/2)
        Cards.cTwo.zPosition = 1
        self.addChild(Cards.cTwo)
        
        Cards.cThree.setScale(0.10)
        Cards.cThree.position = CGPoint(x: 4 * self.size.width/16, y: self.size.height/2)
        Cards.cThree.zPosition = 1
        self.addChild(Cards.cThree)
        
        Cards.cFour.setScale(0.10)
        Cards.cFour.position = CGPoint(x: 5 * self.size.width/16, y: self.size.height/2)
        Cards.cFour.zPosition = 1
        self.addChild(Cards.cFour)
        
        Cards.cFive.setScale(0.10)
        Cards.cFive.position = CGPoint(x: 6 * self.size.width/16, y: self.size.height/2)
        Cards.cFive.zPosition = 1
        self.addChild(Cards.cFive)
        
        Cards.cSix.setScale(0.10)
        Cards.cSix.position = CGPoint(x: 7 * self.size.width/16, y: self.size.height/2)
        Cards.cSix.zPosition = 1
        self.addChild(Cards.cSix)
        
        Cards.cSeven.setScale(0.10)
        Cards.cSeven.position = CGPoint(x: 8 * self.size.width/16, y: self.size.height/2)
        Cards.cSeven.zPosition = 1
        self.addChild(Cards.cSeven)
        
        Cards.cEight.setScale(0.10)
        Cards.cEight.position = CGPoint(x: 9 * self.size.width/16, y: self.size.height/2)
        Cards.cEight.zPosition = 1
        self.addChild(Cards.cEight)
        
        Cards.cNine.setScale(0.10)
        Cards.cNine.position = CGPoint(x: 10 * self.size.width/16, y: self.size.height/2)
        Cards.cNine.zPosition = 1
        self.addChild(Cards.cNine)
        
        Cards.cTen.setScale(0.10)
        Cards.cTen.position = CGPoint(x: 11 * self.size.width/16, y: self.size.height/2)
        Cards.cTen.zPosition = 1
        self.addChild(Cards.cTen)
        
        Cards.cJack.setScale(0.10)
        Cards.cJack.position = CGPoint(x: 12 * self.size.width/16, y: self.size.height/2)
        Cards.cJack.zPosition = 1
        self.addChild(Cards.cJack)
        
        Cards.cQueen.setScale(0.10)
        Cards.cQueen.position = CGPoint(x: 13 * self.size.width/16, y: self.size.height/2)
        Cards.cQueen.zPosition = 1
        self.addChild(Cards.cQueen)
        
        Cards.cKing.setScale(0.10)
        Cards.cKing.position = CGPoint(x: 14 * self.size.width/16, y: self.size.height/2)
        Cards.cKing.zPosition = 1
        self.addChild(Cards.cKing)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            //print("\(pointOfTouch.x)   \(pointOfTouch.y)")
            let cardWidth = Cards.hAce.size.width
            let cardHeight = Cards.hAce.size.height
            
            //Choose Clubs Card
            if (pointOfTouch.x > (2 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (2 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if defaults.string(forKey: "Card1") == "None"
                {
                    defaults.set("Clubs - Ace", forKey: "Card1")
                }else{
                    defaults.set("Clubs - Ace", forKey: "Card2")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.cAce.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (3 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (3 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if defaults.string(forKey: "Card1") == "None"
                {
                    defaults.set("Clubs - Two", forKey: "Card1")
                }else{
                    defaults.set("Clubs - Two", forKey: "Card2")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.cTwo.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (4 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (4 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if defaults.string(forKey: "Card1") == "None"
                {
                    defaults.set("Clubs - Three", forKey: "Card1")
                }else{
                    defaults.set("Clubs - Three", forKey: "Card2")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.cThree.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (5 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (5 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if defaults.string(forKey: "Card1") == "None"
                {
                    defaults.set("Clubs - Four", forKey: "Card1")
                }else{
                    defaults.set("Clubs - Four", forKey: "Card2")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.cFour.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            
            if (pointOfTouch.x > (6 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (6 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if defaults.string(forKey: "Card1") == "None"
                {
                    defaults.set("Clubs - Five", forKey: "Card1")
                }else{
                    defaults.set("Clubs - Five", forKey: "Card2")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.cFive.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (7 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (7 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if defaults.string(forKey: "Card1") == "None"
                {
                    defaults.set("Clubs - Six", forKey: "Card1")
                }else{
                    defaults.set("Clubs - Six", forKey: "Card2")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.cSix.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (8 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (8 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if defaults.string(forKey: "Card1") == "None"
                {
                    defaults.set("Clubs - Seven", forKey: "Card1")
                }else{
                    defaults.set("Clubs - Seven", forKey: "Card2")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.cSeven.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (9 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (9 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if defaults.string(forKey: "Card1") == "None"
                {
                    defaults.set("Clubs - Eight", forKey: "Card1")
                }else{
                    defaults.set("Clubs - Eight", forKey: "Card2")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.cEight.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (10 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (10 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if defaults.string(forKey: "Card1") == "None"
                {
                    defaults.set("Clubs - Nine", forKey: "Card1")
                }else{
                    defaults.set("Clubs - Nine", forKey: "Card2")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.cNine.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (11 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (11 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if defaults.string(forKey: "Card1") == "None"
                {
                    defaults.set("Clubs - Ten", forKey: "Card1")
                }else{
                    defaults.set("Clubs - Ten", forKey: "Card2")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.cTen.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (12 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (12 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if defaults.string(forKey: "Card1") == "None"
                {
                    defaults.set("Clubs - Jack", forKey: "Card1")
                }else{
                    defaults.set("Clubs - Jack", forKey: "Card2")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.cJack.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (13 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (13 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if defaults.string(forKey: "Card1") == "None"
                {
                    defaults.set("Clubs - Queen", forKey: "Card1")
                }else{
                    defaults.set("Clubs - Queen", forKey: "Card2")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.cQueen.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (14 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (14 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if defaults.string(forKey: "Card1") == "None"
                {
                    defaults.set("Clubs - King", forKey: "Card1")
                }else{
                    defaults.set("Clubs - King", forKey: "Card2")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.cKing.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
        }
    }
    
    func changeScene()
    {
        self.removeAllChildren()
        let sceneToMoveTo = GameScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  1.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
