//
//  spadeSelecrRiver.swift
//  Card Counting Co
//
//  Created by ADAMLANE on 6/8/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class spadeSelectRiver: SKScene
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
        Cards.sTwo.setScale(0.15 * Scaler)
        Cards.sTwo.position = CGPoint(x: 2.6 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.sTwo.zPosition = 1
        
        Cards.sThree.setScale(0.15 * Scaler)
        Cards.sThree.position = CGPoint(x: 4.2 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.sThree.zPosition = 1
        
        Cards.sFour.setScale(0.15 * Scaler)
        Cards.sFour.position = CGPoint(x: 5.8 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.sFour.zPosition = 1
        
        Cards.sFive.setScale(0.15 * Scaler)
        Cards.sFive.position = CGPoint(x: 7.4 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.sFive.zPosition = 1
        
        
        //Second Line
        Cards.sSix.setScale(0.15 * Scaler)
        Cards.sSix.position = CGPoint(x: 1.8 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.sSix.zPosition = 1
        
        Cards.sSeven.setScale(0.15 * Scaler)
        Cards.sSeven.position = CGPoint(x: 3.4 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.sSeven.zPosition = 1
        
        Cards.sEight.setScale(0.15 * Scaler)
        Cards.sEight.position = CGPoint(x: 5 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.sEight.zPosition = 1
        
        Cards.sNine.setScale(0.15 * Scaler)
        Cards.sNine.position = CGPoint(x: 6.6 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.sNine.zPosition = 1
        
        Cards.sTen.setScale(0.15 * Scaler)
        Cards.sTen.position = CGPoint(x: 8.2 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.sTen.zPosition = 1
        
        
        //Third Line
        Cards.sJack.setScale(0.15 * Scaler)
        Cards.sJack.position = CGPoint(x: 2.6 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.sJack.zPosition = 1
        
        Cards.sQueen.setScale(0.15 * Scaler)
        Cards.sQueen.position = CGPoint(x: 4.2 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.sQueen.zPosition = 1
        
        Cards.sKing.setScale(0.15 * Scaler)
        Cards.sKing.position = CGPoint(x: 5.8 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.sKing.zPosition = 1
        
        Cards.sAce.setScale(0.15 * Scaler)
        Cards.sAce.position = CGPoint(x: 7.4 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.sAce.zPosition = 1
        
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
        backArrXCoord = (1.8 * self.size.width/10 -  Cards.sTwo.size.width/2)/2
        backArrYCoord = 4.5 * self.size.height/10
        backArrow.position = CGPoint(x: backArrXCoord, y: backArrYCoord)
        backArrow.zPosition = 10
        self.addChild(backArrow)
        
        //Checker
        if passes(Tester: "Spades - 2") == true
        {
            self.addChild(Cards.sTwo)
        }
        if passes(Tester: "Spades - 3") == true
        {
            self.addChild(Cards.sThree)
        }
        if passes(Tester: "Spades - 4") == true
        {
            self.addChild(Cards.sFour)
        }
        if passes(Tester: "Spades - 5") == true
        {
            self.addChild(Cards.sFive)
        }
        if passes(Tester: "Spades - 6") == true
        {
            self.addChild(Cards.sSix)
        }
        if passes(Tester: "Spades - 7") == true
        {
            self.addChild(Cards.sSeven)
        }
        if passes(Tester: "Spades - 8") == true
        {
            self.addChild(Cards.sEight)
        }
        if passes(Tester: "Spades - 9") == true
        {
            self.addChild(Cards.sNine)
        }
        if passes(Tester: "Spades - 10") == true
        {
            self.addChild(Cards.sTen)
        }
        if passes(Tester: "Spades - 11") == true
        {
            self.addChild(Cards.sJack)
        }
        if passes(Tester: "Spades - 12") == true
        {
            self.addChild(Cards.sQueen)
        }
        if passes(Tester: "Spades - 13") == true
        {
            self.addChild(Cards.sKing)
        }
        if passes(Tester: "Spades - 14") == true
        {
            self.addChild(Cards.sAce)
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
            
            //Choose Spadess Card
            //Two
            if passes(Tester: "Spades - 2") == true
            {
                if (pointOfTouch.x > (2.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (2.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Spades - 2", forKey: key)
                    Cards.sTwo.run(moveCard)
                     skipScene()
                }
            }
            
            //Three
            if passes(Tester: "Spades - 3") == true
            {
                if (pointOfTouch.x > (4.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (4.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Spades - 3", forKey: key)
                    Cards.sThree.run(moveCard)
                     skipScene()
                }
            }
            
            //Four
            if passes(Tester: "Spades - 4") == true
            {
                if (pointOfTouch.x > (5.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Spades - 4", forKey: key)
                    Cards.sFour.run(moveCard)
                     skipScene()
                }
            }
            
            //Five
            if passes(Tester: "Spades - 5") == true
            {
                if (pointOfTouch.x > (7.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (7.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Spades - 5", forKey: key)
                    Cards.sFive.run(moveCard)
                     skipScene()
                }
            }
            
            //Six
            if passes(Tester: "Spades - 6") == true
            {
                if (pointOfTouch.x > (1.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (1.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Spades - 6", forKey: key)
                    Cards.sSix.run(moveCard)
                     skipScene()
                }
            }
            
            //Seven
            if passes(Tester: "Spades - 7") == true
            {
                if (pointOfTouch.x > (3.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (3.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Spades - 7", forKey: key)
                    Cards.hSeven.run(moveCard)
                     skipScene()
                }
            }
            
            //Eight
            if passes(Tester: "Spades - 8") == true
            {
                if (pointOfTouch.x > (5/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Spades - 8", forKey: key)
                    Cards.sEight.run(moveCard)
                     skipScene()
                }
            }
            
            //Nine
            if passes(Tester: "Spades - 9") == true
            {
                if (pointOfTouch.x > (6.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (6.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Spades - 9", forKey: key)
                    Cards.sNine.run(moveCard)
                     skipScene()
                }
            }
            
            //Ten
            if passes(Tester: "Spades - 10") == true
            {
                if (pointOfTouch.x > (8.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (8.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Spades - 10", forKey: key)
                    Cards.sTen.run(moveCard)
                     skipScene()
                }
            }
            
            //Jack
            if passes(Tester: "Spades - 11") == true
            {
                if (pointOfTouch.x > (2.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (2.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Spades - 11", forKey: key)
                    Cards.sJack.run(moveCard)
                     skipScene()
                }
            }
            
            //Queen
            if passes(Tester: "Spades - 12") == true
            {
                if (pointOfTouch.x > (4.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (4.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Spades - 12", forKey: key)
                    Cards.sQueen.run(moveCard)
                     skipScene()
                }
            }
            
            //King
            if passes(Tester: "Spades - 13") == true
            {
                if (pointOfTouch.x > (5.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Spades - 13", forKey: key)
                    Cards.sKing.run(moveCard)
                     skipScene()
                }
            }
            
            //Ace
            if passes(Tester: "Spades - 14") == true
            {
                if (pointOfTouch.x > (7.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (7.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Spades - 14", forKey: key)
                    Cards.sAce.run(moveCard)
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
        
        Cards.sTwo.run(fadeIn); Cards.sThree.run(fadeIn); Cards.sFour.run(fadeIn); Cards.sFive.run(fadeIn)
        Cards.sSix.run(fadeIn); Cards.sSeven.run(fadeIn); Cards.sEight.run(fadeIn); Cards.sNine.run(fadeIn); Cards.sTen.run(fadeIn)
        Cards.sJack.run(fadeIn); Cards.sQueen.run(fadeIn); Cards.sKing.run(fadeIn); Cards.sAce.run(fadeIn)
    }
    
    func fadeOut()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let fadeOutDir = SKAction.fadeOut(withDuration: 0.33)
        backArrow.run(fadeOut); Directions.run(fadeOutDir)
        
        Cards.sTwo.run(fadeOut); Cards.sThree.run(fadeOut); Cards.sFour.run(fadeOut); Cards.sFive.run(fadeOut)
        Cards.sSix.run(fadeOut); Cards.sSeven.run(fadeOut); Cards.sEight.run(fadeOut); Cards.sNine.run(fadeOut); Cards.sTen.run(fadeOut)
        Cards.sJack.run(fadeOut); Cards.sQueen.run(fadeOut); Cards.sKing.run(fadeOut); Cards.sAce.run(fadeOut)
        
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
        
        Cards.dTwo.run(fadeOut); Cards.dThree.run(fadeOut); Cards.dFour.run(fadeOut); Cards.dFive.run(fadeOut)
        Cards.dSix.run(fadeOut); Cards.dSeven.run(fadeOut); Cards.dEight.run(fadeOut); Cards.dNine.run(fadeOut); Cards.dTen.run(fadeOut)
        Cards.dJack.run(fadeOut); Cards.dQueen.run(fadeOut); Cards.dKing.run(fadeOut); Cards.dAce.run(fadeOut)
        
        let seq = SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run(skipOverScene)])
        self.run(seq)
    }
    
    func skipOverScene()
    {
        Cards.dTwo.removeFromParent(); Cards.dThree.removeFromParent(); Cards.dFour.removeFromParent(); Cards.dFive.removeFromParent()
        Cards.dSix.removeFromParent(); Cards.dSeven.removeFromParent(); Cards.dEight.removeFromParent(); Cards.dNine.removeFromParent(); Cards.dTen.removeFromParent()
        Cards.dJack.removeFromParent(); Cards.dQueen.removeFromParent(); Cards.dKing.removeFromParent(); Cards.dAce.removeFromParent()
        
        let sceneToMoveTo = gamePlay(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func changeScene()
    {
        Cards.dTwo.removeFromParent(); Cards.dThree.removeFromParent(); Cards.dFour.removeFromParent(); Cards.dFive.removeFromParent()
        Cards.dSix.removeFromParent(); Cards.dSeven.removeFromParent(); Cards.dEight.removeFromParent(); Cards.dNine.removeFromParent(); Cards.dTen.removeFromParent()
        Cards.dJack.removeFromParent(); Cards.dQueen.removeFromParent(); Cards.dKing.removeFromParent(); Cards.dAce.removeFromParent()
        
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
