//
//  GameScene2.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/7/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

//let defaults = UserDefaults()

class GameSceneFlop: SKScene
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
        
        hearts.setScale(0.25)
        hearts.position = CGPoint(x: 1.5 * self.size.width/6, y: self.size.height/2)
        hearts.zPosition = 1
        self.addChild(hearts)
        
        diamonds.setScale(0.25)
        diamonds.position = CGPoint(x: 2.5 * self.size.width/6, y: self.size.height/2)
        diamonds.zPosition = 1
        self.addChild(diamonds)
        
        clubs.setScale(0.25)
        clubs.position = CGPoint(x: 3.5 * self.size.width/6, y: self.size.height/2)
        clubs.zPosition = 1
        self.addChild(clubs)
        
        spades.setScale(0.25)
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
                let sceneToMoveTo = heartSelectFlop(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            //Diamond Card
            if (pointOfTouch.x > (2.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x < (2.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                self.removeAllChildren()
                let sceneToMoveTo = diamondSelectFlop(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            //Club Card
            if (pointOfTouch.x > (3.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x < (3.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                self.removeAllChildren()
                let sceneToMoveTo = clubSelectFlop(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            //Spade Card
            if (pointOfTouch.x > (4.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x < (4.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                self.removeAllChildren()
                let sceneToMoveTo = spadeSelectFlop(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
    }
    
    //Good
    func checkHand()
    {
        if defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") != "None"
        {
            self.removeAllChildren()
            let sceneToMoveTo = gamePlay(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration:  1.0)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        }
    }
    
    //All Good
    func displayCards()
    {
        let key1 = defaults.string(forKey: "Flop1")
        let key2 = defaults.string(forKey: "Flop2")
        let key3 = defaults.string(forKey: "Flop3")
        
        
        if key1 != "None" && key2 == "None" && key3 == "None"
        {
            let temp = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop1")!)
            
            temp.setScale(0.125)
            temp.position = CGPoint(x: self.size.width/2, y: 1.5 * self.size.height/10)
            temp.zPosition = 1
            self.addChild(temp)
        }
        
        
        if key1 != "None" && key2 != "None" && key3 == "None"
        {
            let temp = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop1")!)
            
            temp.setScale(0.125)
            temp.position = CGPoint(x: self.size.width/2.15, y: 1.5 * self.size.height/10)
            temp.zPosition = 1
            self.addChild(temp)
            
            let temp2 = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop2")!)
            temp2.setScale(0.125)
            temp2.position = CGPoint(x: self.size.width/1.85, y: 1.5 * self.size.height/10)
            temp2.zPosition = 1
            self.addChild(temp2)
        }
        
        if key1 != "None" && key2 != "None" && key3 != "None"
        {
            let temp = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop1")!)
            
            temp.setScale(0.125)
            temp.position = CGPoint(x: self.size.width/2.45, y: 1.5 * self.size.height/10)
            temp.zPosition = 1
            self.addChild(temp)
            
            let temp2 = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop2")!)
            temp2.setScale(0.125)
            temp2.position = CGPoint(x: self.size.width/2, y: 1.5 * self.size.height/10)
            temp2.zPosition = 1
            self.addChild(temp2)
            
            let temp3 = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop3")!)
            temp3.setScale(0.125)
            temp3.position = CGPoint(x: self.size.width/1.65, y: 1.5 * self.size.height/10)
            temp3.zPosition = 1
            self.addChild(temp3)
        }
    }
    
}
