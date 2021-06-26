//
//  numberOfPlayers.swift
//  Card Counting Co
//
//  Created by ADAMLANE on 6/10/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class numberOfPlayers: SKScene
{
    //Sprite Nodes
    let background = SKSpriteNode(imageNamed: "background")
    let onePlayer = SKSpriteNode(imageNamed: "onePlayer")
    let twoPlayers = SKSpriteNode(imageNamed: "twoPlayers")
    let threePlayers = SKSpriteNode(imageNamed: "threePlayers")
    let fourPlayers = SKSpriteNode(imageNamed: "fourPlayers")
    let fivePlayers = SKSpriteNode(imageNamed: "fivePlayers")
    let sixPlayers = SKSpriteNode(imageNamed: "sixPlayers")
    
    //Unsubstatiated Variables
    let Directions = SKLabelNode()
    let belowLabel = SKLabelNode()
    
    //Variables
    var Scaler = CGFloat()
    
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
            Scaler = 0.9
        }else{
            if (defaults.double(forKey: "FrameWidth") == 736 && defaults.double(forKey: "FrameHeight") == 414)
            {
                Scaler = CGFloat(0.82)
            }else{
                Scaler = CGFloat(scaleModifier)
            }
        }

        //Background
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        //Labels
        Directions.fontName = "Copperplate-Light"
        Directions.text = "number of players"
        Directions.fontSize = CGFloat(50 * Scaler)
        Directions.fontColor = SKColor.white
        Directions.position = CGPoint(x: self.size.width/2, y: 8 * self.size.height/10)
        Directions.zPosition = 10
        Directions.alpha = 0
        self.addChild(Directions)
        
        belowLabel.fontName = "Copperplate-Light"
        belowLabel.text = "(yourself included)"
        belowLabel.fontSize = CGFloat(27 * Scaler)
        belowLabel.fontColor = SKColor.white
        belowLabel.position = CGPoint(x: self.size.width/2, y: 7.5 * self.size.height/10)
        belowLabel.zPosition = 10
        belowLabel.alpha = 0
        self.addChild(belowLabel)
        
        //Buttons
        onePlayer.setScale(CGFloat(0.8 * Scaler))
        onePlayer.position = CGPoint(x: 1.5 * self.size.width/8, y: self.size.height/2)
        onePlayer.zPosition = 1
        onePlayer.alpha = 0
        self.addChild(onePlayer)
        
        twoPlayers.setScale(CGFloat(0.8 * Scaler))
        twoPlayers.position = CGPoint(x: 2.5 * self.size.width/8, y: self.size.height/2)
        twoPlayers.zPosition = 1
        twoPlayers.alpha = 0
        self.addChild(twoPlayers)
        
        threePlayers.setScale(CGFloat(0.8 * Scaler))
        threePlayers.position = CGPoint(x: 3.5 * self.size.width/8, y: self.size.height/2)
        threePlayers.zPosition = 1
        threePlayers.alpha = 0
        self.addChild(threePlayers)
        
        fourPlayers.setScale(CGFloat(0.8 * Scaler))
        fourPlayers.position = CGPoint(x: 4.5 * self.size.width/8, y: self.size.height/2)
        fourPlayers.zPosition = 1
        fourPlayers.alpha = 0
        self.addChild(fourPlayers)
        
        fivePlayers.setScale(CGFloat(0.8 * Scaler))
        fivePlayers.position = CGPoint(x: 5.5 * self.size.width/8, y: self.size.height/2)
        fivePlayers.zPosition = 1
        fivePlayers.alpha = 0
        self.addChild(fivePlayers)
        
        sixPlayers.setScale(CGFloat(0.8 * Scaler))
        sixPlayers.position = CGPoint(x: 6.5 * self.size.width/8, y: self.size.height/2)
        sixPlayers.zPosition = 1
        sixPlayers.alpha = 0
        self.addChild(sixPlayers)
        
        fadeIn()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            let buttonSize = onePlayer.size.width
            
            //One Player
            if (pointOfTouch.x > (1.5 * self.size.width/8 - buttonSize/2) && pointOfTouch.x < (1.5 * self.size.width/6 + buttonSize/2)) && (pointOfTouch.y > (self.size.height/2 - buttonSize/2) && pointOfTouch.y < (self.size.height/2 + buttonSize/2))
            {
                defaults.set(1.0, forKey: "numberOfPlayers")
                defaults.set(1.0, forKey: "tempNumberOfPlayers")
                fadeOut()
            }
            
            //Two Players
            if (pointOfTouch.x > (2.5 * self.size.width/8 - buttonSize/2) && pointOfTouch.x < (2.5 * self.size.width/6 + buttonSize/2)) && (pointOfTouch.y > (self.size.height/2 - buttonSize/2) && pointOfTouch.y < (self.size.height/2 + buttonSize/2))
            {
                defaults.set(2.0, forKey: "numberOfPlayers")
                defaults.set(2.0, forKey: "tempNumberOfPlayers")
                fadeOut()
            }
            
            //Three Players
            if (pointOfTouch.x > (3.5 * self.size.width/8 - buttonSize/2) && pointOfTouch.x < (3.5 * self.size.width/6 + buttonSize/2)) && (pointOfTouch.y > (self.size.height/2 - buttonSize/2) && pointOfTouch.y < (self.size.height/2 + buttonSize/2))
            {
                defaults.set(3.0, forKey: "numberOfPlayers")
                defaults.set(3.0, forKey: "tempNumberOfPlayers")
                fadeOut()
            }
            
            //Four Players
            if (pointOfTouch.x > (4.5 * self.size.width/8 - buttonSize/2) && pointOfTouch.x < (4.5 * self.size.width/6 + buttonSize/2)) && (pointOfTouch.y > (self.size.height/2 - buttonSize/2) && pointOfTouch.y < (self.size.height/2 + buttonSize/2))
            {
                defaults.set(4.0, forKey: "numberOfPlayers")
                defaults.set(4.0, forKey: "tempNumberOfPlayers")
                fadeOut()
            }
            
            //Five Players
            if (pointOfTouch.x > (5.5 * self.size.width/8 - buttonSize/2) && pointOfTouch.x < (5.5 * self.size.width/6 + buttonSize/2)) && (pointOfTouch.y > (self.size.height/2 - buttonSize/2) && pointOfTouch.y < (self.size.height/2 + buttonSize/2))
            {
                defaults.set(5.0, forKey: "numberOfPlayers")
                defaults.set(5.0, forKey: "tempNumberOfPlayers")
                fadeOut()
            }
            
            //Six Players
            if (pointOfTouch.x > (6.5 * self.size.width/8 - buttonSize/2) && pointOfTouch.x < (6.5 * self.size.width/6 + buttonSize/2)) && (pointOfTouch.y > (self.size.height/2 - buttonSize/2) && pointOfTouch.y < (self.size.height/2 + buttonSize/2))
            {
                defaults.set(6.0, forKey: "numberOfPlayers")
                defaults.set(6.0, forKey: "tempNumberOfPlayers")
                fadeOut()
            }
        }
    }
    
    func fadeIn()
    {
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        Directions.run(fadeIn); belowLabel.run(fadeIn)
        onePlayer.run(fadeIn); twoPlayers.run(fadeIn); threePlayers.run(fadeIn); fourPlayers.run(fadeIn); fivePlayers.run(fadeIn); sixPlayers.run(fadeIn)
    }
    
    func fadeOut()
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        Directions.run(fadeOut); belowLabel.run(fadeOut)
        onePlayer.run(fadeOut); twoPlayers.run(fadeOut); threePlayers.run(fadeOut); fourPlayers.run(fadeOut); fivePlayers.run(fadeOut); sixPlayers.run(fadeOut)
        
        let seq = SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run(exit)])
        self.run(seq)
    }
    
    func exit()
    {
        let sceneToMoveTo = GameScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
