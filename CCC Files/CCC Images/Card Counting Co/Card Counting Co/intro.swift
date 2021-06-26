//
//  intro.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/7/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

//let defaults = UserDefaults()

class intro: SKScene
{
    
    let background = SKSpriteNode(imageNamed: "whiteBackground")
    let author = SKSpriteNode(imageNamed: "StudioTitle")
    let mascot = SKSpriteNode(imageNamed: "SilhoutteClown")
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
        //Background
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        mascot.setScale(CGFloat(0.2 * scaleModifier))
        mascot.position = CGPoint(x: self.size.width/2, y: 5.75 * self.size.height/10)
        mascot.zPosition = 2
        self.addChild(mascot)
        
        //mascot.run(SKAction.fadeIn(withDuration: 1.5))
        
        author.setScale(CGFloat(0.2 * scaleModifier))
        author.position = CGPoint(x: self.size.width/2, y: 3 * self.size.height/10)
        author.zPosition = 3
        //author.run(SKAction.fadeIn(withDuration: 3))
        self.addChild(author)
        
        
        print(defaults.double(forKey: "FrameWidth"))
        
        let step1 = SKAction.wait(forDuration:  2)
        let step2 = SKAction.run(changeScenes)
        let endSequence = SKAction.sequence([step1,step2])
        self.run(endSequence)
        
    }
    
    func changeScenes()
    {
        self.removeAllChildren()
        let sceneToMoveTo = startScreen(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  1.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for _: AnyObject in touches
        {
            self.removeAllChildren()
            let sceneToMoveTo = startScreen(size: self.size)
            sceneToMoveTo.scaleMode = self.scaleMode
            let myTransition = SKTransition.fade(withDuration:  1.0)
            self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            
        }
    }
}
