//
//  checkHand.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/7/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

//let defaults = UserDefaults()

class checkCards: SKScene
{
    
    let background = SKSpriteNode(imageNamed: "background")
    let card1 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card1")!)
    let card2 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card2")!)
    let questionLabel = SKLabelNode()
    let yesLabel = SKLabelNode()
    let noLabel = SKLabelNode()
    
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
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        card1.setScale(0.25)
        card1.position = CGPoint(x: 2.5 * self.size.width/6, y: self.size.height/2)
        card1.zPosition = 1
        self.addChild(card1)
        
        card2.setScale(0.25)
        card2.position = CGPoint(x: 3.5 * self.size.width/6, y: self.size.height/2)
        card2.zPosition = 1
        self.addChild(card2)
        
        questionLabel.fontName = "Courier New"
        questionLabel.text = "This is your hand?"
        questionLabel.fontSize = 37.5
        questionLabel.fontColor = SKColor.white
        questionLabel.position = CGPoint(x: self.size.width/2, y: 8 * self.size.height/10)
        questionLabel.zPosition = 10
        self.addChild(questionLabel)
        
        yesLabel.fontName = "Courier New"
        yesLabel.text = "Yes"
        yesLabel.fontSize = 37.5
        yesLabel.fontColor = SKColor.white
        yesLabel.position = CGPoint(x: 2.5 * self.size.width/6, y: 1.7 * self.size.height/10)
        yesLabel.zPosition = 10
        self.addChild(yesLabel)
        
        noLabel.fontName = "Courier New"
        noLabel.text = "No"
        noLabel.fontSize = 37.5
        noLabel.fontColor = SKColor.white
        noLabel.position = CGPoint(x: 3.5 * self.size.width/6, y: 1.7 * self.size.height/10)
        noLabel.zPosition = 10
        self.addChild(noLabel)
    }
    
    //BUG: Boundaries mad wierd but workish
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            let cardWidth = card1.size.width
            let cardHeight = card1.size.height
            
            print("\(pointOfTouch.x)   \(pointOfTouch.y)")
            
            print(2.5 * self.size.width/6)
            print(self.size.height/2)
            
            
            if (pointOfTouch.x < (2.5 * self.size.width/6 - cardWidth/2) && pointOfTouch.x > (2.5 * self.size.width/6 + cardWidth/2)) && (pointOfTouch.y > (self.size.height/2 - cardHeight/2) && pointOfTouch.y < (self.size.height/2 + cardHeight/2))
            {
                self.removeAllChildren()
                let sceneToMoveTo = gamePlay(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            if(pointOfTouch.x > self.size.width/1.8 && pointOfTouch.x < 3 * self.size.width/4) && (pointOfTouch.y > 0 && pointOfTouch.y < self.size.width/2.8)
            {
                defaults.set("None", forKey: "Card1")
                defaults.set("None", forKey: "Card2")
                print(defaults.string(forKey: "Card1") as Any)
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
        }
    }
}
