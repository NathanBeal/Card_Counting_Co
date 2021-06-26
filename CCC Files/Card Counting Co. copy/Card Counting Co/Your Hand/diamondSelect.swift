//
//  diamondSelect.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/5/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class diamondSelect: SKScene
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
        if defaults.string(forKey: "Card1") == "None"
        {
            Directions.text = "select your first hole card"
        }
        if defaults.string(forKey: "Card1") != "None" && defaults.string(forKey: "Card2") == "None"
        {
            Directions.text = "select your second hole card"
        }
        self.addChild(Directions)
        
        //Cards
        Cards.dTwo.setScale(0.15 * Scaler)
        Cards.dTwo.position = CGPoint(x: 2.6 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.dTwo.zPosition = 1
        
        Cards.dThree.setScale(0.15 * Scaler)
        Cards.dThree.position = CGPoint(x: 4.2 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.dThree.zPosition = 1
        
        Cards.dFour.setScale(0.15 * Scaler)
        Cards.dFour.position = CGPoint(x: 5.8 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.dFour.zPosition = 1
        
        Cards.dFive.setScale(0.15 * Scaler)
        Cards.dFive.position = CGPoint(x: 7.4 * self.size.width/10, y: 7 * self.size.height/10)
        Cards.dFive.zPosition = 1
        
        
        //Second Line
        Cards.dSix.setScale(0.15 * Scaler)
        Cards.dSix.position = CGPoint(x: 1.8 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.dSix.zPosition = 1
        
        Cards.dSeven.setScale(0.15 * Scaler)
        Cards.dSeven.position = CGPoint(x: 3.4 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.dSeven.zPosition = 1
        
        Cards.dEight.setScale(0.15 * Scaler)
        Cards.dEight.position = CGPoint(x: 5 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.dEight.zPosition = 1
        
        Cards.dNine.setScale(0.15 * Scaler)
        Cards.dNine.position = CGPoint(x: 6.6 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.dNine.zPosition = 1
        
        Cards.dTen.setScale(0.15 * Scaler)
        Cards.dTen.position = CGPoint(x: 8.2 * self.size.width/10, y: 4.5 * self.size.height/10)
        Cards.dTen.zPosition = 1
        
        
        //Third Line
        Cards.dJack.setScale(0.15 * Scaler)
        Cards.dJack.position = CGPoint(x: 2.6 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.dJack.zPosition = 1
        
        Cards.dQueen.setScale(0.15 * Scaler)
        Cards.dQueen.position = CGPoint(x: 4.2 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.dQueen.zPosition = 1
        
        Cards.dKing.setScale(0.15 * Scaler)
        Cards.dKing.position = CGPoint(x: 5.8 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.dKing.zPosition = 1
        
        Cards.dAce.setScale(0.15 * Scaler)
        Cards.dAce.position = CGPoint(x: 7.4 * self.size.width/10, y: 2 * self.size.height/10)
        Cards.dAce.zPosition = 1
        
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
        backArrXCoord = (1.8 * self.size.width/10 -  Cards.dTwo.size.width/2)/2
        backArrYCoord = 4.5 * self.size.height/10
        backArrow.position = CGPoint(x: backArrXCoord, y: backArrYCoord)
        backArrow.zPosition = 10
        self.addChild(backArrow)
        
        //Removes Cards if Necessary
        if defaults.string(forKey: "Card1") != "Diamond - 2" && defaults.string(forKey: "Card2") != "Diamond - 2"
        {
            self.addChild(Cards.dTwo)
        }
        if defaults.string(forKey: "Card1") != "Diamond - 3" && defaults.string(forKey: "Card2") != "Diamond - 3"
        {
            self.addChild(Cards.dThree)
        }
        if defaults.string(forKey: "Card1") != "Diamond - 4" && defaults.string(forKey: "Card2") != "Diamond - 4"
        {
            self.addChild(Cards.dFour)
        }
        if defaults.string(forKey: "Card1") != "Diamond - 5" && defaults.string(forKey: "Card2") != "Diamond - 5"
        {
            self.addChild(Cards.dFive)
        }
        if defaults.string(forKey: "Card1") != "Diamond - 6" && defaults.string(forKey: "Card2") != "Diamond - 6"
        {
            self.addChild(Cards.dSix)
        }
        if defaults.string(forKey: "Card1") != "Diamond - 7" && defaults.string(forKey: "Card2") != "Diamond - 7"
        {
            self.addChild(Cards.dSeven)
        }
        if defaults.string(forKey: "Card1") != "Diamond - 8" && defaults.string(forKey: "Card2") != "Diamond - 8"
        {
            self.addChild(Cards.dEight)
        }
        if defaults.string(forKey: "Card1") != "Diamond - 9" && defaults.string(forKey: "Card2") != "Diamond - 9"
        {
            self.addChild(Cards.dNine)
        }
        if defaults.string(forKey: "Card1") != "Diamond - 10" && defaults.string(forKey: "Card2") != "Diamond - 10"
        {
            self.addChild(Cards.dTen)
        }
        if defaults.string(forKey: "Card1") != "Diamond - 11" && defaults.string(forKey: "Card2") != "Diamond - 11"
        {
            self.addChild(Cards.dJack)
        }
        if defaults.string(forKey: "Card1") != "Diamond - 12" && defaults.string(forKey: "Card2") != "Diamond - 12"
        {
            self.addChild(Cards.dQueen)
        }
        if defaults.string(forKey: "Card1") != "Diamond - 13" && defaults.string(forKey: "Card2") != "Diamond - 13"
        {
            self.addChild(Cards.dKing)
        }
        if defaults.string(forKey: "Card1") != "Diamond - 14" && defaults.string(forKey: "Card2") != "Diamond - 14"
        {
            self.addChild(Cards.dAce)
        }
        
        fadeIn()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            
            let cardWidth = Cards.dAce.size.width
            let cardHeight = Cards.dAce.size.height
            let moveCard = SKAction.moveBy(x: 0, y: self.size.height/12, duration: 0.5)
            
            //Two
            if defaults.string(forKey: "Card1") != "Diamond - 2" && defaults.string(forKey: "Card2") != "Diamond - 2"
            {
                if (pointOfTouch.x > (2.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (2.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Diamond - 2", forKey: "Card1")
                    }else{
                        defaults.set("Diamond - 2", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.dTwo.run(moveCard)
                    fadeOut()
                }
            }
            
            //Three
            if defaults.string(forKey: "Card1") != "Diamond - 3" && defaults.string(forKey: "Card2") != "Diamond - 3"
            {
                if (pointOfTouch.x > (4.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (4.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Diamond - 3", forKey: "Card1")
                    }else{
                        defaults.set("Diamond - 3", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.dThree.run(moveCard)
                    fadeOut()
                }
            }
            
            //Four
            if defaults.string(forKey: "Card1") != "Diamond - 4" && defaults.string(forKey: "Card2") != "Diamond - 4"
            {
                if (pointOfTouch.x > (5.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Diamond - 4", forKey: "Card1")
                    }else{
                        defaults.set("Diamond - 4", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.dFour.run(moveCard)
                    fadeOut()
                }
            }
            
            //Five
            if defaults.string(forKey: "Card1") != "Diamond - 5" && defaults.string(forKey: "Card2") != "Diamond - 5"
            {
                if (pointOfTouch.x > (7.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (7.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Diamond - 5", forKey: "Card1")
                    }else{
                        defaults.set("Diamond - 5", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.dFive.run(moveCard)
                    fadeOut()
                }
            }
            
            //Six
            if defaults.string(forKey: "Card1") != "Diamond - 6" && defaults.string(forKey: "Card2") != "Diamond - 6"
            {
                if (pointOfTouch.x > (1.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (1.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Diamond - 6", forKey: "Card1")
                    }else{
                        defaults.set("Diamond - 6", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.dSix.run(moveCard)
                    fadeOut()
                }
            }
            
            //Seven
            if defaults.string(forKey: "Card1") != "Diamond - 7" && defaults.string(forKey: "Card2") != "Diamond - 7"
            {
                if (pointOfTouch.x > (3.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (3.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Diamond - 7", forKey: "Card1")
                    }else{
                        defaults.set("Diamond - 7", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.dSeven.run(moveCard)
                    fadeOut()
                }
            }
            
            //Eight
            if defaults.string(forKey: "Card1") != "Diamond - 8" && defaults.string(forKey: "Card2") != "Diamond - 8"
            {
                if (pointOfTouch.x > (5/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Diamond - 8", forKey: "Card1")
                    }else{
                        defaults.set("Diamond - 8", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.dEight.run(moveCard)
                    fadeOut()
                }
            }
            
            //Nine
            if defaults.string(forKey: "Card1") != "Diamond - 9" && defaults.string(forKey: "Card2") != "Diamond - 9"
            {
                if (pointOfTouch.x > (6.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (6.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Diamond - 9", forKey: "Card1")
                    }else{
                        defaults.set("Diamond - 9", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.dNine.run(moveCard)
                    fadeOut()
                }
            }
            
            //Ten
            if defaults.string(forKey: "Card1") != "Diamond - 10" && defaults.string(forKey: "Card2") != "Diamond - 10"
            {
                if (pointOfTouch.x > (8.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (8.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Diamond - 10", forKey: "Card1")
                    }else{
                        defaults.set("Diamond - 10", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.dTen.run(moveCard)
                    fadeOut()
                }
            }
            
            //Jack
            if defaults.string(forKey: "Card1") != "Diamond - 11" && defaults.string(forKey: "Card2") != "Diamond - 11"
            {
                if (pointOfTouch.x > (2.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (2.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Diamond - 11", forKey: "Card1")
                    }else{
                        defaults.set("Diamond - 11", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.dJack.run(moveCard)
                    fadeOut()
                }
            }
            
            //Queen
            if defaults.string(forKey: "Card1") != "Diamond - 12" && defaults.string(forKey: "Card2") != "Diamond - 12"
            {
                if (pointOfTouch.x > (4.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (4.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Diamond - 12", forKey: "Card1")
                    }else{
                        defaults.set("Diamond - 12", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.dQueen.run(moveCard)
                    fadeOut()
                }
            }
            
            //King
            if defaults.string(forKey: "Card1") != "Diamond - 13" && defaults.string(forKey: "Card2") != "Diamond - 13"
            {
                if (pointOfTouch.x > (5.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Diamond - 13", forKey: "Card1")
                    }else{
                        defaults.set("Diamond - 13", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.dKing.run(moveCard)
                    fadeOut()
                }
            }
            
            //Ace
            if defaults.string(forKey: "Card1") != "Diamond - 14" && defaults.string(forKey: "Card2") != "Diamond - 14"
            {
                if (pointOfTouch.x > (7.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (7.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Diamond - 14", forKey: "Card1")
                    }else{
                        defaults.set("Diamond - 14", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.dAce.run(moveCard)
                    fadeOut()
                }
            }
            
            //Back Arrow
            if(pointOfTouch.x > backArrXCoord - backArrow.size.width/2 && pointOfTouch.x < backArrXCoord + backArrow.size.width/2) && (pointOfTouch.y > self.size.height - backArrYCoord - backArrow.size.height/2 && pointOfTouch.y <  self.size.height - backArrYCoord + backArrow.size.height/2 )
            {
                fadeOut()
            }
        }
    }
    
    func fadeIn()
    {
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        backArrow.run(fadeIn); Directions.run(fadeIn)
        
        Cards.dTwo.run(fadeIn); Cards.dThree.run(fadeIn); Cards.dFour.run(fadeIn); Cards.dFive.run(fadeIn)
        Cards.dSix.run(fadeIn); Cards.dSeven.run(fadeIn); Cards.dEight.run(fadeIn); Cards.dNine.run(fadeIn); Cards.dTen.run(fadeIn)
        Cards.dJack.run(fadeIn); Cards.dQueen.run(fadeIn); Cards.dKing.run(fadeIn); Cards.dAce.run(fadeIn)
    }
    
    func fadeOut()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let fadeOutDir = SKAction.fadeOut(withDuration: 0.33)
        backArrow.run(fadeOut); Directions.run(fadeOutDir)
        
        Cards.dTwo.run(fadeOut); Cards.dThree.run(fadeOut); Cards.dFour.run(fadeOut); Cards.dFive.run(fadeOut)
        Cards.dSix.run(fadeOut); Cards.dSeven.run(fadeOut); Cards.dEight.run(fadeOut); Cards.dNine.run(fadeOut); Cards.dTen.run(fadeOut)
        Cards.dJack.run(fadeOut); Cards.dQueen.run(fadeOut); Cards.dKing.run(fadeOut); Cards.dAce.run(fadeOut)
        
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
        Cards.dTwo.removeFromParent(); Cards.dThree.removeFromParent(); Cards.dFour.removeFromParent(); Cards.dFive.removeFromParent()
        Cards.dSix.removeFromParent(); Cards.dSeven.removeFromParent(); Cards.dEight.removeFromParent(); Cards.dNine.removeFromParent(); Cards.dTen.removeFromParent()
        Cards.dJack.removeFromParent(); Cards.dQueen.removeFromParent(); Cards.dKing.removeFromParent(); Cards.dAce.removeFromParent()
        
        if defaults.string(forKey: "Card1") != "None" && defaults.string(forKey: "Card2") == "None" || defaults.string(forKey: "Card1") == "None" && defaults.string(forKey: "Card2") == "None"
        {
            let sceneToMoveTo = GameScene(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration:  0)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        }else{
            if defaults.string(forKey: "Card1") != "None" && defaults.string(forKey: "Card2") == "None"
            {
                let sceneToMoveTo = checkYourCards(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
    }
    
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
        
        let sceneToMoveTo = checkYourCards(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
