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
    //Sprite Nodes
    let background = SKSpriteNode(imageNamed: "background")
    let backArrow = SKSpriteNode(imageNamed: "backArr")
    
    //Initalized Variables
    var backArrXCoord = CGFloat()
    var backArrYCoord = CGFloat()
    var Scaler = CGFloat()
    let Directions = SKLabelNode()

    //Used for boundaries
    let gameArea: CGRect
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
        
        //First Line
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
        backArrow.alpha = 0; Directions.alpha = 0; Cards.cTwo.alpha = 0; Cards.cThree.alpha = 0; Cards.cFour.alpha = 0; Cards.cFive.alpha = 0; Cards.cSix.alpha = 0; Cards.cSeven.alpha = 0; Cards.cEight.alpha = 0; Cards.cNine.alpha = 0; Cards.cTen.alpha = 0; Cards.cJack.alpha = 0; Cards.cQueen.alpha = 0; Cards.cKing.alpha = 0; Cards.cAce.alpha = 0
        
        //Back Arrow
        backArrow.setScale(CGFloat(0.65 * scaleModifier))
        backArrXCoord = (1.8 * self.size.width/10 -  Cards.cTwo.size.width/2)/2
        backArrYCoord = 4.5 * self.size.height/10
        backArrow.position = CGPoint(x: backArrXCoord, y: backArrYCoord)
        backArrow.zPosition = 10
        self.addChild(backArrow)
        
        
        //Removes Cards if Necessary
        if defaults.string(forKey: "Card1") != "Clubs - 2" && defaults.string(forKey: "Card2") != "Clubs - 2"
        {
            self.addChild(Cards.cTwo)
        }
        if defaults.string(forKey: "Card1") != "Clubs - 3" && defaults.string(forKey: "Card2") != "Clubs - 3"
        {
            self.addChild(Cards.cThree)
        }
        if defaults.string(forKey: "Card1") != "Clubs - 4" && defaults.string(forKey: "Card2") != "Clubs - 4"
        {
            self.addChild(Cards.cFour)
        }
        if defaults.string(forKey: "Card1") != "Clubs - 5" && defaults.string(forKey: "Card2") != "Clubs - 5"
        {
            self.addChild(Cards.cFive)
        }
        if defaults.string(forKey: "Card1") != "Clubs - 6" && defaults.string(forKey: "Card2") != "Clubs - 6"
        {
            self.addChild(Cards.cSix)
        }
        if defaults.string(forKey: "Card1") != "Clubs - 7" && defaults.string(forKey: "Card2") != "Clubs - 7"
        {
            self.addChild(Cards.cSeven)
        }
        if defaults.string(forKey: "Card1") != "Clubs - 8" && defaults.string(forKey: "Card2") != "Clubs - 8"
        {
            self.addChild(Cards.cEight)
        }
        if defaults.string(forKey: "Card1") != "Clubs - 9" && defaults.string(forKey: "Card2") != "Clubs - 9"
        {
            self.addChild(Cards.cNine)
        }
        if defaults.string(forKey: "Card1") != "Clubs - 10" && defaults.string(forKey: "Card2") != "Clubs - 10"
        {
            self.addChild(Cards.cTen)
        }
        if defaults.string(forKey: "Card1") != "Clubs - 11" && defaults.string(forKey: "Card2") != "Clubs - 11"
        {
            self.addChild(Cards.cJack)
        }
        if defaults.string(forKey: "Card1") != "Clubs - 12" && defaults.string(forKey: "Card2") != "Clubs - 12"
        {
            self.addChild(Cards.cQueen)
        }
        if defaults.string(forKey: "Card1") != "Clubs - 13" && defaults.string(forKey: "Card2") != "Clubs - 13"
        {
            self.addChild(Cards.cKing)
        }
        if defaults.string(forKey: "Card1") != "Clubs - 14" && defaults.string(forKey: "Card2") != "Clubs - 14"
        {
            self.addChild(Cards.cAce)
        }
        
        fadeIn()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            
            let cardWidth = Cards.cAce.size.width
            let cardHeight = Cards.cAce.size.height
            let moveCard = SKAction.moveBy(x: 0, y: self.size.height/12, duration: 0.5)
            
            //Two
            if defaults.string(forKey: "Card1") != "Clubs - 2" && defaults.string(forKey: "Card2") != "Clubs - 2"
            {
                if (pointOfTouch.x > (2.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (2.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Clubs - 2", forKey: "Card1")
                    }else{
                        defaults.set("Clubs - 2", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.cTwo.run(moveCard)
                    fadeOut()
                }
            }
            
            //Three
            if defaults.string(forKey: "Card1") != "Clubs - 3" && defaults.string(forKey: "Card2") != "Clubs - 3"
            {
                if (pointOfTouch.x > (4.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (4.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Clubs - 3", forKey: "Card1")
                    }else{
                        defaults.set("Clubs - 3", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.cThree.run(moveCard)
                    fadeOut()
                }
            }
            
            //Four
            if defaults.string(forKey: "Card1") != "Clubs - 4" && defaults.string(forKey: "Card2") != "Clubs - 4"
            {
                if (pointOfTouch.x > (5.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Clubs - 4", forKey: "Card1")
                    }else{
                        defaults.set("Clubs - 4", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.cFour.run(moveCard)
                    fadeOut()
                }
            }
            
            //Five
            if defaults.string(forKey: "Card1") != "Clubs - 5" && defaults.string(forKey: "Card2") != "Clubs - 5"
            {
                if (pointOfTouch.x > (7.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (7.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (2.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (2.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Clubs - 5", forKey: "Card1")
                    }else{
                        defaults.set("Clubs - 5", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.cFive.run(moveCard)
                    fadeOut()
                }
            }
            
            //Six
            if defaults.string(forKey: "Card1") != "Clubs - 6" && defaults.string(forKey: "Card2") != "Clubs - 6"
            {
                if (pointOfTouch.x > (1.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (1.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Clubs - 6", forKey: "Card1")
                    }else{
                        defaults.set("Clubs - 6", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.cSix.run(moveCard)
                    fadeOut()
                }
            }
            
            //Seven
            if defaults.string(forKey: "Card1") != "Clubs - 7" && defaults.string(forKey: "Card2") != "Clubs - 7"
            {
                if (pointOfTouch.x > (3.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (3.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Clubs - 7", forKey: "Card1")
                    }else{
                        defaults.set("Clubs - 7", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.cSeven.run(moveCard)
                    fadeOut()
                }
            }
            
            //Eight
            if defaults.string(forKey: "Card1") != "Clubs - 8" && defaults.string(forKey: "Card2") != "Clubs - 8"
            {
                if (pointOfTouch.x > (5/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Clubs - 8", forKey: "Card1")
                    }else{
                        defaults.set("Clubs - 8", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.cEight.run(moveCard)
                    fadeOut()
                }
            }
            
            //Nine
            if defaults.string(forKey: "Card1") != "Clubs - 9" && defaults.string(forKey: "Card2") != "Clubs - 9"
            {
                if (pointOfTouch.x > (6.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (6.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Clubs - 9", forKey: "Card1")
                    }else{
                        defaults.set("Clubs - 9", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.cNine.run(moveCard)
                    fadeOut()
                }
            }
            
            //Ten
            if defaults.string(forKey: "Card1") != "Clubs - 10" && defaults.string(forKey: "Card2") != "Clubs - 10"
            {
                if (pointOfTouch.x > (8.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (8.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (5.25/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (5.25/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Clubs - 10", forKey: "Card1")
                    }else{
                        defaults.set("Clubs - 10", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.cTen.run(moveCard)
                    fadeOut()
                }
            }
            
            //Jack
            if defaults.string(forKey: "Card1") != "Clubs - 11" && defaults.string(forKey: "Card2") != "Clubs - 11"
            {
                if (pointOfTouch.x > (2.6/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (2.6/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Clubs - 11", forKey: "Card1")
                    }else{
                        defaults.set("Clubs - 11", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.cJack.run(moveCard)
                    fadeOut()
                }
            }
            
            //Queen
            if defaults.string(forKey: "Card1") != "Clubs - 12" && defaults.string(forKey: "Card2") != "Clubs - 12"
            {
                if (pointOfTouch.x > (4.2/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (4.2/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Clubs - 12", forKey: "Card1")
                    }else{
                        defaults.set("Clubs - 12", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.cQueen.run(moveCard)
                    fadeOut()
                }
            }
            
            //King
            if defaults.string(forKey: "Card1") != "Clubs - 13" && defaults.string(forKey: "Card2") != "Clubs - 13"
            {
                if (pointOfTouch.x > (5.8/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (5.8/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Clubs - 13", forKey: "Card1")
                    }else{
                        defaults.set("Clubs - 13", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.cKing.run(moveCard)
                    fadeOut()
                }
            }
            
            //Ace
            if defaults.string(forKey: "Card1") != "Clubs - 14" && defaults.string(forKey: "Card2") != "Clubs - 14"
            {
                if (pointOfTouch.x > (7.4/10 * self.size.width - cardWidth/2) && pointOfTouch.x < (7.4/10 * self.size.width + cardWidth/2)) && (pointOfTouch.y > (7.75/10 * self.size.height - cardHeight/2) && pointOfTouch.y < (7.75/10 * self.size.height + cardHeight/2))
                {
                    if defaults.string(forKey: "Card1") == "None"
                    {
                        defaults.set("Clubs - 14", forKey: "Card1")
                    }else{
                        defaults.set("Clubs - 14", forKey: "Card2")
                        skipScene()
                    }
                    
                    Cards.cAce.run(moveCard)
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
    
    func changeScene()
    {
        Cards.cTwo.removeFromParent(); Cards.cThree.removeFromParent(); Cards.cFour.removeFromParent(); Cards.cFive.removeFromParent()
        Cards.cSix.removeFromParent(); Cards.cSeven.removeFromParent(); Cards.cEight.removeFromParent(); Cards.cNine.removeFromParent(); Cards.cTen.removeFromParent()
        Cards.cJack.removeFromParent(); Cards.cQueen.removeFromParent(); Cards.cKing.removeFromParent(); Cards.cAce.removeFromParent()
        
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
        
        print("here")
        let sceneToMoveTo = checkYourCards(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
