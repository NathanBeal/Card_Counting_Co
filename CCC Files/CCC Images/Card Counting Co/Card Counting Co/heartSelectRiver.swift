//
//  heartSelectRiver.swift
//  Card Counting Co
//
//  Created by ADAMLANE on 6/8/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class heartSelectRiver: SKScene
{
    let gameArea: CGRect
    let background = SKSpriteNode(imageNamed: "background")
    
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
        
        
        //Cards
        Cards.hAce.setScale(0.10)
        Cards.hAce.position = CGPoint(x: 2 * self.size.width/16, y: self.size.height/2)
        Cards.hAce.zPosition = 1
        self.addChild(Cards.hAce)
        
        Cards.hTwo.setScale(0.10)
        Cards.hTwo.position = CGPoint(x:  3 * self.size.width/16, y: self.size.height/2)
        Cards.hTwo.zPosition = 1
        self.addChild(Cards.hTwo)
        
        Cards.hThree.setScale(0.10)
        Cards.hThree.position = CGPoint(x: 4 * self.size.width/16, y: self.size.height/2)
        Cards.hThree.zPosition = 1
        self.addChild(Cards.hThree)
        
        Cards.hFour.setScale(0.10)
        Cards.hFour.position = CGPoint(x: 5 * self.size.width/16, y: self.size.height/2)
        Cards.hFour.zPosition = 1
        self.addChild(Cards.hFour)
        
        Cards.hFive.setScale(0.10)
        Cards.hFive.position = CGPoint(x: 6 * self.size.width/16, y: self.size.height/2)
        Cards.hFive.zPosition = 1
        self.addChild(Cards.hFive)
        
        Cards.hSix.setScale(0.10)
        Cards.hSix.position = CGPoint(x: 7 * self.size.width/16, y: self.size.height/2)
        Cards.hSix.zPosition = 1
        self.addChild(Cards.hSix)
        
        Cards.hSeven.setScale(0.10)
        Cards.hSeven.position = CGPoint(x: 8 * self.size.width/16, y: self.size.height/2)
        Cards.hSeven.zPosition = 1
        self.addChild(Cards.hSeven)
        
        Cards.hEight.setScale(0.10)
        Cards.hEight.position = CGPoint(x: 9 * self.size.width/16, y: self.size.height/2)
        Cards.hEight.zPosition = 1
        self.addChild(Cards.hEight)
        
        Cards.hNine.setScale(0.10)
        Cards.hNine.position = CGPoint(x: 10 * self.size.width/16, y: self.size.height/2)
        Cards.hNine.zPosition = 1
        self.addChild(Cards.hNine)
        
        Cards.hTen.setScale(0.10)
        Cards.hTen.position = CGPoint(x: 11 * self.size.width/16, y: self.size.height/2)
        Cards.hTen.zPosition = 1
        self.addChild(Cards.hTen)
        
        Cards.hJack.setScale(0.10)
        Cards.hJack.position = CGPoint(x: 12 * self.size.width/16, y: self.size.height/2)
        Cards.hJack.zPosition = 1
        self.addChild(Cards.hJack)
        
        Cards.hQueen.setScale(0.10)
        Cards.hQueen.position = CGPoint(x: 13 * self.size.width/16, y: self.size.height/2)
        Cards.hQueen.zPosition = 1
        self.addChild(Cards.hQueen)
        
        Cards.hKing.setScale(0.10)
        Cards.hKing.position = CGPoint(x: 14 * self.size.width/16, y: self.size.height/2)
        Cards.hKing.zPosition = 1
        self.addChild(Cards.hKing)
    }
    
    
    func changeScene()
    {
        self.removeAllChildren()
        let sceneToMoveTo = gamePlay(size: self.size)
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
            
            //Choose Hearts Card
            //Ace
            if (pointOfTouch.x > (2 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (2 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Heart - Ace", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.hAce.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            //Two
            if (pointOfTouch.x > (3 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (3 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Heart - Two", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.hTwo.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (4 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (4 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Heart - Three", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.hThree.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (5 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (5 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Heart - Four", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.hFour.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (6 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (6 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Heart - Five", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.hFive.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (7 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (7 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Heart - Six", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.hSix.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (8 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (8 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Heart - Seven", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.hSeven.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (9 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (9 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Heart - Eight", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.hEight.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (10 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (10 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Heart - Nine", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.hNine.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (11 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (11 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Heart - Ten", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.hTen.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (12 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (12 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Heart - Jack", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.hJack.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (13 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (13 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Heart - Queen", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.hQueen.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (14 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (14 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Heart - King", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.hKing.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
        }
    }
}
