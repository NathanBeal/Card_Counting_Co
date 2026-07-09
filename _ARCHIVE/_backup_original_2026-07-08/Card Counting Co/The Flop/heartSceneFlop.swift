//
//  heartSelectFlop.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/7/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class heartSelectFlop: SKScene
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
        Directions.alpha = 0
        if (defaults.string(forKey: "Flop1") == "None")
        {
            Directions.text = "select your first flop card"
        }
        if (defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") == "None")
        {
            Directions.text = "select your second flop card"
        }
        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") == "None" )
        {
            Directions.text = "select your third flop card"
        }
        self.addChild(Directions)
        
        //Cards
        Cards.hTwo.setScale(0.15 * Scaler)
        Cards.hTwo.position = CGPoint(x: 2.6 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.hTwo.zPosition = 1
        
        Cards.hThree.setScale(0.15 * Scaler)
        Cards.hThree.position = CGPoint(x: 4.2 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.hThree.zPosition = 1
        
        Cards.hFour.setScale(0.15 * Scaler)
        Cards.hFour.position = CGPoint(x: 5.8 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.hFour.zPosition = 1
        
        Cards.hFive.setScale(0.15 * Scaler)
        Cards.hFive.position = CGPoint(x: 7.4 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.hFive.zPosition = 1
        
        
        //Second Line
        Cards.hSix.setScale(0.15 * Scaler)
        Cards.hSix.position = CGPoint(x: 1.8 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.hSix.zPosition = 1
        
        Cards.hSeven.setScale(0.15 * Scaler)
        Cards.hSeven.position = CGPoint(x: 3.4 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.hSeven.zPosition = 1
        
        Cards.hEight.setScale(0.15 * Scaler)
        Cards.hEight.position = CGPoint(x: 5 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.hEight.zPosition = 1
        
        Cards.hNine.setScale(0.15 * Scaler)
        Cards.hNine.position = CGPoint(x: 6.6 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.hNine.zPosition = 1
        
        Cards.hTen.setScale(0.15 * Scaler)
        Cards.hTen.position = CGPoint(x: 8.2 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.hTen.zPosition = 1
        
        
        //Third Line
        Cards.hJack.setScale(0.15 * Scaler)
        Cards.hJack.position = CGPoint(x: 2.6 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.hJack.zPosition = 1
        
        Cards.hQueen.setScale(0.15 * Scaler)
        Cards.hQueen.position = CGPoint(x: 4.2 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.hQueen.zPosition = 1
        
        Cards.hKing.setScale(0.15 * Scaler)
        Cards.hKing.position = CGPoint(x: 5.8 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.hKing.zPosition = 1
        
        Cards.hAce.setScale(0.15 * Scaler)
        Cards.hAce.position = CGPoint(x: 7.4 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.hAce.zPosition = 1
        
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
        backArrXCoord = (1.8 * self.size.width/10 -  Cards.hTwo.size.width/2)/2
        backArrYCoord = 4.5 * self.size.height/10
        backArrow.position = CGPoint(x: backArrXCoord, y: backArrYCoord)
        backArrow.zPosition = 10
        self.addChild(backArrow)
        
        //The Test
        if passes(Tester: "Heart - 2") == true
        {
            self.addChild(Cards.hTwo)
        }
        if passes(Tester: "Heart - 3") == true
        {
            self.addChild(Cards.hThree)
        }
        if passes(Tester: "Heart - 4") == true
        {
            self.addChild(Cards.hFour)
        }
        if passes(Tester: "Heart - 5") == true
        {
            self.addChild(Cards.hFive)
        }
        if passes(Tester: "Heart - 6") == true
        {
            self.addChild(Cards.hSix)
        }
        if passes(Tester: "Heart - 7") == true
        {
            self.addChild(Cards.hSeven)
        }
        if passes(Tester: "Heart - 8") == true
        {
            self.addChild(Cards.hEight)
        }
        if passes(Tester: "Heart - 9") == true
        {
            self.addChild(Cards.hNine)
        }
        if passes(Tester: "Heart - 10") == true
        {
            self.addChild(Cards.hTen)
        }
        if passes(Tester: "Heart - 11") == true
        {
            self.addChild(Cards.hJack)
        }
        if passes(Tester: "Heart - 12") == true
        {
            self.addChild(Cards.hQueen)
        }
        if passes(Tester: "Heart - 13") == true
        {
            self.addChild(Cards.hKing)
        }
        if passes(Tester: "Heart - 14") == true
        {
            self.addChild(Cards.hAce)
        }
        fadeIn()
    }
    
    
    func passes(Tester: String) -> Bool
    {
        if defaults.string(forKey: "Card1") != Tester && defaults.string(forKey: "Card2") != Tester && defaults.string(forKey: "Flop1") != Tester && defaults.string(forKey: "Flop2") != Tester && defaults.string(forKey: "Flop3") != Tester
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
            
            print(cardHeight)
            
            let moveCard = SKAction.moveBy(x: 0, y: self.size.height/12, duration: 0.5)
            
            //Back Arrow
            if(pointOfTouch.x > backArrXCoord - backArrow.size.width/2 && pointOfTouch.x < backArrXCoord + backArrow.size.width/2) && (pointOfTouch.y > self.size.height - backArrYCoord - backArrow.size.height/2 && pointOfTouch.y <  self.size.height - backArrYCoord + backArrow.size.height/2 )
            {
                fadeOut()
            }
            
            //Choose Hearts Card
            //Two
            if passes(Tester: "Heart - 2") == true
            {
                if (pointOfTouch.x > (2.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (2.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Heart - 2", forKey: key)
                    Cards.hTwo.run(moveCard)
                    if key == "Flop3"
                    {
                        skipScene()
                    }else{
                        fadeOut()
                    }
                }
            }
            
            //Three
            if passes(Tester: "Heart - 3") == true
            {
                if (pointOfTouch.x > (4.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (4.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 *  self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/10))
                {
                    let key = pos()
                    defaults.set("Heart - 3", forKey: key)
                    Cards.hThree.run(moveCard)
                    if key == "Flop3"
                    {
                        skipScene()
                    }else{
                        fadeOut()
                    }
                }
            }
            
            //Four
            if passes(Tester: "Heart - 4") == true
            {
                if (pointOfTouch.x > (5.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 *  self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 *  self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Heart - 4", forKey: key)
                    Cards.hFour.run(moveCard)
                    if key == "Flop3"
                    {
                        skipScene()
                    }else{
                        fadeOut()
                    }
                }
            }
            
            //Five
            if passes(Tester: "Heart - 5") == true
            {
                if (pointOfTouch.x > (7.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (7.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 *  self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 *  self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Heart - 5", forKey: key)
                    Cards.hFive.run(moveCard)
                    if key == "Flop3"
                    {
                        skipScene()
                    }else{
                        fadeOut()
                    }
                }
            }
            
            //Six
            if passes(Tester: "Heart - 6") == true
            {
                if (pointOfTouch.x > (1.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (1.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Heart - 6", forKey: key)
                    Cards.hSix.run(moveCard)
                    if key == "Flop3"
                    {
                        skipScene()
                    }else{
                        fadeOut()
                    }
                }
            }
            
            //Seven
            if passes(Tester: "Heart - 7") == true
            {
                if (pointOfTouch.x > (3.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (3.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Heart - 7", forKey: key)
                    Cards.hSeven.run(moveCard)
                    if key == "Flop3"
                    {
                        skipScene()
                    }else{
                        fadeOut()
                    }
                }
            }
            
            //Eight
            if passes(Tester: "Heart - 8") == true
            {
                if (pointOfTouch.x > (5/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Heart - 8", forKey: key)
                    Cards.hEight.run(moveCard)
                    if key == "Flop3"
                    {
                        skipScene()
                    }else{
                        fadeOut()
                    }
                }
            }
            
            //Nine
            if passes(Tester: "Heart - 9") == true
            {
                if (pointOfTouch.x > (6.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (6.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Heart - 9", forKey: key)
                    Cards.hNine.run(moveCard)
                    if key == "Flop3"
                    {
                        skipScene()
                    }else{
                        fadeOut()
                    }
                }
            }
            
            //Ten
            if passes(Tester: "Heart - 10") == true
            {
                if (pointOfTouch.x > (8.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (8.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Heart - 10", forKey: key)
                    Cards.hTen.run(moveCard)
                    if key == "Flop3"
                    {
                        skipScene()
                    }else{
                        fadeOut()
                    }
                }
            }
            
            //Jack
            if passes(Tester: "Heart - 11") == true
            {
                if (pointOfTouch.x > (2.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (2.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Heart - 11", forKey: key)
                    Cards.hJack.run(moveCard)
                    if key == "Flop3"
                    {
                        skipScene()
                    }else{
                        fadeOut()
                    }
                }
            }
            
            //Queen
            if passes(Tester: "Heart - 12") == true
            {
                if (pointOfTouch.x > (4.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (4.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Heart - 12", forKey: key)
                    Cards.hQueen.run(moveCard)
                    if key == "Flop3"
                    {
                        skipScene()
                    }else{
                        fadeOut()
                    }
                }
            }
            
            //King
            if passes(Tester: "Heart - 13") == true
            {
                if (pointOfTouch.x > (5.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Heart - 13", forKey: key)
                    Cards.hKing.run(moveCard)
                    if key == "Flop3"
                    {
                        skipScene()
                    }else{
                        fadeOut()
                    }
                }
            }
            
            //Ace
            if passes(Tester: "Heart - 14") == true
            {
                if (pointOfTouch.x > (7.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (7.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    let key = pos()
                    defaults.set("Heart - 14", forKey: key)
                    Cards.hAce.run(moveCard)
                    if key == "Flop3"
                    {
                        skipScene()
                    }else{
                        fadeOut()
                    }
                }
            }
        }
    }
    
    func pos() -> String
    {
        var flopCardNum = ""
        if (defaults.string(forKey: "Flop1") == "None")
        {
            flopCardNum = "Flop1"
        }else{
            if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") == "None")
            {
                flopCardNum = "Flop2"
            }else{
                if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") == "None" )
                {
                    flopCardNum = "Flop3"
                }
            }
        }
        
        return flopCardNum
    }
    
    func fadeIn()
    {
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        backArrow.run(fadeIn); Directions.run(fadeIn)
        
        Cards.hTwo.run(fadeIn); Cards.hThree.run(fadeIn); Cards.hFour.run(fadeIn); Cards.hFive.run(fadeIn)
        Cards.hSix.run(fadeIn); Cards.hSeven.run(fadeIn); Cards.hEight.run(fadeIn); Cards.hNine.run(fadeIn); Cards.hTen.run(fadeIn)
        Cards.hJack.run(fadeIn); Cards.hQueen.run(fadeIn); Cards.hKing.run(fadeIn); Cards.hAce.run(fadeIn)
    }
    
    func fadeOut()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let fadeOutDir = SKAction.fadeOut(withDuration: 0.33)
        backArrow.run(fadeOut); Directions.run(fadeOutDir)
        
        Cards.hTwo.run(fadeOut); Cards.hThree.run(fadeOut); Cards.hFour.run(fadeOut); Cards.hFive.run(fadeOut)
        Cards.hSix.run(fadeOut); Cards.hSeven.run(fadeOut); Cards.hEight.run(fadeOut); Cards.hNine.run(fadeOut); Cards.hTen.run(fadeOut)
        Cards.hJack.run(fadeOut); Cards.hQueen.run(fadeOut); Cards.hKing.run(fadeOut); Cards.hAce.run(fadeOut)
        
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
    
    func changeScene()
    {
        Cards.hTwo.removeFromParent(); Cards.hThree.removeFromParent(); Cards.hFour.removeFromParent(); Cards.hFive.removeFromParent()
        Cards.hSix.removeFromParent(); Cards.hSeven.removeFromParent(); Cards.hEight.removeFromParent(); Cards.hNine.removeFromParent(); Cards.hTen.removeFromParent()
        Cards.hJack.removeFromParent(); Cards.hQueen.removeFromParent(); Cards.hKing.removeFromParent(); Cards.hAce.removeFromParent()
        
        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") != "None")
        {
            let sceneToMoveTo = gamePlay(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration:  0)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        }else{
            let sceneToMoveTo = GameSceneFlop(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration:  0.0)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        }
    }
    
    func skipScene()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let fadeOutDir = SKAction.fadeOut(withDuration: 0.33)
        backArrow.run(fadeOut); Directions.run(fadeOutDir)
        
        Cards.hTwo.run(fadeOut); Cards.hThree.run(fadeOut); Cards.hFour.run(fadeOut); Cards.hFive.run(fadeOut)
        Cards.hSix.run(fadeOut); Cards.hSeven.run(fadeOut); Cards.hEight.run(fadeOut); Cards.hNine.run(fadeOut); Cards.hTen.run(fadeOut)
        Cards.hJack.run(fadeOut); Cards.hQueen.run(fadeOut); Cards.hKing.run(fadeOut); Cards.hAce.run(fadeOut)
        
        let seq = SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run(skipOverScene)])
        self.run(seq)
    }
    
    func skipOverScene()
    {
        Cards.hTwo.removeFromParent(); Cards.hThree.removeFromParent(); Cards.hFour.removeFromParent(); Cards.hFive.removeFromParent()
        Cards.hSix.removeFromParent(); Cards.hSeven.removeFromParent(); Cards.hEight.removeFromParent(); Cards.hNine.removeFromParent(); Cards.hTen.removeFromParent()
        Cards.hJack.removeFromParent(); Cards.hQueen.removeFromParent(); Cards.hKing.removeFromParent(); Cards.hAce.removeFromParent()
        
        let sceneToMoveTo = gamePlay(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
