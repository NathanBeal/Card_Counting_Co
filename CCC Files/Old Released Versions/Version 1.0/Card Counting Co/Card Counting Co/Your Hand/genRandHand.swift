//
//  genRandHand.swift
//  Card Counting Co
//
//  Created by ADAMLANE on 6/20/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class genRandHand: SKScene
{
    let gameArea: CGRect
    
    let background = SKSpriteNode(imageNamed: "background")
    var firstCard1 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card1")!)
    var firstCard2 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card2")!)
    var card1 = SKSpriteNode()
    var card2 = SKSpriteNode()
    let ttGC = SKLabelNode()
    let thGC = SKLabelNode()
    
    var Scaler = CGFloat()
    
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
        
        firstCard1.setScale(CGFloat(0.25 * Scaler))
        firstCard1.position = CGPoint(x: 2.63 * self.size.width/6, y: self.size.height/2)
        firstCard1.zPosition = 1
        firstCard1.alpha = 0
        self.addChild(firstCard1)
        
        firstCard2.setScale(CGFloat(0.25 * Scaler))
        firstCard2.position = CGPoint(x: 3.37 * self.size.width/6, y: self.size.height/2)
        firstCard2.zPosition = 1
        firstCard2.alpha = 0
        self.addChild(firstCard2)
        
        //Labels
        ttGC.fontName = "Copperplate-Light"
        ttGC.text = "tap on cards to generate new hand"
        ttGC.fontSize = CGFloat(37.5 * Scaler)
        ttGC.fontColor = SKColor.white
        ttGC.position = CGPoint(x: self.size.width/2, y: 8 * self.size.height/10)
        ttGC.zPosition = 10
        ttGC.alpha = 0
        self.addChild(ttGC)
        
        thGC.fontName = "Copperplate-Light"
        thGC.text = "tap here to continue"
        thGC.fontSize = CGFloat(37.5 * Scaler)
        thGC.fontColor = SKColor.white
        thGC.position = CGPoint(x: self.size.width/2, y: 1.5 * self.size.height/10)
        thGC.zPosition = 10
        thGC.alpha = 0
        self.addChild(thGC)
        
        let fadeInFadeOut = SKAction.sequence([SKAction.fadeIn(withDuration: 1.0),SKAction.fadeOut(withDuration: 1.0)])
        thGC.run(SKAction.repeatForever(fadeInFadeOut))
        
        fadeIn()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            let cardWidth = firstCard1.size.width
            let cardHeight = firstCard1.size.height
            
            if (pointOfTouch.x > 2.63 * self.size.width/6 - cardWidth/2 && pointOfTouch.x < 3.37 * self.size.width/6 + cardWidth/2) && (pointOfTouch.y > self.size.height/2 - cardHeight/2 && pointOfTouch.y < self.size.height/2 + cardHeight/2)
            {
                firstCard1.removeFromParent()
                firstCard2.removeFromParent()
                generateNewCard1()
                generateNewCard2()
            }
            
            //Continue
            if (pointOfTouch.x > 2.5 * self.size.width/10  && pointOfTouch.x < 7.5 * self.size.width/10) && (pointOfTouch.y > 8.5 * self.size.height/10 - 1 * self.size.height/15 && pointOfTouch.y < 8.5 * self.size.height/10 + 1 * self.size.height/15)
            {
                fadeOut()
            }
            
        }
    }
    
    func generateNewCard1()
    {
        let s = randAvailCard()
        defaults.set(s, forKey: "Card1")
        firstCard1 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card1")!)
        firstCard1.setScale(CGFloat(0.25 * Scaler))
        firstCard1.position = CGPoint(x: 2.63 * self.size.width/6, y: self.size.height/2)
        firstCard1.zPosition = 1
        self.addChild(firstCard1)
    }
    
    func generateNewCard2()
    {
        let s = randAvailCard()
        defaults.set(s, forKey: "Card2")
        firstCard2 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card2")!)
        firstCard2.setScale(CGFloat(0.25 * Scaler))
        firstCard2.position = CGPoint(x: 3.37 * self.size.width/6, y: self.size.height/2)
        firstCard2.zPosition = 1
        self.addChild(firstCard2)
    }
    
    
    func randAvailCard() -> String
    {
        var unavailCards = [String]()
        
        if (defaults.string(forKey: "Card1") != "None")
        {
            unavailCards.append(defaults.string(forKey: "Card1")!);
        }
        
        if (defaults.string(forKey: "Card1") != "None")
        {
            unavailCards.append(defaults.string(forKey: "Card2")!)
        }
        
        var cards = allCardsArray()
        //print(cards)
        var adjustCount = 0
        if cards.count != 0
        {
            for i in 0...cards.count-1
            {
                for j in 0...unavailCards.count-1
                {
                    if(unavailCards[j] == cards[i])
                    {
                        cards.remove(at: i)
                        cards.append("")
                        adjustCount += 1
                    }
                }
            }
        }else{}
        
        let randomCard = cards[Int.random(in:0 ..< cards.count-1-adjustCount)]
        return randomCard
    }
    
    func allCardsArray() -> [String]
    {
        var cards = [String]()
        cards.append("Heart - 2"); cards.append("Heart - 3"); cards.append("Heart - 4"); cards.append("Heart - 5"); cards.append("Heart - 6"); cards.append("Heart - 7"); cards.append("Heart - 8"); cards.append("Heart - 9"); cards.append("Heart - 10"); cards.append("Heart - 11"); cards.append("Heart - 12"); cards.append("Heart - 13"); cards.append("Heart - 14");
        cards.append("Diamond - 2"); cards.append("Diamond - 3"); cards.append("Diamond - 4"); cards.append("Diamond - 5"); cards.append("Diamond - 6"); cards.append("Diamond - 7"); cards.append("Diamond - 8"); cards.append("Diamond - 9"); cards.append("Diamond - 10"); cards.append("Diamond - 11"); cards.append("Diamond - 12"); cards.append("Diamond - 13"); cards.append("Diamond - 14");
        cards.append("Spades - 2"); cards.append("Spades - 3"); cards.append("Spades - 4"); cards.append("Spades - 5"); cards.append("Spades - 6"); cards.append("Spades - 7"); cards.append("Spades - 8"); cards.append("Spades - 9"); cards.append("Spades - 10"); cards.append("Spades - 11"); cards.append("Spades - 12"); cards.append("Spades - 13"); cards.append("Spades - 14");
        cards.append("Clubs - 2"); cards.append("Clubs - 3"); cards.append("Clubs - 4"); cards.append("Clubs - 5"); cards.append("Clubs - 6"); cards.append("Clubs - 7"); cards.append("Clubs - 8"); cards.append("Clubs - 9"); cards.append("Clubs - 10"); cards.append("Clubs - 11"); cards.append("Clubs - 12"); cards.append("Clubs - 13"); cards.append("Clubs - 14");
        return cards
    }
    
    func fadeIn()
    {
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        
        card1.run(fadeIn); card2.run(fadeIn); firstCard1.run(fadeIn); firstCard2.run(fadeIn)
        thGC.run(fadeIn); ttGC.run(fadeIn)
    }
    
    func fadeOut()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        card1.run(fadeOut); card2.run(fadeOut); firstCard1.run(fadeOut); firstCard2.run(fadeOut)
        thGC.run(fadeOut); ttGC.run(fadeOut)
        
        let seq = SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run(exit)])
        self.run(seq)
    }
    
    func exit()
    {
        let sceneToMoveTo = gamePlaySim(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
