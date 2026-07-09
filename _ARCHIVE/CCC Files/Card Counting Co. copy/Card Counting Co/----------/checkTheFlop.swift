//
//  checkTheFlop.swift
//  Card Counting Co
//
//  Created by ADAMLANE on 6/10/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class checkTheFlop: SKScene
{
    /*
     let gameArea: CGRect
     
     let background = SKSpriteNode(imageNamed: "background")
     let card1 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card1")!)
     let card2 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card2")!)
     let questionLabel = SKLabelNode()
     
     let yesLabel = SKLabelNode()
     let noLabel = SKLabelNode()
     let yesButton = SKSpriteNode(imageNamed: "yesLabel")
     let noButton = SKSpriteNode(imageNamed: "noLabel")
     
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
     
     //Labels
     questionLabel.fontName = "Copperplate-Light"
     questionLabel.text = "this is your hand?"
     questionLabel.fontSize = 37.5
     questionLabel.fontColor = SKColor.white
     questionLabel.position = CGPoint(x: self.size.width/2, y: 8 * self.size.height/10)
     questionLabel.zPosition = 10
     self.addChild(questionLabel)
     
     //Labels
     
     yesButton.setScale(0.8)
     yesButton.position = CGPoint(x: 2.5 * self.size.width/6, y: 1.7 * self.size.height/10)
     yesButton.zPosition = 1
     //self.addChild(yesButton)
     noButton.setScale(0.8)
     noButton.position = CGPoint(x: 3.5 * self.size.width/6, y: 1.7 * self.size.height/10)
     noButton.zPosition = 1
     //self.addChild(noButton)
     
     yesLabel.fontName = "Copperplate-Light"
     yesLabel.text = "yes"
     yesLabel.fontSize = 37.5
     yesLabel.fontColor = SKColor.white
     yesLabel.position = CGPoint(x: 2.5 * self.size.width/6, y: 1.7 * self.size.height/10)
     yesLabel.zPosition = 10
     self.addChild(yesLabel)
     
     noLabel.fontName = "Copperplate-Light"
     noLabel.text = "no"
     noLabel.fontSize = 37.5
     noLabel.fontColor = SKColor.white
     noLabel.position = CGPoint(x: 3.5 * self.size.width/6, y: 1.7 * self.size.height/10)
     noLabel.zPosition = 10
     self.addChild(noLabel)
     
     }
     
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
     {
     for touch: AnyObject in touches
     {
     let pointOfTouch = touch.location(in: view)
     let buttonWidth = yesButton.size.width
     let buttonHeight = noButton.size.height
     
     if (pointOfTouch.x > (2.5 * self.size.width/6 - buttonWidth/2) && pointOfTouch.x < (2.5 * self.size.width/6 + buttonWidth/2)) && (pointOfTouch.y > (8.3 * self.size.height/10 - buttonHeight/2) && pointOfTouch.y < (8.3 * self.size.height/10 + buttonHeight/2))
     {
     self.removeAllChildren()
     let sceneToMoveTo = gamePlay(size: self.size)
     sceneToMoveTo.scaleMode = self.scaleMode
     let myTransition = SKTransition.fade(withDuration:  1.0)
     self.view!.presentScene(sceneToMoveTo, transition: myTransition)
     }
     
     if (pointOfTouch.x > (3.5 * self.size.width/6 - buttonWidth/2) && pointOfTouch.x < (3.5 * self.size.width/6 + buttonWidth/2)) && (pointOfTouch.y > (8.3 * self.size.height/10 - buttonHeight/2) && pointOfTouch.y < (8.3 * self.size.height/10 + buttonHeight/2))
     {
     self.removeAllChildren()
     defaults.set("None", forKey: "Card1")
     defaults.set("None", forKey: "Card2")
     //print(defaults.string(forKey: "Card1") as Any)
     let sceneToMoveTo = GameScene(size: self.size)
     sceneToMoveTo.scaleMode = self.scaleMode
     let myTransition = SKTransition.fade(withDuration:  1.0)
     self.view!.presentScene(sceneToMoveTo, transition: myTransition)
     }
     }
     }
     */
}
