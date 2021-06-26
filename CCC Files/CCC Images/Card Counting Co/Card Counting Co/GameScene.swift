//
//  GameScene.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/5/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import SpriteKit
import GameplayKit

//let defaults = UserDefaults()

class GameScene: SKScene
{
    
    let background = SKSpriteNode(imageNamed: "background")
    let diamonds = SKSpriteNode(imageNamed: "Diamond")
    let hearts = SKSpriteNode(imageNamed: "Heart")
    let clubs = SKSpriteNode(imageNamed: "Clubs")
    let spades = SKSpriteNode(imageNamed: "Spades")
    let gameArea: CGRect
    
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
        checkHand()
        displayCards()
        //Background
        
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        hearts.setScale(CGFloat(0.25 * scaleModifier))
        hearts.position = CGPoint(x: 1.5 * self.size.width/6, y: self.size.height/2)
        hearts.zPosition = 1
        self.addChild(hearts)
        
        diamonds.setScale(CGFloat(0.25 * scaleModifier))
        diamonds.position = CGPoint(x: 2.5 * self.size.width/6, y: self.size.height/2)
        diamonds.zPosition = 1
        self.addChild(diamonds)
        
        clubs.setScale(CGFloat(0.25 * scaleModifier))
        clubs.position = CGPoint(x: 3.5 * self.size.width/6, y: self.size.height/2)
        clubs.zPosition = 1
        self.addChild(clubs)
        
        spades.setScale(CGFloat(0.25 * scaleModifier))
        spades.position = CGPoint(x: 4.5 * self.size.width/6, y: self.size.height/2)
        spades.zPosition = 1
        self.addChild(spades)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            let cardWidth = hearts.size.width
            let cardHeight = hearts.size.height
            
            //Heart Card
            if (pointOfTouch.x > (1.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x < (1.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                self.removeAllChildren()
                let sceneToMoveTo = heartSelect(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            //Diamond Card
            if (pointOfTouch.x > (2.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x < (2.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                self.removeAllChildren()
                let sceneToMoveTo = diamondSelect(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            //Club Card
            if (pointOfTouch.x > (3.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x < (3.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                self.removeAllChildren()
                let sceneToMoveTo = clubSelect(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            //Spade Card
            if (pointOfTouch.x > (4.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x < (4.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                self.removeAllChildren()
                let sceneToMoveTo = spadeSelect(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
    }
    
    func checkHand()
    {
        if defaults.string(forKey: "Card1") != "None" && defaults.string(forKey: "Card2") != "None"
        {
            self.removeAllChildren()
            let sceneToMoveTo = gamePlay(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration:  1.0)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        }else{}
    }
    
    func displayCards()
    {
        let key1 = defaults.string(forKey: "Card1")
        let key2 = defaults.string(forKey: "Card2")
        
        if key1 != "None" && key2 == "None"
        {
            let temp = SKSpriteNode(imageNamed: defaults.string(forKey: "Card1")!)
            
            temp.setScale(0.125)
            temp.position = CGPoint(x: self.size.width/2, y: 1.5 * self.size.height/10)
            temp.zPosition = 1
            self.addChild(temp)
        }
        
        
        if key1 != "None" && key2 != "None"
        {
            let temp = SKSpriteNode(imageNamed: defaults.string(forKey: "Card1")!)
            
            temp.setScale(0.125)
            temp.position = CGPoint(x: self.size.width/2.15, y: 1.5 * self.size.height/10)
            temp.zPosition = 1
            self.addChild(temp)
            
            let temp2 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card2")!)
            temp2.setScale(0.125)
            temp2.position = CGPoint(x: self.size.width/1.85, y: 1.5 * self.size.height/10)
            temp2.zPosition = 1
            self.addChild(temp2)
        }
        
    }
    
}

