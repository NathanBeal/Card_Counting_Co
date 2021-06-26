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


//let scaleModifier = defaults.double(forKey: "scaleMod")
let selfWidth = defaults.double(forKey: "FrameWidth")
var selfHeight = defaults.double(forKey: "FrameHeight")
class intro: SKScene
{
    let background = SKSpriteNode(imageNamed: "whiteBackground")
    let author = SKSpriteNode(imageNamed: "StudioTitle")
    let mascot = SKSpriteNode(imageNamed: "Logo")
    let gameArea: CGRect
    
    var backgroundScaler = 0.0
    
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
        if (defaults.double(forKey: "FrameWidth") == 896 && defaults.double(forKey: "FrameHeight") == 414) || (defaults.double(forKey: "FrameWidth") == 275 && defaults.double(forKey: "FrameHeight") == 812)
        {
            backgroundScaler = 1.25
        }else{
            backgroundScaler = 1
        }
        
        //Background
        background.size = self.size
        background.setScale(CGFloat(backgroundScaler))
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        mascot.setScale(CGFloat(0.15))
        mascot.position = CGPoint(x: self.size.width/2, y: 5.75 * self.size.height/10)
        mascot.zPosition = 2
        self.addChild(mascot)
        
        mascot.run(SKAction.fadeIn(withDuration: 1.5))
        
        author.setScale(CGFloat(0.15))
        author.position = CGPoint(x: self.size.width/2, y: 3 * self.size.height/10)
        author.zPosition = 3
        author.run(SKAction.fadeIn(withDuration: 3))
        self.addChild(author)
        
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
