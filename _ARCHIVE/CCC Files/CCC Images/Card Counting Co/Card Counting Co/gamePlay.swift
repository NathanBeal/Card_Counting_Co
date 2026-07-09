//
//  gamePlay.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/6/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

//let defaults = UserDefaults()
let scaleModifier = defaults.double(forKey: "FrameWidth")/896

class gamePlay: SKScene
{
    let background = SKSpriteNode(imageNamed: "background")
    let card1 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card1")!)
    let card2 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card2")!)
    
    let cardPile = SKSpriteNode(imageNamed: "Back Of Card")
    let burnPile = SKSpriteNode(imageNamed: "Card Outline")
    
    var flopOneCard = SKSpriteNode()
    var flopTwoCard = SKSpriteNode()
    var flopThreeCard = SKSpriteNode()
    var turnCard = SKSpriteNode()
    var riverCard = SKSpriteNode()
    
    var flopDone = false
    var turnDone = false
    var riverDone = false
    
    var exit = false
    
    let ttpLabel = SKLabelNode()
    
    
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
        
        card1.setScale(CGFloat(0.165 * scaleModifier))
        card1.position = CGPoint(x: self.size.width/2 - self.size.width/22, y: 2 * self.size.height/10)
        card1.zPosition = 1
        self.addChild(card1)
        
        card2.setScale(CGFloat(0.165 * scaleModifier))
        card2.position = CGPoint(x: self.size.width/2 + self.size.width/22, y: 2 * self.size.height/10)
        card2.zPosition = 1
        self.addChild(card2)
        
        cardPile.setScale(CGFloat(0.165 * scaleModifier))
        cardPile.position = CGPoint(x: 4.5 * self.size.width/16, y: 6.75 * self.size.height/10)
        cardPile.zPosition = 1
        self.addChild(cardPile)
        
        burnPile.setScale(CGFloat(0.165 * scaleModifier))
        burnPile.position = CGPoint(x: 3 * self.size.width/16, y: 6.75 * self.size.height/10)
        burnPile.zPosition = 1
        self.addChild(burnPile)
        
        if (defaults.string(forKey: "Flop1") == "None")
        {
            flopOneCard = SKSpriteNode(imageNamed: "Card Outline")
        }else{
            flopOneCard = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop1")!)
        }
        flopOneCard.setScale(CGFloat(0.165 * scaleModifier))
        flopOneCard.position = CGPoint(x: 6 * self.size.width/16, y: 6.75 * self.size.height/10)
        flopOneCard.zPosition = 1
        self.addChild(flopOneCard)
        
        if (defaults.string(forKey: "Flop2") == "None")
        {
            flopTwoCard = SKSpriteNode(imageNamed: "Card Outline")
        }else{
            flopTwoCard = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop2")!)
        }
        flopTwoCard.setScale(CGFloat(0.165 * scaleModifier))
        flopTwoCard.position = CGPoint(x: 7.5 * self.size.width/16, y: 6.75 * self.size.height/10)
        flopTwoCard.zPosition = 1
        self.addChild(flopTwoCard)
        
        if (defaults.string(forKey: "Flop3") == "None")
        {
            flopThreeCard = SKSpriteNode(imageNamed: "Card Outline")
        }else{
            flopThreeCard = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop3")!)
        }
        flopThreeCard.setScale(CGFloat(0.165 * scaleModifier))
        flopThreeCard.position = CGPoint(x: 9 * self.size.width/16, y: 6.75 * self.size.height/10)
        flopThreeCard.zPosition = 1
        self.addChild(flopThreeCard)
        
        if (defaults.string(forKey: "Turn") == "None")
        {
            turnCard = SKSpriteNode(imageNamed: "Card Outline")
        }else{
            turnCard = SKSpriteNode(imageNamed: defaults.string(forKey: "Turn")!)
        }
        turnCard.setScale(CGFloat(0.165 * scaleModifier))
        turnCard.position = CGPoint(x: 10.5 * self.size.width/16, y: 6.75 * self.size.height/10)
        turnCard.zPosition = 1
        self.addChild(turnCard)
        //print(defaults.string(forKey: "Turn") == "None")
        
        
        
        if (defaults.string(forKey: "River") == "None")
        {
            riverCard = SKSpriteNode(imageNamed: "Card Outline")
        }else{
            riverCard = SKSpriteNode(imageNamed: defaults.string(forKey: "River")!)
        }
        riverCard.setScale(CGFloat(0.165 * scaleModifier))
        riverCard.position = CGPoint(x: 12 * self.size.width/16, y: 6.75 * self.size.height/10)
        riverCard.zPosition = 1
        self.addChild(riverCard)
        
        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") != "None")
        {
            flopDone = true
        }
        if defaults.string(forKey: "Turn") != "None"
        {
            turnDone = true
        }
        if defaults.string(forKey: "River") != "None"
        {
            riverDone = true
        }
        
        if flopDone == false
        {
            preFlopStatistics()
        }
        
        if flopDone == true && turnDone == false
        {
            flopStatistics()
        }
        
        if flopDone == true && turnDone == true && riverDone != true
        {
            riverStatistics()
        }
        
        if flopDone == true && turnDone == true && riverDone == true
        {
            //bestHand()
            exit = true
        }
        if(exit == true)
        {
            //Play Again
            ttpLabel.fontName = "Copperplate-Light"
            ttpLabel.text = "Tap to Start New Game"
            ttpLabel.fontSize = 38
            ttpLabel.fontColor = SKColor.white
            ttpLabel.position = CGPoint(x: self.size.width/2, y: 4.3 * self.size.height/10)
            ttpLabel.zPosition = 10
            
            let fadeInFadeOut = SKAction.sequence([SKAction.fadeIn(withDuration: 1.0),SKAction.fadeOut(withDuration: 0.5)])
            ttpLabel.run( SKAction.repeatForever(fadeInFadeOut))
            self.addChild(ttpLabel)
        }
    }
    
    //Origin is top left
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            let cardWidth = card1.size.width
            let cardHeight = card1.size.height
            
            //print(6 * self.size.width/16)
            //print(6.75 * self.size.height/10)
            
            if ((pointOfTouch.x > (6 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (6 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (3.25 * self.size.height/10 - cardHeight/2) && pointOfTouch.y < (3.25 * self.size.height/10 + cardHeight/2)))
            {
                let sceneToMoveTo = GameSceneFlop(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            if (flopDone == true) && (defaults.string(forKey: "Turn") == "None")
            {
                if ((pointOfTouch.x > (10.5 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (10.5 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (3.25 * self.size.height/10 - cardHeight/2) && pointOfTouch.y < (3.25 * self.size.height/10 + cardHeight/2)))
                {
                    let sceneToMoveTo = GameSceneTurn(size: self.size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    let myTransition = SKTransition.fade(withDuration:  1.0)
                    self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                }
            }
            
            if turnDone == true
            {
                if ((pointOfTouch.x > (12 * self.size.width/16 - cardWidth/2) && pointOfTouch.x < (12 * self.size.width/16 + cardWidth/2)) && (pointOfTouch.y > (3.25 * self.size.height/10 - cardHeight/2) && pointOfTouch.y < (3.25 * self.size.height/10 + cardHeight/2)))
                {
                    let sceneToMoveTo = GameSceneRiver(size: self.size)
                    sceneToMoveTo.scaleMode = self.scaleMode
                    let myTransition = SKTransition.fade(withDuration:  1.0)
                    self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                }
            }
            if exit == true
            {
                //Your Hand
                defaults.set("None", forKey: "Card1")
                defaults.set("None", forKey: "Card2")
                
                //Playing Cards
                defaults.set("None", forKey: "Flop1")
                defaults.set("None", forKey: "Flop2")
                defaults.set("None", forKey: "Flop3")
                defaults.set("None", forKey: "Turn")
                defaults.set("None", forKey: "River")
                
                defaults.set(false, forKey: "PickingCards")
                defaults.set(false, forKey: "flop1")
                defaults.set(false, forKey: "flop2")
                defaults.set(false, forKey: "flop3")
                defaults.set(false, forKey: "turn")
                defaults.set(false, forKey: "river")
                
                
                
                
                self.removeAllChildren()
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration:  1.0)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
        }
        
    }
    
    func preFlopStatistics()    //Clean Board -> Flop
    {
        print("Pre-Flop Statistics")
        let holeCard1 = defaults.string(forKey: "Card1")
        let holeCard2 = defaults.string(forKey: "Card2")
        
        let holeCard1Array = holeCard1!.components(separatedBy: " - ")
        let holeCard2Array = holeCard2!.components(separatedBy: " - ")
        
        let suitCard1 = holeCard1Array[0]
        let suitCard2 = holeCard2Array[0]
        
        let valCard1 = holeCard1Array[1]
        let valCard2 = holeCard2Array[1]
        
        //Suited
        if suitCard1 == suitCard2
        {
            //bestHand(number: 10)
            print("Flush on flop: \(FlopImproving.scFlush)%")
            print("Flush Draw (4/5): \(FlopImproving.scFlushDraw)%")
            print("Back door Flush Draw (3/5): \(FlopImproving.scBDFlushDraw)%")
        }
        
        //Pocket Pair
        if valCard1 == valCard2
        {
            //bestHand(number: 9)
            print("Three of a kind or better: \(FlopImproving.ppThreeKindBetter)%")
            print("Three of a kind: \(FlopImproving.ppThreeKind)%")
            print("Full House: \(FlopImproving.ppFullHouse)%")
            print("Four of a Kind: \(FlopImproving.ppFourKind)%")
        }
        
        if valCard1 != valCard2 && suitCard1 != suitCard2
        {
            //bestHand(number: 10)
            print("One pair on flop: \(FlopImproving.upOnePair)%")
            print("Two pairs on flop: \(FlopImproving.upTwoPair)%")
        }
        
        //Straight
        /*
         //Connecting cards
         let occOESD = 9.6           //need one on either side of 4 cards
         let occStraightOrFlush = 19.1
         let occStraight = 1.31
         */
    }

    func flopStatistics()       //Flop -> River & Flop -> Turn
    {
        print("Pre-Turn/Flop Statistics")
        let holeCard1 = defaults.string(forKey: "Card1")
        let holeCard2 = defaults.string(forKey: "Card2")
        let flopCard1 = defaults.string(forKey: "Flop1")
        let flopCard2 = defaults.string(forKey: "Flop2")
        let flopCard3 = defaults.string(forKey: "Flop3")
        
        let holeCard1Array = holeCard1!.components(separatedBy: " - ")
        let holeCard2Array = holeCard2!.components(separatedBy: " - ")
        let flopCard1Array = flopCard1!.components(separatedBy: " - ")
        let flopCard2Array = flopCard2!.components(separatedBy: " - ")
        let flopCard3Array = flopCard3!.components(separatedBy: " - ")

        
        let suitCard1 = holeCard1Array[0]
        let suitCard2 = holeCard2Array[0]
        let suitCard3 = flopCard1Array[0]
        let suitCard4 = flopCard2Array[0]
        let suitCard5 = flopCard3Array[0]
        
        let valCard1 = holeCard1Array[1]
        let valCard2 = holeCard2Array[1]
        let valCard3 = flopCard1Array[1]
        let valCard4 = flopCard2Array[1]
        let valCard5 = flopCard3Array[1]
        
        
        //Suits
        var suits = [String]()
        suits.append(suitCard1); suits.append(suitCard2); suits.append(suitCard3); suits.append(suitCard4); suits.append(suitCard5)
        
        var count = 0
        var suitPairs = 0
        for i in 0...4
        {
            for j in 0...4
            {
                if suits[i] == suits[j]
                {
                    count += 1
                }
            }
            
            if(count > suitPairs)
            {
                suitPairs = count
            }
            count = 0
        }
        //print(max)
        
        
        var value = [String]()
        value.append(valCard1); value.append(valCard2); value.append(valCard3); value.append(valCard4); value.append(valCard5)
        var twoPair = [String]()
        var count2 = 0
        var valuePairs = 0
        for i in 0...4
        {
            for j in 0...4
            {
                if value[i] == value[j]
                {
                    count2 += 1
                    twoPair.append(value[i])
                }
            }
            
            if(count2 > valuePairs)
            {
                valuePairs = count2
            }
            count2 = 0
        }
        //var bestHand = 10
        //var rank = 10
        //Full House
        twoPair.removeDuplicates()
       
        if (twoPair.count == 3)
        {
            print("Full House on Turn): \(TurnImproving.tpFullHouse)%")
        }
        if (valuePairs == 1)
        {
            //rank = 10
            //if rank < bestHand{bestHand = rank}
            print("Pair on the Turn: \(TurnImproving.upPair)%")
        }
        if(valuePairs == 2)
        {
            //bestHand = 9
            //if rank < bestHand{bestHand = rank}
            print("Three of a kind: \(TurnImproving.pThreeKind)%")
        }
        if(valuePairs == 3)
        {
            //bestHand = 7
            //if rank < bestHand{bestHand = rank}
            print("Four of a kind: \(TurnImproving.threeKindFourKind)%")
        }
        if(suitPairs == 3)
        {
            /*
            if valuePairs == 1
            {
                if rank < bestHand{bestHand = rank}
                bestHand = 10
            }
            if valuePairs == 2
            {
                if rank < bestHand{bestHand = rank}
                numbers = 9
            }
            if twoPair.count == 3
            {
                if rank < bestHand{bestHand = rank}
                numbers = 7
            }
 */
            print("Backdoor Flush Draw (3/5): \(TurnImproving.bdfdFlush)%")
        }
        if(suitPairs == 4)
        {
            print("Flush Draw (4/5): \(TurnImproving.fdFlush)%")
        }
        /*
        if(valuePairs == 2 && twoPair.count == 4)
        {
            print("Back Door Full House: \(TurnImproving.bdFullHouse)%")
        }
         */
        
        /*
        struct TurnImproving
        {
            let gsdStraight = 8.5       //Straight draw missing a card in the middle, the gut
            let oesdStraight = 17       //need one on either side of 4 cards
        }
         */
    }
    
    func riverStatistics()      //River -> Turn
    {
        print("Pre-River Statistics")
        let holeCard1 = defaults.string(forKey: "Card1")
        let holeCard2 = defaults.string(forKey: "Card2")
        let flopCard1 = defaults.string(forKey: "Flop1")
        let flopCard2 = defaults.string(forKey: "Flop2")
        let flopCard3 = defaults.string(forKey: "Flop3")
        let turnCard = defaults.string(forKey: "Turn")
        
        let holeCard1Array = holeCard1!.components(separatedBy: " - ")
        let holeCard2Array = holeCard2!.components(separatedBy: " - ")
        let flopCard1Array = flopCard1!.components(separatedBy: " - ")
        let flopCard2Array = flopCard2!.components(separatedBy: " - ")
        let flopCard3Array = flopCard3!.components(separatedBy: " - ")
        let turnCardArray = turnCard!.components(separatedBy: " - ")
        
        let suitCard1 = holeCard1Array[0]
        let suitCard2 = holeCard2Array[0]
        let suitCard3 = flopCard1Array[0]
        let suitCard4 = flopCard2Array[0]
        let suitCard5 = flopCard3Array[0]
        let suitCard6 = turnCardArray[0]
        
        let valCard1 = holeCard1Array[1]
        let valCard2 = holeCard2Array[1]
        let valCard3 = flopCard1Array[1]
        let valCard4 = flopCard2Array[1]
        let valCard5 = flopCard3Array[1]
        let valCard6 = turnCardArray[1]
        
        
        //Suits
        var suits = [String]()
        suits.append(suitCard1); suits.append(suitCard2); suits.append(suitCard3); suits.append(suitCard4); suits.append(suitCard5); suits.append(suitCard6)
        
        var count = 0
        var suitPairs = 0
        for i in 0...5
        {
            for j in 0...5
            {
                if suits[i] == suits[j]
                {
                    count += 1
                }
            }
            
            if(count > suitPairs)
            {
                suitPairs = count
            }
            count = 0
        }
        //print(max)
        
        
        var value = [String]()
        value.append(valCard1); value.append(valCard2); value.append(valCard3); value.append(valCard4); value.append(valCard5); value.append(valCard6)
        var twoPair = [String]()
        var count2 = 0
        var valuePairs = 0
        for i in 0...5
        {
            for j in 0...5
            {
                if value[i] == value[j]
                {
                    count2 += 1
                    twoPair.append(value[i])
                }
            }
            
            if(count2 > valuePairs)
            {
                valuePairs = count2
            }
            count2 = 0
        }
        
        twoPair.removeDuplicates()
        
        if (twoPair.count == 4)
        {
            print("Full House on River: \(RiverImproving.tpFullHouse)%")
        }
        if (valuePairs == 1)
        {
            print("Pair on the River: \(RiverImproving.upPair)%")
        }
        if(valuePairs == 2)
        {
            print("Three of a kind: \(RiverImproving.pThreeKind)%")
        }
        if(valuePairs == 3)
        {
            print("Four of a kind: \(RiverImproving.threekindFourKind)%")
        }
        if(suitPairs == 4)
        {
            print("Flush Draw (4/5): \(RiverImproving.fdFlush)%")
        }
        
        
        /*
        let oesdStraight = 17.4     //need one on either side of 4 cards
        let gsdStraight = 8.7
        */
    }
    
    
    /*
    func bestHand(number: Int)
    {
        print(number)
        if(number == 1)
        {
            //Royal Flush
        }
        if(number == 2)
        {
            //Straight flush
        }
        if(number == 3)
        {
            print("Best Hand: Four of a Kind")
        }
        if(number == 4)
        {
            print("Best Hand: Full House")
        }
        if(number == 5)
        {
            print("Best Hand: Flush")
        }
        if(number == 6)
        {
            print("Best Hand: Straight")
        }
        if(number == 7)
        {
            print("Best Hand: Three of a Kind")
        }
        if(number == 8)
        {
            print("Best Hand: Two Pair")
        }
        if(number == 9)
        {
            print("Best Hand: One Pair")
        }
        if(number == 10)
        {
            print("Best Hand: High Card")
        }
 
    }
 */
 
}





extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
