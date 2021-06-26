//
//  spadeSelect.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/5/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class spadeSelect: SKScene
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
        
        //Removes Cards if Necessary
        if defaults.string(forKey: "Card1") != "Spades - 2" && defaults.string(forKey: "Card2") != "Spades - 2"
        {
            self.addChild(Cards.sTwo)
        }
        if defaults.string(forKey: "Card1") != "Spades - 3" && defaults.string(forKey: "Card2") != "Spades - 3"
        {
            self.addChild(Cards.sThree)
        }
        if defaults.string(forKey: "Card1") != "Spades - 4" && defaults.string(forKey: "Card2") != "Spades - 4"
        {
            self.addChild(Cards.sFour)
        }
        if defaults.string(forKey: "Card1") != "Spades - 5" && defaults.string(forKey: "Card2") != "Spades - 5"
        {
            self.addChild(Cards.sFive)
        }
        if defaults.string(forKey: "Card1") != "Spades - 6" && defaults.string(forKey: "Card2") != "Spades - 6"
        {
            self.addChild(Cards.sSix)
        }
        if defaults.string(forKey: "Card1") != "Spades - 7" && defaults.string(forKey: "Card2") != "Spades - 7"
        {
            self.addChild(Cards.sSeven)
        }
        if defaults.string(forKey: "Card1") != "Spades - 8" && defaults.string(forKey: "Card2") != "Spades - 8"
        {
            self.addChild(Cards.sEight)
        }
        if defaults.string(forKey: "Card1") != "Spades - 9" && defaults.string(forKey: "Card2") != "Spades - 9"
        {
            self.addChild(Cards.sNine)
        }
        if defaults.string(forKey: "Card1") != "Spades - 10" && defaults.string(forKey: "Card2") != "Spades - 10"
        {
            self.addChild(Cards.sTen)
        }
        if defaults.string(forKey: "Card1") != "Spades - 11" && defaults.string(forKey: "Card2") != "Spades - 11"
        {
            self.addChild(Cards.sJack)
        }
        if defaults.string(forKey: "Card1") != "Spades - 12" && defaults.string(forKey: "Card2") != "Spades - 12"
        {
            self.addChild(Cards.sQueen)
        }
        if defaults.string(forKey: "Card1") != "Spades - 13" && defaults.string(forKey: "Card2") != "Spades - 13"
        {
            self.addChild(Cards.sKing)
        }
        if defaults.string(forKey: "Card1") != "Spades - 14" && defaults.string(forKey: "Card2") != "Spades - 14"
        {
            self.addChild(Cards.sAce)
        }
        
        fadeIn()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            
            let cardWidth = Cards.sAce.size.width
            let cardHeight = Cards.sAce.size.height
            let moveCard = SKAction.moveBy(x: 0, y: self.size.height/12, duration: 0.5)
            
            //Two
            if defaults.string(forKey: "Card1") != "Spades - 2" && defaults.string(forKey: "Card2") != "Spades - 2"
            {
                if (pointOfTouch.x > (2.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (2.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Spades - 2", forKey: "Card1")
                    }else{
                        defaults.set("Spades - 2", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.sTwo.run(moveCard)
                    fadeOut()
                }
            }
            
            //Three
            if defaults.string(forKey: "Card1") != "Spades - 3" && defaults.string(forKey: "Card2") != "Spades - 3"
            {
                if (pointOfTouch.x > (4.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (4.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Spades - 3", forKey: "Card1")
                    }else{
                        defaults.set("Spades - 3", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.sThree.run(moveCard)
                    fadeOut()
                }
            }
            
            //Four
            if defaults.string(forKey: "Card1") != "Spades - 4" && defaults.string(forKey: "Card2") != "Spades - 4"
            {
                if (pointOfTouch.x > (5.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Spades - 4", forKey: "Card1")
                    }else{
                        defaults.set("Spades - 4", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.sFour.run(moveCard)
                    fadeOut()
                }
            }
            
            //Five
            if defaults.string(forKey: "Card1") != "Spades - 5" && defaults.string(forKey: "Card2") != "Spades - 5"
            {
                if (pointOfTouch.x > (7.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (7.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Spades - 5", forKey: "Card1")
                    }else{
                        defaults.set("Spades - 5", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.sFive.run(moveCard)
                    fadeOut()
                }
            }
            
            //Six
            if defaults.string(forKey: "Card1") != "Spades - 6" && defaults.string(forKey: "Card2") != "Spades - 6"
            {
                if (pointOfTouch.x > (1.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (1.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Spades - 6", forKey: "Card1")
                    }else{
                        defaults.set("Spades - 6", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.sSix.run(moveCard)
                    fadeOut()
                }
            }
            
            //Seven
            if defaults.string(forKey: "Card1") != "Spades - 7" && defaults.string(forKey: "Card2") != "Spades - 7"
            {
                if (pointOfTouch.x > (3.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (3.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Spades - 7", forKey: "Card1")
                    }else{
                        defaults.set("Spades - 7", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.sSeven.run(moveCard)
                    fadeOut()
                }
            }
            
            //Eight
            if defaults.string(forKey: "Card1") != "Spades - 8" && defaults.string(forKey: "Card2") != "Spades - 8"
            {
                if (pointOfTouch.x > (5/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Spades - 8", forKey: "Card1")
                    }else{
                        defaults.set("Spades - 8", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.sEight.run(moveCard)
                    fadeOut()
                }
            }
            
            //Nine
            if defaults.string(forKey: "Card1") != "Spades - 9" && defaults.string(forKey: "Card2") != "Spades - 9"
            {
                if (pointOfTouch.x > (6.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (6.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Spades - 9", forKey: "Card1")
                    }else{
                        defaults.set("Spades - 9", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.sNine.run(moveCard)
                    fadeOut()
                }
            }
            
            //Ten
            if defaults.string(forKey: "Card1") != "Spades - 10" && defaults.string(forKey: "Card2") != "Spades - 10"
            {
                if (pointOfTouch.x > (8.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (8.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Spades - 10", forKey: "Card1")
                    }else{
                        defaults.set("Spades - 10", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.sTen.run(moveCard)
                    fadeOut()
                }
            }
            
            //Jack
            if defaults.string(forKey: "Card1") != "Spades - 11" && defaults.string(forKey: "Card2") != "Spades - 11"
            {
                if (pointOfTouch.x > (2.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (2.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Spades - 11", forKey: "Card1")
                    }else{
                        defaults.set("Spades - 11", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.sJack.run(moveCard)
                    fadeOut()
                }
            }
            
            //Queen
            if defaults.string(forKey: "Card1") != "Spades - 12" && defaults.string(forKey: "Card2") != "Spades - 12"
            {
                if (pointOfTouch.x > (4.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (4.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Spades - 12", forKey: "Card1")
                    }else{
                        defaults.set("Spades - 12", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.sQueen.run(moveCard)
                    fadeOut()
                }
            }
            
            //King
            if defaults.string(forKey: "Card1") != "Spades - 13" && defaults.string(forKey: "Card2") != "Spades - 13"
            {
                if (pointOfTouch.x > (5.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Spades - 13", forKey: "Card1")
                    }else{
                        defaults.set("Spades - 13", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.sKing.run(moveCard)
                    fadeOut()
                }
            }
            
            //Ace
            if defaults.string(forKey: "Card1") != "Spades - 14" && defaults.string(forKey: "Card2") != "Spades - 14"
            {
                if (pointOfTouch.x > (7.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (7.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Spades - 14", forKey: "Card1")
                    }else{
                        defaults.set("Spades - 14", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.sAce.run(moveCard)
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
    
    func changeScene()
    {
        Cards.sTwo.removeFromParent(); Cards.sThree.removeFromParent(); Cards.sFour.removeFromParent(); Cards.sFive.removeFromParent()
        Cards.sSix.removeFromParent(); Cards.sSeven.removeFromParent(); Cards.sEight.removeFromParent(); Cards.sNine.removeFromParent(); Cards.sTen.removeFromParent()
        Cards.sJack.removeFromParent(); Cards.sQueen.removeFromParent(); Cards.sKing.removeFromParent(); Cards.sAce.removeFromParent()
        
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
        
        Cards.sTwo.run(fadeOut); Cards.sThree.run(fadeOut); Cards.sFour.run(fadeOut); Cards.sFive.run(fadeOut)
        Cards.sSix.run(fadeOut); Cards.sSeven.run(fadeOut); Cards.sEight.run(fadeOut); Cards.sNine.run(fadeOut); Cards.sTen.run(fadeOut)
        Cards.sJack.run(fadeOut); Cards.sQueen.run(fadeOut); Cards.sKing.run(fadeOut); Cards.sAce.run(fadeOut)
        
        let seq = SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run(skipOverScene)])
        self.run(seq)
    }
    
    func skipOverScene()
    {
        Cards.sTwo.removeFromParent(); Cards.sThree.removeFromParent(); Cards.sFour.removeFromParent(); Cards.sFive.removeFromParent()
        Cards.sSix.removeFromParent(); Cards.sSeven.removeFromParent(); Cards.sEight.removeFromParent(); Cards.sNine.removeFromParent(); Cards.sTen.removeFromParent()
        Cards.sJack.removeFromParent(); Cards.sQueen.removeFromParent(); Cards.sKing.removeFromParent(); Cards.sAce.removeFromParent()
        
        let sceneToMoveTo = checkYourCards(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
