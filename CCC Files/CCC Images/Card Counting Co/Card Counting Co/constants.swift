//
//  constants.swift
//  Card Counting Co.
//
//  Created by ADAMLANE on 6/6/19.
//  Copyright © 2019 WackyClown. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

struct Cards
{
    //Hearts
    static let hAce = SKSpriteNode(imageNamed: "Heart - Ace")
    static let hTwo = SKSpriteNode(imageNamed: "Heart - Two")
    static let hThree = SKSpriteNode(imageNamed: "Heart - Three")
    static let hFour = SKSpriteNode(imageNamed: "Heart - Four")
    static let hFive = SKSpriteNode(imageNamed: "Heart - Five")
    static let hSix = SKSpriteNode(imageNamed: "Heart - Six")
    static let hSeven = SKSpriteNode(imageNamed: "Heart - Seven")
    static let hEight = SKSpriteNode(imageNamed: "Heart - Eight")
    static let hNine = SKSpriteNode(imageNamed: "Heart - Nine")
    static let hTen = SKSpriteNode(imageNamed: "Heart - Ten")
    static let hJack = SKSpriteNode(imageNamed: "Heart - Jack")
    static let hQueen = SKSpriteNode(imageNamed: "Heart - Queen")
    static let hKing = SKSpriteNode(imageNamed: "Heart - King")
    
    //Diamonds
    static let dAce = SKSpriteNode(imageNamed: "Diamond - Ace")
    static let dTwo = SKSpriteNode(imageNamed: "Diamond - Two")
    static let dThree = SKSpriteNode(imageNamed: "Diamond - Three")
    static let dFour = SKSpriteNode(imageNamed: "Diamond - Four")
    static let dFive = SKSpriteNode(imageNamed: "Diamond - Five")
    static let dSix = SKSpriteNode(imageNamed: "Diamond - Six")
    static let dSeven = SKSpriteNode(imageNamed: "Diamond - Seven")
    static let dEight = SKSpriteNode(imageNamed: "Diamond - Eight")
    static let dNine = SKSpriteNode(imageNamed: "Diamond - Nine")
    static let dTen = SKSpriteNode(imageNamed: "Diamond - Ten")
    static let dJack = SKSpriteNode(imageNamed: "Diamond - Jack")
    static let dQueen = SKSpriteNode(imageNamed: "Diamond - Queen")
    static let dKing = SKSpriteNode(imageNamed: "Diamond - King")
    
    
    
    //Clubs
    static let cAce = SKSpriteNode(imageNamed: "Clubs - Ace")
    static let cTwo = SKSpriteNode(imageNamed: "Clubs - Two")
    static let cThree = SKSpriteNode(imageNamed: "Clubs - Three")
    static let cFour = SKSpriteNode(imageNamed: "Clubs - Four")
    static let cFive = SKSpriteNode(imageNamed: "Clubs - Five")
    static let cSix = SKSpriteNode(imageNamed: "Clubs - Six")
    static let cSeven = SKSpriteNode(imageNamed: "Clubs - Seven")
    static let cEight = SKSpriteNode(imageNamed: "Clubs - Eight")
    static let cNine = SKSpriteNode(imageNamed: "Clubs - Nine")
    static let cTen = SKSpriteNode(imageNamed: "Clubs - Ten")
    static let cJack = SKSpriteNode(imageNamed: "Clubs - Jack")
    static let cQueen = SKSpriteNode(imageNamed: "Clubs - Queen")
    static let cKing = SKSpriteNode(imageNamed: "Clubs - King")
    
    //Spades
    static let sAce = SKSpriteNode(imageNamed: "Spades - Ace")
    static let sTwo = SKSpriteNode(imageNamed: "Spades - Two")
    static let sThree = SKSpriteNode(imageNamed: "Spades - Three")
    static let sFour = SKSpriteNode(imageNamed: "Spades - Four")
    static let sFive = SKSpriteNode(imageNamed: "Spades - Five")
    static let sSix = SKSpriteNode(imageNamed: "Spades - Six")
    static let sSeven = SKSpriteNode(imageNamed: "Spades - Seven")
    static let sEight = SKSpriteNode(imageNamed: "Spades - Eight")
    static let sNine = SKSpriteNode(imageNamed: "Spades - Nine")
    static let sTen = SKSpriteNode(imageNamed: "Spades - Ten")
    static let sJack = SKSpriteNode(imageNamed: "Spades - Jack")
    static let sQueen = SKSpriteNode(imageNamed: "Spades - Queen")
    static let sKing = SKSpriteNode(imageNamed: "Spades - King")
}

struct Statistics
{
    let RoyalFlush = 0.0032
    let StraightFlush = 0.0279
    let FourKind = 0.168
    let FullHouse = 2.6
    let Flush = 3.03
    let Straight = 4.62
    let ThreeKind = 4.83
    let TwoPair = 23.5
    let OnePair = 43.8
    let HighCard = 17.4 //No Pair
}

struct FlopImproving
{
    //Pocket Pairs
    static let ppThreeKindBetter = 12.7
    static let ppThreeKind = 11.8
    static let ppFullHouse = 0.73
    static let ppFourKind = 0.24
    
    //2 Unpaired
    static let upOnePair = 32.4
    static let upTwoPair = 2
    
    //Suited Cards
    static let scFlush = 0.842
    static let scFlushDraw = 10.9      //  4/5
    static let scBDFlushDraw = 41.6    //  3/5 - Need River and Turn for Flush
    
    //Connecting cards
    static let occOESD = 9.6           //need one on either side of 4 cards
    static let occStraightOrFlush = 19.1
    static let occStraight = 1.31
}

struct TurnImproving
{
    static let fdFlush = 19.1
    static let gsdStraight = 8.5       //Straight draw missing a card in the middle, the gut
    static let oesdStraight = 17       //need one on either side of 4 cards
    static let threeKindFourKind = 2.1
    static let tpFullHouse = 8.5
    static let pThreeKind = 4.3
    static let upPair = 12.8
    static let bdfdFlush = 4.2
    static let bdFullHouse = 2.5
}

struct RiverImproving
{
    static let fdFlush = 19.6
    static let oesdStraight = 17.4     //need one on either side of 4 cards
    static let gsdStraight = 8.7
    static let threekindFourKind = 2.2
    static let tpFullHouse = 8.7
    static let pThreeKind = 4.3
    static let upPair = 13
}

struct FlopToRiver
{
    static let fdFlush = 35
    static let bdfdFlush = 4.2         //  3/5 pre flop
    static let oesdStraight = 32       //need one on either side of 4 cards
    static let gsdStraight = 17
    static let threeKindFourKind = 4.3
    static let tpFullHouse = 17
    static let pFourKind = 0.09
    static let pThreeKind = 8.4
}

struct BoardFlop
{
    let threeKind = 0.24
    let pair = 16.9
    let threeSuited = 5.17
    let twoSuited = 55
    let rainbow = 39.8
    let threeSraightConnect = 3.45
    let twoStraightConnect = 40
    let noCards = 55.6
}
