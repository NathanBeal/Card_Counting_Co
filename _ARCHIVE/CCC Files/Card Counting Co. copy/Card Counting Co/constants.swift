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
    static let hAce = SKSpriteNode(imageNamed: "Heart - 14")
    static let hTwo = SKSpriteNode(imageNamed: "Heart - 2")
    static let hThree = SKSpriteNode(imageNamed: "Heart - 3")
    static let hFour = SKSpriteNode(imageNamed: "Heart - 4")
    static let hFive = SKSpriteNode(imageNamed: "Heart - 5")
    static let hSix = SKSpriteNode(imageNamed: "Heart - 6")
    static let hSeven = SKSpriteNode(imageNamed: "Heart - 7")
    static let hEight = SKSpriteNode(imageNamed: "Heart - 8")
    static let hNine = SKSpriteNode(imageNamed: "Heart - 9")
    static let hTen = SKSpriteNode(imageNamed: "Heart - 10")
    static let hJack = SKSpriteNode(imageNamed: "Heart - 11")
    static let hQueen = SKSpriteNode(imageNamed: "Heart - 12")
    static let hKing = SKSpriteNode(imageNamed: "Heart - 13")
    
    //Diamonds
    static let dAce = SKSpriteNode(imageNamed: "Diamond - 14")
    static let dTwo = SKSpriteNode(imageNamed: "Diamond - 2")
    static let dThree = SKSpriteNode(imageNamed: "Diamond - 3")
    static let dFour = SKSpriteNode(imageNamed: "Diamond - 4")
    static let dFive = SKSpriteNode(imageNamed: "Diamond - 5")
    static let dSix = SKSpriteNode(imageNamed: "Diamond - 6")
    static let dSeven = SKSpriteNode(imageNamed: "Diamond - 7")
    static let dEight = SKSpriteNode(imageNamed: "Diamond - 8")
    static let dNine = SKSpriteNode(imageNamed: "Diamond - 9")
    static let dTen = SKSpriteNode(imageNamed: "Diamond - 10")
    static let dJack = SKSpriteNode(imageNamed: "Diamond - 11")
    static let dQueen = SKSpriteNode(imageNamed: "Diamond - 12")
    static let dKing = SKSpriteNode(imageNamed: "Diamond - 13")
    
    
    
    //Clubs
    static let cAce = SKSpriteNode(imageNamed: "Clubs - 14")
    static let cTwo = SKSpriteNode(imageNamed: "Clubs - 2")
    static let cThree = SKSpriteNode(imageNamed: "Clubs - 3")
    static let cFour = SKSpriteNode(imageNamed: "Clubs - 4")
    static let cFive = SKSpriteNode(imageNamed: "Clubs - 5")
    static let cSix = SKSpriteNode(imageNamed: "Clubs - 6")
    static let cSeven = SKSpriteNode(imageNamed: "Clubs - 7")
    static let cEight = SKSpriteNode(imageNamed: "Clubs - 8")
    static let cNine = SKSpriteNode(imageNamed: "Clubs - 9")
    static let cTen = SKSpriteNode(imageNamed: "Clubs - 10")
    static let cJack = SKSpriteNode(imageNamed: "Clubs - 11")
    static let cQueen = SKSpriteNode(imageNamed: "Clubs - 12")
    static let cKing = SKSpriteNode(imageNamed: "Clubs - 13")
    
    //Spades
    static let sAce = SKSpriteNode(imageNamed: "Spades - 14")
    static let sTwo = SKSpriteNode(imageNamed: "Spades - 2")
    static let sThree = SKSpriteNode(imageNamed: "Spades - 3")
    static let sFour = SKSpriteNode(imageNamed: "Spades - 4")
    static let sFive = SKSpriteNode(imageNamed: "Spades - 5")
    static let sSix = SKSpriteNode(imageNamed: "Spades - 6")
    static let sSeven = SKSpriteNode(imageNamed: "Spades - 7")
    static let sEight = SKSpriteNode(imageNamed: "Spades - 8")
    static let sNine = SKSpriteNode(imageNamed: "Spades - 9")
    static let sTen = SKSpriteNode(imageNamed: "Spades - 10")
    static let sJack = SKSpriteNode(imageNamed: "Spades - 11")
    static let sQueen = SKSpriteNode(imageNamed: "Spades - 12")
    static let sKing = SKSpriteNode(imageNamed: "Spades - 13")
    
    
    //static let spadeAce = Card();
    //spadeAce.suit = "Spades";
    //spadeAce.value = 14;
    
    
    //All Cards by string
    
    static let adjCardW = SKSpriteNode(imageNamed: "Spades - 14")
    
}

struct Statistics
{
    let RoyalFlush = 0.0032
    let StraightFlush = 0.028
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



//Cummulative Probability Better Hand
struct betterHandOnePlayer
{
    static let royalFlush = 0.0032
    static let straightFlush = 0.031
    static let fourKind = 0.20
    static let fullHouse = 2.80
    static let flush = 5.82
    static let straight = 10.44
    static let threeKind = 15.27
    static let twoPair = 38.77
    static let pair = 82.59
    static let highCard = 100
}
struct betterHandTwoPlayers
{
    static let royalFlush = 0.0063
    static let straightFlush = 0.06
    static let fourKind = 0.37
    static let fullHouse = 5.08
    static let flush = 10.32
    static let straight = 18.34
    static let threeKind = 25.53
    static let twoPair = 56.95
    static let pair = 94.07
    static let highCard = 100
    
}
struct betterHandThreePlayers
{
    static let royalFlush = 0.0094
    static let straightFlush = 0.09
    static let fourKind = 0.55
    static let fullHouse = 7.08
    static let flush = 14.12
    static let straight = 24.91
    static let threeKind = 34.16
    static let twoPair = 68.07
    static let pair = 98.04
    static let highCard = 100
}
struct betterHandFourPlayers
{
    static let royalFlush = 0.013
    static let straightFlush = 0.12
    static let fourKind = 0.72
    static let fullHouse = 8.88
    static let flush = 17.38
    static let straight = 30.47
    static let threeKind = 41.50
    static let twoPair = 75.27
    static let pair = 99.38
    static let highCard = 100
}
struct betterHandFivePlayers
{
    static let royalFlush = 0.0155
    static let straightFlush = 0.147
    static let fourKind = 0.89
    static let fullHouse = 10.50
    static let flush = 20.25
    static let straight = 35.24
    static let threeKind = 47.83
    static let twoPair = 80.22
    static let pair = 99.81
    static let highCard = 100
}
struct betterHandSixPlayers
{
    static let royalFlush = 0.0186
    static let straightFlush = 0.175
    static let fourKind = 1.06
    static let fullHouse = 11.99
    static let flush = 22.82
    static let straight = 39.41
    static let threeKind = 53.32
    static let twoPair = 83.83
    static let pair = 99.95
    static let highCard = 100
}

