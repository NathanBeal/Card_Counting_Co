//
//  GameScene.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/5/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    
    let background = SKSpriteNode(imageNamed: "background")
    let diamonds = SKSpriteNode(imageNamed: "Diamond")
    let hearts = SKSpriteNode(imageNamed: "Heart")
    let clubs = SKSpriteNode(imageNamed: "Clubs")
    let spades = SKSpriteNode(imageNamed: "Spades")
    let selectLabel = SKLabelNode()
    let gameArea: CGRect
    
    let backArrow = SKSpriteNode(imageNamed: "backArr")
    var backArrXCoord = CGFloat()
    var backArrYCoord = CGFloat()
    
    let generatedHand = SKLabelNode()
    
    var Scaler = CGFloat()
    var sceneToMoveTo = SKScene()
    var temp = SKSpriteNode(); var temp2 = SKSpriteNode()
    
    //Used for boundaries
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
        skipScene()
        
        //Scalers
        if (defaults.double(forKey: "FrameWidth") == 896 && defaults.double(forKey: "FrameHeight") == 414) || (defaults.double(forKey: "FrameWidth") == 375 && defaults.double(forKey: "FrameHeight") == 812)
        {
            Scaler = 0.9
        }else{
            if (defaults.double(forKey: "FrameWidth") == 736 && defaults.double(forKey: "FrameHeight") == 414)
            {
                Scaler = CGFloat(0.82)
            }else{
                Scaler = CGFloat(scaleModifier)
            }
        }
        
        checkHand()
        displayCards()
        
        //Background
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        hearts.setScale(CGFloat(0.25 * Scaler))
        hearts.position = CGPoint(x: 1.5 * self.size.width/6, y: self.size.height/2)
        hearts.zPosition = 1
        hearts.alpha = 0
        self.addChild(hearts)
        
        clubs.setScale(CGFloat(0.25 * Scaler))
        clubs.position = CGPoint(x: 2.5 * self.size.width/6, y: self.size.height/2)
        clubs.zPosition = 1
        clubs.alpha = 0
        self.addChild(clubs)
        
        diamonds.setScale(CGFloat(0.25 * Scaler))
        diamonds.position = CGPoint(x: 3.5 * self.size.width/6, y: self.size.height/2)
        diamonds.zPosition = 1
        diamonds.alpha = 0
        self.addChild(diamonds)
        
        spades.setScale(CGFloat(0.25 * Scaler))
        spades.position = CGPoint(x: 4.5 * self.size.width/6, y: self.size.height/2)
        spades.zPosition = 1
        spades.alpha = 0
        self.addChild(spades)
        
        selectLabel.fontName = "Copperplate-Light"
        selectLabel.text = "select your dealt hand"
        selectLabel.fontSize = CGFloat(50 * Scaler)
        selectLabel.fontColor = SKColor.white
        selectLabel.position = CGPoint(x: self.size.width/2, y: 8 * self.size.height/10)
        selectLabel.zPosition = 10
        selectLabel.alpha = 0
        self.addChild(selectLabel)
        
        generatedHand.fontName = "Copperplate-Light"
        generatedHand.text = "click here for random hand"
        generatedHand.fontSize = CGFloat(33 * Scaler)
        generatedHand.fontColor = SKColor.white
        generatedHand.position = CGPoint(x: self.size.width/2, y: 1.6 * self.size.height/10)
        generatedHand.zPosition = 10
        generatedHand.alpha = 0
        
        if defaults.double(forKey: "gameMode") == 1
        {
            self.addChild(generatedHand)
        }
        if defaults.string(forKey: "Card1") != "None" || defaults.string(forKey: "Card2") != "None"
        {
            generatedHand.removeFromParent()
        }
        
        /*
        //Back Arrow
        Cards.hTwo.setScale(0.15 * Scaler)
        Cards.hTwo.position = CGPoint(x: 2.6 * self.size.width/10, y: 3 * self.size.height/4)
        Cards.hTwo.zPosition = 1
        backArrow.setScale(CGFloat(0.65 * scaleModifier))
        //let Offset = self.size.height - backArrow.size.height/2 - 9 * self.size.height/10
        //backArrXCoord = Offset + backArrow.size.width/2
        //backArrYCoord = 9 * self.size.height/10
        backArrXCoord = (1.8 * self.size.width/10 -  Cards.hTwo.size.width/2)/2
        backArrYCoord = self.size.height/2
        backArrow.position = CGPoint(x: backArrXCoord, y: backArrYCoord)
        backArrow.zPosition = 10
        self.addChild(backArrow)
         */
        
        fadeIn()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            let cardWidth = hearts.size.width
            let cardHeight = hearts.size.height
            
            //Generate Cards
            if defaults.string(forKey: "Card1") == "None" && defaults.string(forKey: "Card2") == "None"
            {
                if (pointOfTouch.x > 3 * self.size.width/10 && pointOfTouch.x < 7 * self.size.width/10) && (pointOfTouch.y > 8.2 * self.size.height/10 && pointOfTouch.y < 8.6 * self.size.height/10)
                {
                    //self.removeAllChildren()
                    defaults.set(randAvailCard(), forKey: "Card1")
                    defaults.set(randAvailCard(), forKey: "Card2")
                    fadeOut(exitNumber: 5)
                }
            }
            
            //Heart Card
            if (pointOfTouch.x > (1.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x < (1.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                fadeOut(exitNumber: 0)
            }
            
            //Club Card
            if (pointOfTouch.x > (2.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x < (2.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                fadeOut(exitNumber: 1)
            }
            
            //Diamond Card
            if (pointOfTouch.x > (3.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x < (3.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                fadeOut(exitNumber: 2)
            }
            
            //Spade Card
            if (pointOfTouch.x > (4.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x < (4.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                fadeOut(exitNumber: 3)
            }
        }
    }
    
    func checkHand()
    {
        if defaults.double(forKey: "gameMode") == 0
        {
            if defaults.string(forKey: "Card1") != "None" && defaults.string(forKey: "Card2") != "None"
            {
                fadeOut(exitNumber: 4)
            }else{}
        }else{
            if defaults.string(forKey: "Card1") != "None" && defaults.string(forKey: "Card2") != "None"
            {
                fadeOut(exitNumber: 4)
            }
        }
    }
    
    func displayCards()
    {
        let key1 = defaults.string(forKey: "Card1")
        let key2 = defaults.string(forKey: "Card2")
        
        
        
        if key1 != "None" && key2 == "None"
        {
            temp = SKSpriteNode(imageNamed: defaults.string(forKey: "Card1")!)
            
            temp.setScale(0.125)
            temp.position = CGPoint(x: self.size.width/2, y: 1.5 * self.size.height/10)
            temp.zPosition = 1
            temp.alpha = 0
            self.addChild(temp)
        }
        
        if key1 != "None" && key2 != "None"
        {
            temp = SKSpriteNode(imageNamed: defaults.string(forKey: "Card1")!)
            
            temp.setScale(0.125)
            temp.position = CGPoint(x: self.size.width/2.15, y: 1.5 * self.size.height/10)
            temp.zPosition = 1
            temp.alpha = 0
            self.addChild(temp)
            
            temp2 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card2")!)
            temp2.setScale(0.125)
            temp2.position = CGPoint(x: self.size.width/1.85, y: 1.5 * self.size.height/10)
            temp2.zPosition = 1
            temp2.alpha = 0
            self.addChild(temp2)
        }
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
        let randomCard = cards[Int.random(in:0 ..< cards.count-1)]
        
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
        hearts.run(fadeIn); clubs.run(fadeIn); diamonds.run(fadeIn); spades.run(fadeIn)
        selectLabel.run(fadeIn); generatedHand.run(fadeIn)
        temp.run(fadeIn); temp2.run(fadeIn)
    }
    
    func fadeOut(exitNumber: Int)
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        hearts.run(fadeOut); clubs.run(fadeOut); diamonds.run(fadeOut); spades.run(fadeOut)
        selectLabel.run(fadeOut); generatedHand.run(fadeOut)
        temp.run(fadeOut); temp2.run(fadeOut)
        
        if exitNumber == 0
        {
            sceneToMoveTo = heartSelect(size: self.size)
        }
        if exitNumber == 1
        {
            sceneToMoveTo = clubSelect(size: self.size)
        }
        if exitNumber == 2
        {
            sceneToMoveTo = diamondSelect(size: self.size)
        }
        if exitNumber == 3
        {
            sceneToMoveTo = spadeSelect(size: self.size)
        }
        if exitNumber == 4
        {
            sceneToMoveTo = checkYourCards(size: self.size)
        }
        if exitNumber == 5
        {
            sceneToMoveTo = genRandHand(size: self.size)
        }
        
        let seq = SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run(exit)])
        self.run(seq)
    }
    
    func exit()
    {
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
    
    func skipScene()
    {
    }
}

