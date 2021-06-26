//
//  clubSelectRiver.swift
//  Card Counting Co
//
//  Created by ADAMLANE on 6/8/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class clubSelectRiver: SKScene
{
    let gameArea: CGRect
    let background = SKSpriteNode(imageNamed: "background")
    let backArrow = SKSpriteNode(imageNamed: "backArr")
    var backArrXCoord = CGFloat()
    var backArrYCoord = CGFloat()
    var Scaler = CGFloat()
    let Directions = SKLabelNode()

    
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
        
        //Background
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        //Directions
        Directions.fontName = "Copperplate-Light"
        Directions.fontSize = CGFloat(40 * Scaler)
        Directions.fontColor = SKColor.white
        Directions.position = CGPoint(x: self.size.width/2, y: 8.5 * self.size.height/10)
        Directions.zPosition = 10
        Directions.text = "select your river card"
        Directions.alpha = 0
        self.addChild(Directions)
        
        //Cards
        Cards.cTwo.setScale(0.15 * Scaler)
        Cards.cTwo.position = CGPoint(x: 2.6 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.cTwo.zPosition = 1
        
        Cards.cThree.setScale(0.15 * Scaler)
        Cards.cThree.position = CGPoint(x: 4.2 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.cThree.zPosition = 1
        
        Cards.cFour.setScale(0.15 * Scaler)
        Cards.cFour.position = CGPoint(x: 5.8 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.cFour.zPosition = 1
        
        Cards.cFive.setScale(0.15 * Scaler)
        Cards.cFive.position = CGPoint(x: 7.4 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.cFive.zPosition = 1
        
        
        //Second Line
        Cards.cSix.setScale(0.15 * Scaler)
        Cards.cSix.position = CGPoint(x: 1.8 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.cSix.zPosition = 1
        
        Cards.cSeven.setScale(0.15 * Scaler)
        Cards.cSeven.position = CGPoint(x: 3.4 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.cSeven.zPosition = 1
        
        Cards.cEight.setScale(0.15 * Scaler)
        Cards.cEight.position = CGPoint(x: 5 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.cEight.zPosition = 1
        
        Cards.cNine.setScale(0.15 * Scaler)
        Cards.cNine.position = CGPoint(x: 6.6 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.cNine.zPosition = 1
        
        Cards.cTen.setScale(0.15 * Scaler)
        Cards.cTen.position = CGPoint(x: 8.2 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.cTen.zPosition = 1
        
        
        //Third Line
        Cards.cJack.setScale(0.15 * Scaler)
        Cards.cJack.position = CGPoint(x: 2.6 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.cJack.zPosition = 1
        
        Cards.cQueen.setScale(0.15 * Scaler)
        Cards.cQueen.position = CGPoint(x: 4.2 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.cQueen.zPosition = 1
        
        Cards.cKing.setScale(0.15 * Scaler)
        Cards.cKing.position = CGPoint(x: 5.8 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.cKing.zPosition = 1
        
        Cards.cAce.setScale(0.15 * Scaler)
        Cards.cAce.position = CGPoint(x: 7.4 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.cAce.zPosition = 1
        
        //Alphas
        backArrow.alpha = 0
        Directions.alpha = 0
        Cards.hTwo.alpha = 0
        Cards.hThree.alpha = 0
        Cards.hFour.alpha = 0
        Cards.hFive.alpha = 0
        Cards.hSix.alpha = 0
        Cards.hSeven.alpha = 0
        Cards.hEight.alpha = 0
        Cards.hNine.alpha = 0
        Cards.hTen.alpha = 0
        Cards.hJack.alpha = 0
        Cards.hQueen.alpha = 0
        Cards.hKing.alpha = 0
        Cards.hAce.alpha = 0
        
        //Back Arrow
        backArrow.setScale(CGFloat(0.65 * scaleModifier))
        //let Offset = self.size.height - backArrow.size.height/2 - 9 * self.size.height/10
        //backArrXCoord = Offset + backArrow.size.width/2
        //backArrYCoord = 9 * self.size.height/10
        backArrXCoord = (1.8 * self.size.width/10 -  Cards.cTwo.size.width/2)/2
        backArrYCoord = 4.5 * self.size.height/10
        backArrow.position = CGPoint(x: backArrXCoord, y: backArrYCoord)
        backArrow.zPosition = 10
        self.addChild(backArrow)
        
        //Checker
        if passes(Tester: "Clubs - 2") == true
        {
            self.addChild(Cards.cTwo)
        }
        if passes(Tester: "Clubs - 3") == true
        {
            self.addChild(Cards.cThree)
        }
        if passes(Tester: "Clubs - 4") == true
        {
            self.addChild(Cards.cFour)
        }
        if passes(Tester: "Clubs - 5") == true
        {
            self.addChild(Cards.cFive)
        }
        if passes(Tester: "Clubs - 6") == true
        {
            self.addChild(Cards.cSix)
        }
        if passes(Tester: "Clubs - 7") == true
        {
            self.addChild(Cards.cSeven)
        }
        if passes(Tester: "Clubs - 8") == true
        {
            self.addChild(Cards.cEight)
        }
        if passes(Tester: "Clubs - 9") == true
        {
            self.addChild(Cards.cNine)
        }
        if passes(Tester: "Clubs - 10") == true
        {
            self.addChild(Cards.cTen)
        }
        if passes(Tester: "Clubs - 11") == true
        {
            self.addChild(Cards.cJack)
        }
        if passes(Tester: "Clubs - 12") == true
        {
            self.addChild(Cards.cQueen)
        }
        if passes(Tester: "Clubs - 13") == true
        {
            self.addChild(Cards.cKing)
        }
        if passes(Tester: "Clubs - 14") == true
        {
            self.addChild(Cards.cAce)
        }
        
        fadeIn()
    }
    
    
    
    func passes(Tester: String) -> Bool
    {
        if defaults.string(forKey: "Card1") != Tester && defaults.string(forKey: "Card2") != Tester && defaults.string(forKey: "Flop1") != Tester && defaults.string(forKey: "Flop2") != Tester && defaults.string(forKey: "Flop3") != Tester && Tester != defaults.string(forKey: "Turn")
        {
            return true
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            let cardWidth = Cards.hAce.size.width
            let cardHeight = Cards.hAce.size.height
            let moveCard = SKAction.moveBy(x: 0, y: self.size.height/12, duration: 0.5)
            
            //Back Arrow
            if(pointOfTouch.x > backArrXCoord - backArrow.size.width/2 && pointOfTouch.x < backArrXCoord + backArrow.size.width/2) && (pointOfTouch.y > self.size.height - backArrYCoord - backArrow.size.height/2 && pointOfTouch.y <  self.size.height - backArrYCoord + backArrow.size.height/2 )
            {
                fadeOut()
            }
            
            //Choose Clubss Card
            //Two
            if passes(Tester: "Clubs - 2") == true
            {
                if (pointOfTouch.x > (2.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (2.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Clubs - 2", forKey: key)
                    Cards.cTwo.run(moveCard)
                     skipScene()
                }
            }
            
            //Three
            if passes(Tester: "Clubs - 3") == true
            {
                if (pointOfTouch.x > (4.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (4.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Clubs - 3", forKey: key)
                    Cards.cThree.run(moveCard)
                     skipScene()
                }
            }
            
            //Four
            if passes(Tester: "Clubs - 4") == true
            {
                if (pointOfTouch.x > (5.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Clubs - 4", forKey: key)
                    Cards.cFour.run(moveCard)
                     skipScene()
                }
            }
            
            //Five
            if passes(Tester: "Clubs - 5") == true
            {
                if (pointOfTouch.x > (7.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (7.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Clubs - 5", forKey: key)
                    Cards.cFive.run(moveCard)
                     skipScene()
                }
            }
            
            //Six
            if passes(Tester: "Clubs - 6") == true
            {
                if (pointOfTouch.x > (1.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (1.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Clubs - 6", forKey: key)
                    Cards.cSix.run(moveCard)
                     skipScene()
                }
            }
            
            //Seven
            if passes(Tester: "Clubs - 7") == true
            {
                if (pointOfTouch.x > (3.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (3.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Clubs - 7", forKey: key)
                    Cards.hSeven.run(moveCard)
                     skipScene()
                }
            }
            
            //Eight
            if passes(Tester: "Clubs - 8") == true
            {
                if (pointOfTouch.x > (5/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Clubs - 8", forKey: key)
                    Cards.cEight.run(moveCard)
                     skipScene()
                }
            }
            
            //Nine
            if passes(Tester: "Clubs - 9") == true
            {
                if (pointOfTouch.x > (6.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (6.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Clubs - 9", forKey: key)
                    Cards.cNine.run(moveCard)
                     skipScene()
                }
            }
            
            //Ten
            if passes(Tester: "Clubs - 10") == true
            {
                if (pointOfTouch.x > (8.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (8.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Clubs - 10", forKey: key)
                    Cards.cTen.run(moveCard)
                     skipScene()
                }
            }
            
            //Jack
            if passes(Tester: "Clubs - 11") == true
            {
                if (pointOfTouch.x > (2.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (2.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Clubs - 11", forKey: key)
                    Cards.cJack.run(moveCard)
                     skipScene()
                }
            }
            
            //Queen
            if passes(Tester: "Clubs - 12") == true
            {
                if (pointOfTouch.x > (4.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (4.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Clubs - 12", forKey: key)
                    Cards.cQueen.run(moveCard)
                     skipScene()
                }
            }
            
            //King
            if passes(Tester: "Clubs - 13") == true
            {
                if (pointOfTouch.x > (5.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Clubs - 13", forKey: key)
                    Cards.cKing.run(moveCard)
                     skipScene()
                }
            }
            
            //Ace
            if passes(Tester: "Clubs - 14") == true
            {
                if (pointOfTouch.x > (7.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (7.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Clubs - 14", forKey: key)
                    Cards.cAce.run(moveCard)
                     skipScene()
                }
            }
        }
    }
    
    func pos() -> String
    {
        var riverCard = ""
        if (defaults.string(forKey: "River") == "None")
        {
            riverCard = "River"
        }
        return riverCard
    }
    
    func fadeIn()
    {
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        backArrow.run(fadeIn); Directions.run(fadeIn)
        
        Cards.cTwo.run(fadeIn); Cards.cThree.run(fadeIn); Cards.cFour.run(fadeIn); Cards.cFive.run(fadeIn)
        Cards.cSix.run(fadeIn); Cards.cSeven.run(fadeIn); Cards.cEight.run(fadeIn); Cards.cNine.run(fadeIn); Cards.cTen.run(fadeIn)
        Cards.cJack.run(fadeIn); Cards.cQueen.run(fadeIn); Cards.cKing.run(fadeIn); Cards.cAce.run(fadeIn)
    }
    
    func fadeOut()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let fadeOutDir = SKAction.fadeOut(withDuration: 0.33)
        backArrow.run(fadeOut); Directions.run(fadeOutDir)
        
        Cards.cTwo.run(fadeOut); Cards.cThree.run(fadeOut); Cards.cFour.run(fadeOut); Cards.cFive.run(fadeOut)
        Cards.cSix.run(fadeOut); Cards.cSeven.run(fadeOut); Cards.cEight.run(fadeOut); Cards.cNine.run(fadeOut); Cards.cTen.run(fadeOut)
        Cards.cJack.run(fadeOut); Cards.cQueen.run(fadeOut); Cards.cKing.run(fadeOut); Cards.cAce.run(fadeOut)
        
        let seq = SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run(exit)])
        self.run(seq)
    }
    
    func exit()
    {
        //let step1 = SKAction.wait(forDuration:  0.5)
        let step2 = SKAction.run(changeScene)
        let changeSequence = SKAction.sequence([step2])
        self.run(changeSequence)
    }
    
    //Skip Over
    func skipScene()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let fadeOutDir = SKAction.fadeOut(withDuration: 0.33)
        backArrow.run(fadeOut); Directions.run(fadeOutDir)
        
        Cards.cTwo.run(fadeOut); Cards.cThree.run(fadeOut); Cards.cFour.run(fadeOut); Cards.cFive.run(fadeOut)
        Cards.cSix.run(fadeOut); Cards.cSeven.run(fadeOut); Cards.cEight.run(fadeOut); Cards.cNine.run(fadeOut); Cards.cTen.run(fadeOut)
        Cards.cJack.run(fadeOut); Cards.cQueen.run(fadeOut); Cards.cKing.run(fadeOut); Cards.cAce.run(fadeOut)
        
        let seq = SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run(skipOverScene)])
        self.run(seq)
    }
    
    func skipOverScene()
    {
        Cards.cTwo.removeFromParent(); Cards.cThree.removeFromParent(); Cards.cFour.removeFromParent(); Cards.cFive.removeFromParent()
        Cards.cSix.removeFromParent(); Cards.cSeven.removeFromParent(); Cards.cEight.removeFromParent(); Cards.cNine.removeFromParent(); Cards.cTen.removeFromParent()
        Cards.cJack.removeFromParent(); Cards.cQueen.removeFromParent(); Cards.cKing.removeFromParent(); Cards.cAce.removeFromParent()
        
        let sceneToMoveTo = gamePlay(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func changeScene()
    {
        Cards.cTwo.removeFromParent(); Cards.cThree.removeFromParent(); Cards.cFour.removeFromParent(); Cards.cFive.removeFromParent()
        Cards.cSix.removeFromParent(); Cards.cSeven.removeFromParent(); Cards.cEight.removeFromParent(); Cards.cNine.removeFromParent(); Cards.cTen.removeFromParent()
        Cards.cJack.removeFromParent(); Cards.cQueen.removeFromParent(); Cards.cKing.removeFromParent(); Cards.cAce.removeFromParent()
        
        if(defaults.string(forKey: "River") != "None")
        {
            let sceneToMoveTo = gamePlay(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration:  0)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        }else{
            let sceneToMoveTo = GameSceneRiver(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration:  0.0)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        }
    }
}
