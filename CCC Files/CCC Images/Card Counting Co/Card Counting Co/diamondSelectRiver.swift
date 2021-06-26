//
//  diamondSelectRiver.swift
//  Card Counting Co
//
//  Created by ADAMLANE on 6/8/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class diamondSelectRiver: SKScene
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
        
        Cards.dAce.setScale(0.10)
        Cards.dAce.position = CGPoint(x: 2 * self.size.width/16, y: self.size.height/2)
        Cards.dAce.zPosition = 1
        self.addChild(Cards.dAce)
        
        Cards.dTwo.setScale(0.10)
        Cards.dTwo.position = CGPoint(x:  3 * self.size.width/16, y: self.size.height/2)
        Cards.dTwo.zPosition = 1
        self.addChild(Cards.dTwo)
        
        Cards.dThree.setScale(0.10)
        Cards.dThree.position = CGPoint(x: 4 * self.size.width/16, y: self.size.height/2)
        Cards.dThree.zPosition = 1
        self.addChild(Cards.dThree)
        
        Cards.dFour.setScale(0.10)
        Cards.dFour.position = CGPoint(x: 5 * self.size.width/16, y: self.size.height/2)
        Cards.dFour.zPosition = 1
        self.addChild(Cards.dFour)
        
        Cards.dFive.setScale(0.10)
        Cards.dFive.position = CGPoint(x: 6 * self.size.width/16, y: self.size.height/2)
        Cards.dFive.zPosition = 1
        self.addChild(Cards.dFive)
        
        Cards.dSix.setScale(0.10)
        Cards.dSix.position = CGPoint(x: 7 * self.size.width/16, y: self.size.height/2)
        Cards.dSix.zPosition = 1
        self.addChild(Cards.dSix)
        
        Cards.dSeven.setScale(0.10)
        Cards.dSeven.position = CGPoint(x: 8 * self.size.width/16, y: self.size.height/2)
        Cards.dSeven.zPosition = 1
        self.addChild(Cards.dSeven)
        
        Cards.dEight.setScale(0.10)
        Cards.dEight.position = CGPoint(x: 9 * self.size.width/16, y: self.size.height/2)
        Cards.dEight.zPosition = 1
        self.addChild(Cards.dEight)
        
        Cards.dNine.setScale(0.10)
        Cards.dNine.position = CGPoint(x: 10 * self.size.width/16, y: self.size.height/2)
        Cards.dNine.zPosition = 1
        self.addChild(Cards.dNine)
        
        Cards.dTen.setScale(0.10)
        Cards.dTen.position = CGPoint(x: 11 * self.size.width/16, y: self.size.height/2)
        Cards.dTen.zPosition = 1
        self.addChild(Cards.dTen)
        
        Cards.dJack.setScale(0.10)
        Cards.dJack.position = CGPoint(x: 12 * self.size.width/16, y: self.size.height/2)
        Cards.dJack.zPosition = 1
        self.addChild(Cards.dJack)
        
        Cards.dQueen.setScale(0.10)
        Cards.dQueen.position = CGPoint(x: 13 * self.size.width/16, y: self.size.height/2)
        Cards.dQueen.zPosition = 1
        self.addChild(Cards.dQueen)
        
        Cards.dKing.setScale(0.10)
        Cards.dKing.position = CGPoint(x: 14 * self.size.width/16, y: self.size.height/2)
        Cards.dKing.zPosition = 1
        self.addChild(Cards.dKing)
    }
    
    func changeScene()
    {
        let sceneToMoveTo = GameSceneRiver(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  1.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            let cardWidth = Cards.hAce.size.width
            let cardHeight = Cards.hAce.size.height
            
            //Choose Diamonds Card
            if (pointOfTouch.x > (2 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (2 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Diamond - Ace", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.dAce.run(moveCard)
                
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
                    defaults.set("Diamond - Two", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.dTwo.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (4 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (4 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Diamond - Three", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.dThree.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (5 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (5 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Diamond - Four", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.dFour.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (6 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (6 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Diamond - Five", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.dFive.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (7 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (7 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Diamond - Six", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.dSix.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (8 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (8 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Diamond - Seven", forKey: "River")
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
                    defaults.set("Diamond - Eight", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.dEight.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (10 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (10 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Diamond - Nine", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.dNine.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (11 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (11 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Diamond - Ten", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.dTen.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (12 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (12 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Diamond - Jack", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.dJack.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (13 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (13 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Diamond - Queen", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.dQueen.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
            if (pointOfTouch.x > (14 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (14 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                
                if (defaults.string(forKey: "River") == "None")
                {
                    defaults.set("Diamond - King", forKey: "River")
                }
                
                let moveCard = SKAction.moveTo(y: self.size.height/2 + 50, duration: 0.5)
                Cards.dKing.run(moveCard)
                
                let step1 = SKAction.run(changeScene)
                let step2 = SKAction.wait(forDuration:  0.5)
                let changeSequence = SKAction.sequence([step2, step1])
                self.run(changeSequence)
            }
            
        }
    }
}
