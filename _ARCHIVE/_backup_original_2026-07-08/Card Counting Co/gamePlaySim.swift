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
//let scaleModifier = defaults.double(forKey: "FrameWidth")/896
//var bestHandValue = SKLabelNode()
class gamePlaySim: SKScene
{
    let gameArea: CGRect
    var sceneToMoveTo = SKScene()
    
    var statsLabel5 = SKLabelNode()
    
    let background = SKSpriteNode(imageNamed: "background")
    let card1 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card1")!)
    let card2 = SKSpriteNode(imageNamed: defaults.string(forKey: "Card2")!)
    
    let gameOver = SKSpriteNode(imageNamed: "grayBackground")
    let gameOverLayer2 = SKSpriteNode(imageNamed: "grayBackground")

    
    let stack = SKSpriteNode(imageNamed: "stack")
    
    let cardPile = SKSpriteNode(imageNamed: "Back Of Card")
    let burnPile = SKSpriteNode(imageNamed: "Card Outline")
    
    //Guides
    let flopGuide = SKSpriteNode(imageNamed: "flopGuide")
    let turnGuide = SKSpriteNode(imageNamed: "trGuide")
    let riverGuide = SKSpriteNode(imageNamed: "trGuide")
    
    //Burn Cards
    let burnCard1 = SKSpriteNode(imageNamed: "Back Of Card")
    let burnCard2 = SKSpriteNode(imageNamed: "Back Of Card")
    let burnCard3 = SKSpriteNode(imageNamed: "Back Of Card")
    
    //let bestHandBackdrop = SKSpriteNode(imageNamed: "grayBackground")
    //let statisticsBackdrop = SKSpriteNode(imageNamed: "grayBackground")
    let bestHandBackdrop = SKSpriteNode(imageNamed: "whiteBackground")
    let statisticsBackdrop = SKSpriteNode(imageNamed: "statsBackdrop")
    
    let statsLabel = SKLabelNode()
    
    var bestHandValue = SKLabelNode()
    var betterHandStat = SKLabelNode()
    
    //Pull Down Screen
    let pulldownButton = SKSpriteNode(imageNamed: "button")
    let pulldownScreen = SKSpriteNode(imageNamed: "dropdownMenu")
    
    let Settings = SKSpriteNode(imageNamed: "Settings Icon")
    
    var rf = false
    var settingsTapped = 0
    
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
    
    var flopLock = false; var turnLock = false;
    
    var Scaler = CGFloat()
    
    //For statistics
    var statDisplay = 1
    var maxCycle = 0
    let besthandLabel = SKLabelNode()
    let betterHandLabel = SKLabelNode()
    let betterHandLabel2 = SKLabelNode()
    let sLabel = SKLabelNode()
    
    //For statistics
    var statisticsLabel1 = SKLabelNode(); var statisticsLabel2 = SKLabelNode(); var statisticsLabel3 = SKLabelNode(); var statisticsLabel4 = SKLabelNode(); var statisticsLabel5 = SKLabelNode()
    
    var statsLabel1 = SKLabelNode(); var statsLabel2 = SKLabelNode(); var statsLabel3 = SKLabelNode(); var statsLabel4 = SKLabelNode()
    
    //Extra Players
    let extraCard1 = SKSpriteNode(imageNamed: "Back Of Card")
    let extraCard2 = SKSpriteNode(imageNamed: "Back Of Card")
    let extraCard3 = SKSpriteNode(imageNamed: "Back Of Card")
    let extraCard4 = SKSpriteNode(imageNamed: "Back Of Card")
    let extraCard5 = SKSpriteNode(imageNamed: "Back Of Card")
    let extraCard6 = SKSpriteNode(imageNamed: "Back Of Card")
    let extraCard7 = SKSpriteNode(imageNamed: "Back Of Card")
    let extraCard8 = SKSpriteNode(imageNamed: "Back Of Card")
    let extraCard9 = SKSpriteNode(imageNamed: "Back Of Card")
    let extraCard10 = SKSpriteNode(imageNamed: "Back Of Card")
    
    //ScreenDown
    let handRanks = SKLabelNode(); let royalFlush = SKLabelNode(); let royalFlushExp = SKLabelNode(); let straightFlush = SKLabelNode(); let straightFlushExp = SKLabelNode(); let fourKind = SKLabelNode(); let fourKindExp = SKLabelNode(); let fullHouse = SKLabelNode(); let fullHouseExp = SKLabelNode(); let flush = SKLabelNode(); let flushExp = SKLabelNode(); let straight = SKLabelNode(); let straightExp = SKLabelNode(); let threeKind = SKLabelNode(); let threeKindExp = SKLabelNode(); let twoPair = SKLabelNode(); let twoPairExp = SKLabelNode(); let aPair = SKLabelNode(); let aPairExp = SKLabelNode(); let highCard = SKLabelNode(); let highCardExp = SKLabelNode()
    
    let rfPNG = SKSpriteNode(imageNamed: "rf")
    let sfPNG = SKSpriteNode(imageNamed: "sf")
    let fourKindPNG = SKSpriteNode(imageNamed: "fourKind")
    let fullHousePNG = SKSpriteNode(imageNamed: "fullHouse")
    let flushPNG = SKSpriteNode(imageNamed: "flush")
    let straightPNG = SKSpriteNode(imageNamed: "straight")
    let threeKindPNG = SKSpriteNode(imageNamed: "threeKind")
    let twoPairPNG = SKSpriteNode(imageNamed: "twoPair")
    let aPairPNG = SKSpriteNode(imageNamed: "aPair")
    let highcardPNG = SKSpriteNode(imageNamed: "highcard")
    
    var screenDown = false
    var Directions = SKLabelNode()
    
    //Cards
    var handCard1 = ""; var handCard2 = ""; var FLOPCARD1 = ""; var FLOPCARD2 = ""; var FLOPCARD3 = ""; var TURNCARD = ""; var RIVERCARD = ""
    var cardSuit1 = ""; var cardSuit2 = ""; var cardSuit3 = ""; var cardSuit4 = ""; var cardSuit5 = ""; var cardSuit6 = ""; var cardSuit7 = ""
    var cardVal1 = ""; var cardVal2 = ""; var cardVal3 = ""; var cardVal4 = ""; var cardVal5 = ""; var cardVal6 = ""; var cardVal7 = ""
    var handCard1Arr = [String](); var handCard2Arr = [String](); var flopCard1Arr = [String](); var flopCard2Arr = [String](); var flopCard3Arr = [String](); var turnCardArr = [String](); var riverCardArr = [String]()
    var allValues = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    var suitsOrdered = ["","","","","","","","","","","","","",""]
    var allSuits = [0,0,0,0]
    var maxSuitInHand = ""
    
    //Settings
    var SettingsXCoord = CGFloat()
    var SettingsYCoord = CGFloat()
    var settingsMenuRect = CGRect()
    let settingsMenu = SKSpriteNode(imageNamed: "SettingsMenu")
    let settingsLabel = SKLabelNode()
    let settingsNumPlayers = SKLabelNode()
    let settingGameMode = SKLabelNode()
    let onePlayer = SKSpriteNode(imageNamed: "onePlayer")
    let twoPlayers = SKSpriteNode(imageNamed: "twoPlayers")
    let threePlayers = SKSpriteNode(imageNamed: "threePlayers")
    let fourPlayers = SKSpriteNode(imageNamed: "fourPlayers")
    let fivePlayers = SKSpriteNode(imageNamed: "fivePlayers")
    let sixPlayers = SKSpriteNode(imageNamed: "sixPlayers")
    let overlay = SKSpriteNode(imageNamed: "PlayNumOverlay"); let gameModeOverlay = SKSpriteNode(imageNamed: "grayBackground")
    var gManual = SKShapeNode()
    var gSimulated = SKShapeNode()
    var settingDisplay = false
    var gameManual = CGRect(); var gameSimulated = CGRect()
    var manualPlay = SKLabelNode(); var simulatedPlay = SKLabelNode()
    var settingsUpdate = SKLabelNode()
    let settingsLeaveGame = SKLabelNode()
    var exitGameRect = CGRect()
    var exitGame = SKShapeNode()
    
    var initialPlayers = Double()
    var initialGameMode = Double()
    
    var currentCards: [String] = []
    
    
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
        //Scalers
        if (defaults.double(forKey: "FrameWidth") == 896 && defaults.double(forKey: "FrameHeight") == 414) || (defaults.double(forKey: "FrameWidth") == 375 && defaults.double(forKey: "FrameHeight") == 812)
        {
            Scaler = 1
        }else{
            if (defaults.double(forKey: "FrameWidth") == 736 && defaults.double(forKey: "FrameHeight") == 414)
            {
                Scaler = CGFloat(0.86)
            }else{
                Scaler = CGFloat(scaleModifier)
            }
        }
        
        //Backgrounds
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        gameOver.size = self.size
        gameOver.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        gameOver.zPosition = 15
        gameOver.alpha = 0
        
        gameOverLayer2.size = self.size
        gameOverLayer2.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        gameOverLayer2.zPosition = 18
        gameOverLayer2.alpha = 0
        
        Directions.fontName = "Copperplate-Light"
        Directions.text = "tap on overlay to generate flop"
        Directions.fontSize = CGFloat(38 * Scaler)
        Directions.fontColor = SKColor.white
        Directions.position = CGPoint(x: self.size.width/2, y: 8.12 * self.size.height/10)
        Directions.zPosition = 10
        Directions.alpha = 0
        self.addChild(Directions)
        let fadeInFadeOut = SKAction.sequence([SKAction.fadeIn(withDuration: 1),SKAction.wait(forDuration: 1),SKAction.fadeOut(withDuration: 1)])
        Directions.run(SKAction.repeatForever(fadeInFadeOut))
        
        
        //Settings
        Settings.setScale(CGFloat(0.65 * Scaler))
        let Offset = self.size.height - Settings.size.height/2 - 9 * self.size.height/10
        SettingsXCoord = self.size.width - Offset - Settings.size.height/2
        SettingsYCoord = 9 * self.size.height/10
        Settings.position = CGPoint(x: SettingsXCoord, y: SettingsYCoord)
        Settings.zPosition = 1
        Settings.alpha = 0
        self.addChild(Settings)
        
        settingsMenuRect = CGRect(x: 1 * self.size.width/10, y: 1 * self.size.height/10, width: 8 * self.size.width/10, height: 8 * self.size.height/10)
        settingsMenu.size = settingsMenuRect.size
        settingsMenu.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        settingsMenu.zPosition = 100
        settingsMenu.alpha = 0
        self.addChild(settingsMenu)
        
        settingsLabel.position = CGPoint(x: self.size.width/2, y: settingsMenuRect.maxY - settingsMenuRect.maxX/15)
        settingsLabel.fontName = "Copperplate-Light"
        settingsLabel.text = "settings"
        settingsLabel.fontSize = CGFloat(50 * Scaler)
        settingsLabel.fontColor = SKColor.white
        settingsLabel.zPosition = 101
        settingsLabel.alpha = 0
        self.addChild(settingsLabel)
        
        settingsUpdate.position = CGPoint(x: self.size.width/2, y: settingsMenuRect.maxY - settingsMenuRect.maxX/11)
        settingsUpdate.fontName = "Copperplate-Light"
        settingsUpdate.text = "(settings are updated at the end of each hand)"
        settingsUpdate.fontSize = CGFloat(17 * Scaler)
        settingsUpdate.fontColor = SKColor.white
        settingsUpdate.zPosition = 101
        settingsUpdate.alpha = 0
        self.addChild(settingsUpdate)
        
        exitGameRect = CGRect(x: 4 * self.size.width/10, y: 0.60 * self.size.height, width: 2 * self.size.width/10, height: 0.8 * self.size.height/10)
        exitGame = SKShapeNode.init(rect: exitGameRect)
        exitGame.fillColor = SKColor.white
        exitGame.zPosition = 101
        exitGame.strokeColor = SKColor.black
        exitGame.lineWidth = 1
        exitGame.alpha = 0
        self.addChild(exitGame)
        
        settingsLeaveGame.position = CGPoint(x: self.size.width/2, y: 0.64 * self.size.height)
        settingsLeaveGame.fontName = "Copperplate-Light"
        settingsLeaveGame.text = "exit game"
        settingsLeaveGame.fontSize = CGFloat(20 * Scaler)
        settingsLeaveGame.fontColor = SKColor.black
        settingsLeaveGame.zPosition = 102
        settingsLeaveGame.alpha = 0
        settingsLeaveGame.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        settingsLeaveGame.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        self.addChild(settingsLeaveGame)
        
        settingGameMode.position = CGPoint(x: self.size.width/2, y: 0.525 * self.size.height)
        settingGameMode.fontName = "Copperplate-Light"
        settingGameMode.text = "game mode"
        settingGameMode.fontSize = CGFloat(30 * Scaler)
        settingGameMode.fontColor = SKColor.white
        settingGameMode.zPosition = 101
        settingGameMode.alpha = 0
        self.addChild(settingGameMode)
        
        settingsNumPlayers.position = CGPoint(x: self.size.width/2, y: 0.34 * self.size.height)
        settingsNumPlayers.fontName = "Copperplate-Light"
        settingsNumPlayers.text = "number of players"
        settingsNumPlayers.fontSize = CGFloat(30 * Scaler)
        settingsNumPlayers.fontColor = SKColor.white
        settingsNumPlayers.zPosition = 101
        settingsNumPlayers.alpha = 0
        self.addChild(settingsNumPlayers)
        
        overlay.setScale(CGFloat(0.75 * Scaler))
        overlay.zPosition = 102
        overlay.alpha = 0
        
        onePlayer.setScale(CGFloat(0.75 * Scaler))
        onePlayer.position = CGPoint(x: 2.14 * self.size.width/10, y: 0.23 * self.size.height)
        onePlayer.zPosition = 101
        onePlayer.alpha = 0
        self.addChild(onePlayer)
        
        twoPlayers.setScale(CGFloat(0.75 * Scaler))
        twoPlayers.position = CGPoint(x: 3.28 * self.size.width/10, y: 0.23 * self.size.height)
        twoPlayers.zPosition = 101
        twoPlayers.alpha = 0
        self.addChild(twoPlayers)
        
        threePlayers.setScale(CGFloat(0.75 * Scaler))
        threePlayers.position = CGPoint(x: 4.42 * self.size.width/10, y: 0.23 * self.size.height)
        threePlayers.zPosition = 101
        threePlayers.alpha = 0
        self.addChild(threePlayers)
        
        fourPlayers.setScale(CGFloat(0.75 * Scaler))
        fourPlayers.position = CGPoint(x: 5.56 * self.size.width/10, y: 0.23 * self.size.height)
        fourPlayers.zPosition = 101
        fourPlayers.alpha = 0
        self.addChild(fourPlayers)
        
        fivePlayers.setScale(CGFloat(0.75 * Scaler))
        fivePlayers.position = CGPoint(x: 6.75 * self.size.width/10, y: 0.23 * self.size.height)
        fivePlayers.zPosition = 101
        fivePlayers.alpha = 0
        self.addChild(fivePlayers)
        
        sixPlayers.setScale(CGFloat(0.75 * Scaler))
        sixPlayers.position = CGPoint(x: 7.86 * self.size.width/10, y: 0.23 * self.size.height)
        sixPlayers.zPosition = 101
        sixPlayers.alpha = 0
        self.addChild(sixPlayers)
        
        
        if (defaults.double(forKey: "tempNumberOfPlayers") == 1.0)
        {
            overlay.position = CGPoint(x: 2.14 * self.size.width/10, y: 0.23 * self.size.height)
        }
        if (defaults.double(forKey: "tempNumberOfPlayers") == 2.0)
        {
            overlay.position = CGPoint(x: 3.28 * self.size.width/10, y: 0.23 * self.size.height)
        }
        if (defaults.double(forKey: "tempNumberOfPlayers") == 3.0)
        {
            overlay.position = CGPoint(x: 4.42 * self.size.width/10, y: 0.23 * self.size.height)
        }
        if (defaults.double(forKey: "tempNumberOfPlayers") == 4.0)
        {
            overlay.position = CGPoint(x: 5.56 * self.size.width/10, y: 0.23 * self.size.height)
        }
        if (defaults.double(forKey: "tempNumberOfPlayers") == 5.0)
        {
            overlay.position = CGPoint(x: 6.75 * self.size.width/10, y: 0.23 * self.size.height)
        }
        if (defaults.double(forKey: "tempNumberOfPlayers") == 6.0)
        {
            overlay.position = CGPoint(x: 7.86 * self.size.width/10, y: 0.23 * self.size.height)
        }
        self.addChild(overlay)
        
        
        gameManual = CGRect(x: 2.666 * self.size.width/10, y: 0.42 * self.size.height, width: 2 * self.size.width/10, height: 0.8 * self.size.height/10)
        gameSimulated = CGRect(x: 5.333 * self.size.width/10, y: 0.42 * self.size.height, width: 2 * self.size.width/10, height: 0.8 * self.size.height/10)
        
        gManual = SKShapeNode.init(rect: gameManual)
        gManual.fillColor = SKColor.white
        gManual.zPosition = 101
        gManual.strokeColor = SKColor.black
        gManual.lineWidth = 1
        gManual.alpha = 0
        self.addChild(gManual)
        
        gSimulated = SKShapeNode.init(rect: gameSimulated)
        gSimulated.fillColor = SKColor.white
        gSimulated.zPosition = 101
        gSimulated.strokeColor = SKColor.black
        gSimulated.lineWidth = 1
        gSimulated.alpha = 0
        self.addChild(gSimulated)
        
        manualPlay.fontName = "Copperplate-Light"
        manualPlay.fontColor = SKColor.black
        manualPlay.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        manualPlay.text = "manual game"
        manualPlay.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        manualPlay.fontSize = CGFloat(20 * Scaler)
        manualPlay.position = CGPoint(x: 3.666 * self.size.width/10, y: gameManual.midY)
        manualPlay.zPosition = 102
        manualPlay.alpha = 0
        
        simulatedPlay.fontName = "Copperplate-Light"
        simulatedPlay.fontColor = SKColor.black
        simulatedPlay.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        simulatedPlay.text = "simulated game"
        simulatedPlay.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        simulatedPlay.fontSize = CGFloat(20 * Scaler)
        simulatedPlay.position = CGPoint(x: 6.333 * self.size.width/10, y: gameSimulated.midY)
        simulatedPlay.zPosition = 102
        simulatedPlay.alpha = 0
        
        self.addChild(manualPlay)
        self.addChild(simulatedPlay)
        
        gameModeOverlay.size = gameManual.size
        gameModeOverlay.zPosition = 103
        gameModeOverlay.alpha = 0
        //defaults.set(0, forKey: "gameMode")
        if (defaults.double(forKey: "gameMode") == 0.0)
        {
            gameModeOverlay.position = CGPoint(x: 3.666 * self.size.width/10, y: gameManual.midY)
            //manualPlay.fontColor = SKColor.white
            //simulatedPlay.fontColor = SKColor.black
            
        }
        if (defaults.double(forKey: "gameMode") == 1.0)
        {
            gameModeOverlay.position = CGPoint(x: 6.333 * self.size.width/10, y: gameManual.midY)
            //manualPlay.fontColor = SKColor.black
            //simulatedPlay.fontColor = SKColor.white
        }
        self.addChild(gameModeOverlay)
        
        //Left Side
        bestHandBackdrop.setScale(CGFloat(0.2 * Scaler))
        bestHandBackdrop.position = CGPoint(x: 2 * self.size.width/10, y: 1.8 * self.size.height/10)
        bestHandBackdrop.zPosition = 2
        bestHandBackdrop.alpha = 0
        self.addChild(bestHandBackdrop)
        
        //BestHandLabels
        besthandLabel.position = CGPoint(x: 2 * self.size.width/10, y: 1.96 * self.size.height/10)
        besthandLabel.fontName = "Copperplate-Light"
        besthandLabel.text = "your best hand:"
        besthandLabel.fontSize = CGFloat(20 * Scaler)
        besthandLabel.fontColor = SKColor.black
        besthandLabel.zPosition = 10
        besthandLabel.alpha = 0
        self.addChild(besthandLabel)
        //Current Best hand
        bestHandValue.position = CGPoint(x: 2 * self.size.width/10, y: 1.4 * self.size.height/10)
        bestHandValue.fontName = "Copperplate-Light"
        bestHandValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        bestHandValue.fontSize = CGFloat(20 * Scaler)
        bestHandValue.fontColor = SKColor.black
        bestHandValue.zPosition = 11
        bestHandValue.alpha = 0
        
        //Statistics - Better Hand
        betterHandLabel.position = CGPoint(x: 8 * self.size.width/10, y: 2.15 * self.size.height/10)
        betterHandLabel.fontName = "Copperplate-Light"
        betterHandLabel.text = "chance another player draws a"
        betterHandLabel.fontSize = CGFloat(16 * Scaler)
        betterHandLabel.fontColor = SKColor.black
        betterHandLabel.zPosition = 10
        betterHandLabel.alpha = 0
        self.addChild(betterHandLabel)
        
        betterHandLabel2.position = CGPoint(x: 8 * self.size.width/10, y: 1.77 * self.size.height/10)
        betterHandLabel2.fontName = "Copperplate-Light"
        betterHandLabel2.text = "hand as good or better"
        betterHandLabel2.fontSize = CGFloat(16 * Scaler)
        betterHandLabel2.fontColor = SKColor.black
        betterHandLabel2.zPosition = 10
        betterHandLabel2.alpha = 0
        self.addChild(betterHandLabel2)
        
        //Tie or better hand than current
        betterHandStat.position = CGPoint(x: 8 * self.size.width/10, y: 1.25 * self.size.height/10)
        betterHandStat.fontName = "Copperplate-Light"
        betterHandStat.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        betterHandStat.fontSize = CGFloat(16 * Scaler)
        betterHandStat.fontColor = SKColor.black
        betterHandStat.zPosition = 11
        betterHandStat.alpha = 0
        //self.addChild(betterHandStat)
        self.addChild(betterHandStat)
        
        //Statistics
        //Right Side
        statisticsBackdrop.setScale(CGFloat(0.2 * Scaler))
        statisticsBackdrop.position = CGPoint(x: 8 * self.size.width/10, y: 1.8 * self.size.height/10)
        statisticsBackdrop.zPosition = 2
        statisticsBackdrop.zRotation = CGFloat(Double.pi)
        statisticsBackdrop.alpha = 0
        self.addChild(statisticsBackdrop)
        //Label
        statsLabel.position = CGPoint(x: 8.5 * self.size.width/10, y: 2.37 * self.size.height/10)
        statsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        statsLabel.fontName = "Copperplate-Light"
        statsLabel.text = "statistics:"
        statsLabel.fontSize = CGFloat(18 * Scaler)
        statsLabel.fontColor = SKColor.black
        statsLabel.zPosition = 10
        statsLabel.alpha = 0
        //self.addChild(statsLabel)
        
        //Statistics
        sLabel.fontName = "Copperplate-Light"
        sLabel.fontColor = SKColor.black
        sLabel.zPosition = 20
        sLabel.position = CGPoint(x: 8 * self.size.width/10, y: 2.15 * self.size.height/10)
        sLabel.fontSize = CGFloat(16 * Scaler)
        sLabel.zPosition = 100
        sLabel.text = "chance your hand improves to a"
        sLabel.alpha = 0
        
        statisticsLabel1.fontName = "Copperplate-Light"
        statisticsLabel1.fontColor = SKColor.black
        statisticsLabel1.zPosition = 20
        statisticsLabel1.position = CGPoint(x: 8 * self.size.width/10, y: 1.77 * self.size.height/10)
        statisticsLabel1.fontSize = CGFloat(16 * Scaler)
        
        statisticsLabel2.fontName = "Copperplate-Light"
        statisticsLabel2.fontColor = SKColor.black
        statisticsLabel2.zPosition = 20
        statisticsLabel2.position = CGPoint(x: 8 * self.size.width/10, y: 1.77 * self.size.height/10)
        statisticsLabel2.fontSize = CGFloat(16 * Scaler)
        //statisticsLabel2.alpha = 0
        
        statisticsLabel3.fontName = "Copperplate-Light"
        statisticsLabel3.fontColor = SKColor.black
        statisticsLabel3.zPosition = 20
        statisticsLabel3.position = CGPoint(x: 8 * self.size.width/10, y: 1.77 * self.size.height/10)
        statisticsLabel3.fontSize = CGFloat(16 * Scaler)
        //statisticsLabel3.alpha = 0
        
        statisticsLabel4.fontName = "Copperplate-Light"
        statisticsLabel4.fontColor = SKColor.black
        statisticsLabel4.zPosition = 20
        statisticsLabel4.position = CGPoint(x: 8 * self.size.width/10, y: 1.77 * self.size.height/10)
        statisticsLabel4.fontSize = CGFloat(16 * Scaler)
        //statisticsLabel4.alpha = 0
        
        statisticsLabel5.fontName = "Copperplate-Light"
        statisticsLabel5.fontColor = SKColor.black
        statisticsLabel5.zPosition = 20
        statisticsLabel5.position = CGPoint(x: 8 * self.size.width/10, y: 1.77 * self.size.height/10)
        statisticsLabel5.fontSize = CGFloat(16 * Scaler)
        //statisticsLabel5.alpha = 0
        
        statsLabel1.fontName = "Copperplate-Light"
        statsLabel1.fontColor = SKColor.black
        statsLabel1.zPosition = 20
        statsLabel1.position = CGPoint(x: 8 * self.size.width/10, y: 1.25 * self.size.height/10)
        statsLabel1.fontSize = CGFloat(16 * Scaler)
        //statsLabel1.alpha = 0
        
        statsLabel2.fontName = "Copperplate-Light"
        statsLabel2.fontColor = SKColor.black
        statsLabel2.zPosition = 20
        statsLabel2.position = CGPoint(x: 8 * self.size.width/10, y: 1.25 * self.size.height/10)
        statsLabel2.fontSize = CGFloat(16 * Scaler)
        //statsLabel2.alpha = 0
        
        statsLabel3.fontName = "Copperplate-Light"
        statsLabel3.fontColor = SKColor.black
        statsLabel3.zPosition = 20
        statsLabel3.position = CGPoint(x: 8 * self.size.width/10, y: 1.25 * self.size.height/10)
        statsLabel3.fontSize = CGFloat(16 * Scaler)
        //statsLabel3.alpha = 0
        
        statsLabel4.fontName = "Copperplate-Light"
        statsLabel4.fontColor = SKColor.black
        statsLabel4.zPosition = 20
        statsLabel4.position = CGPoint(x: 8 * self.size.width/10, y: 1.25 * self.size.height/10)
        statsLabel4.fontSize = CGFloat(16 * Scaler)
        //statsLabel4.alpha = 0
        
        statsLabel5.fontName = "Copperplate-Light"
        statsLabel5.fontColor = SKColor.black
        statsLabel5.zPosition = 20
        statsLabel5.position = CGPoint(x: 8 * self.size.width/10, y: 1.25 * self.size.height/10)
        statsLabel5.fontSize = CGFloat(16 * Scaler)
        //statsLabel5.alpha = 0
        
        //Cards
        card1.setScale(CGFloat(0.165 * Scaler))
        card1.position = CGPoint(x: self.size.width/2 - self.size.width/22, y: 2 * self.size.height/10)
        card1.zPosition = 1
        card1.alpha = 0
        self.addChild(card1)
        
        card2.setScale(CGFloat(0.165 * Scaler))
        card2.position = CGPoint(x: self.size.width/2 + self.size.width/22, y: 2 * self.size.height/10)
        card2.zPosition = 1
        card2.alpha = 0
        self.addChild(card2)
        
        burnPile.setScale(CGFloat(0.165 * Scaler))
        burnPile.position = CGPoint(x: 3.5 * self.size.width/16, y: 6.15 * self.size.height/10)
        burnPile.zPosition = 1
        burnPile.alpha = 0
        self.addChild(burnPile)
        
        stack.setScale(CGFloat(0.165 * Scaler))
        stack.position = CGPoint(x: 5 * self.size.width/16, y: 6.15 * self.size.height/10)
        stack.zPosition = 4
        stack.alpha = 0
        self.addChild(stack)
        
        //Burn Cards
        burnCard1.setScale(CGFloat(0.165 * Scaler))
        burnCard1.position = CGPoint(x: 5 * self.size.width/16, y: 6.15 * self.size.height/10)
        burnCard1.zPosition = 2
        burnCard1.alpha = 0
        self.addChild(burnCard1)
        burnCard2.setScale(CGFloat(0.165 * Scaler))
        burnCard2.position = CGPoint(x: 5 * self.size.width/16, y: 6.15 * self.size.height/10)
        burnCard2.zPosition = 2
        burnCard2.alpha = 0
        self.addChild(burnCard2)
        burnCard3.setScale(CGFloat(0.165 * Scaler))
        burnCard3.position = CGPoint(x: 5 * self.size.width/16, y: 6.15 * self.size.height/10)
        burnCard3.zPosition = 2
        burnCard3.alpha = 0
        self.addChild(burnCard3)
        
        if (defaults.string(forKey: "Flop1") == "None")
        {
            flopOneCard = SKSpriteNode(imageNamed: "Card Outline")
        }else{
            flopOneCard = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop1")!)
        }
        flopOneCard.setScale(CGFloat(0.165 * Scaler))
        flopOneCard.position = CGPoint(x: 6.5 * self.size.width/16, y: 6.15 * self.size.height/10)
        flopOneCard.zPosition = 1
        flopOneCard.alpha = 0
        self.addChild(flopOneCard)
        
        if (defaults.string(forKey: "Flop2") == "None")
        {
            flopTwoCard = SKSpriteNode(imageNamed: "Card Outline")
        }else{
            flopTwoCard = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop2")!)
        }
        flopTwoCard.setScale(CGFloat(0.165 * Scaler))
        flopTwoCard.position = CGPoint(x: 8 * self.size.width/16, y: 6.15 * self.size.height/10)
        flopTwoCard.zPosition = 1
        flopTwoCard.alpha = 0
        self.addChild(flopTwoCard)
        
        if (defaults.string(forKey: "Flop3") == "None")
        {
            flopThreeCard = SKSpriteNode(imageNamed: "Card Outline")
        }else{
            flopThreeCard = SKSpriteNode(imageNamed: defaults.string(forKey: "Flop3")!)
        }
        flopThreeCard.setScale(CGFloat(0.165 * Scaler))
        flopThreeCard.position = CGPoint(x: 9.5 * self.size.width/16, y: 6.15 * self.size.height/10)
        flopThreeCard.zPosition = 1
        flopThreeCard.alpha = 0
        self.addChild(flopThreeCard)
        
        //Guides
        //-Flop Guide
        flopGuide.setScale(CGFloat(0.165 * Scaler))
        flopGuide.position = CGPoint(x: 8 * self.size.width/16, y: 6.15 * self.size.height/10)
        flopGuide.zPosition = 2
        flopGuide.alpha = 0
        //-Turn Guide
        turnGuide.setScale(CGFloat(0.165 * Scaler))
        turnGuide.position = CGPoint(x: 11 * self.size.width/16, y: 6.15 * self.size.height/10)
        turnGuide.zPosition = 2
        turnGuide.alpha = 0
        //-River Guide
        riverGuide.setScale(CGFloat(0.165 * Scaler))
        riverGuide.position = CGPoint(x: 12.5 * self.size.width/16, y: 6.15 * self.size.height/10)
        riverGuide.zPosition = 2
        riverGuide.alpha = 0
        if (defaults.string(forKey: "Turn") == "None")
        {
            turnCard = SKSpriteNode(imageNamed: "Card Outline")
        }else{
            turnCard = SKSpriteNode(imageNamed: defaults.string(forKey: "Turn")!)
        }
        turnCard.setScale(CGFloat(0.165 * Scaler))
        turnCard.position = CGPoint(x: 11 * self.size.width/16, y: 6.15 * self.size.height/10)
        turnCard.zPosition = 1
        turnCard.alpha = 0
        self.addChild(turnCard)
        
        if (defaults.string(forKey: "River") == "None")
        {
            riverCard = SKSpriteNode(imageNamed: "Card Outline")
        }else{
            riverCard = SKSpriteNode(imageNamed: defaults.string(forKey: "River")!)
        }
        riverCard.setScale(CGFloat(0.165 * Scaler))
        riverCard.position = CGPoint(x: 12.5 * self.size.width/16, y: 6.15 * self.size.height/10)
        riverCard.zPosition = 1
        riverCard.alpha = 0
        self.addChild(riverCard)
        
        if(defaults.string(forKey: "Flop1") != "None" && defaults.string(forKey: "Flop2") != "None" && defaults.string(forKey: "Flop3") != "None")
        {
            flopDone = true
            Directions.text = "tap on overlay to generate turn"
        }
        
        if defaults.string(forKey: "Turn") != "None"
        {
            turnDone = true
            Directions.text = "tap on overlay to generate river"
        }
        
        if defaults.string(forKey: "River") != "None"
        {
            riverDone = true
            Directions.removeFromParent()
        }
        
        if flopDone == false
        {
            userBestHand(handSize: 2)
            preFlopStatistics()
        }
        
        if flopDone != true
        {
            self.addChild(flopGuide)
        }
        
        if flopDone == true && turnDone == false
        {
            flopGuide.removeFromParent()
            self.addChild(turnGuide)
            burnCard1.position = CGPoint(x: 3.5 * self.size.width/16, y: 6.15 * self.size.height/10)
            flopStatistics()
        }
        
        if flopDone == true && turnDone == true && riverDone != true
        {
            turnGuide.removeFromParent()
            self.addChild(riverGuide)
            burnCard1.position = CGPoint(x: 3.5 * self.size.width/16, y: 6.15 * self.size.height/10)
            riverStatistics()
        }
        
        if flopDone == true && turnDone == true && riverDone == true
        {
            riverGuide.removeFromParent()
            burnCard1.position = CGPoint(x: 3.5 * self.size.width/16, y: 6.15 * self.size.height/10)
            exit = true
        }
        
        if(exit == true)
        {
            endOfGame()
            //zPos
            Settings.zPosition = 16
            statisticsBackdrop.zPosition = 16
            besthandLabel.zPosition = 17
            bestHandValue.zPosition = 17
            statsLabel1.zPosition = 17
            statsLabel.zPosition = 17
            bestHandBackdrop.zPosition = 16
            betterHandLabel.zPosition = 17
            betterHandLabel2.zPosition = 17
            betterHandStat.zPosition = 17
            
            //Move Cards Up
            burnPile.position = CGPoint(x: 3.5 * self.size.width/16, y: 7 * self.size.height/10)
            burnPile.zPosition = 5
            
            stack.position = CGPoint(x: 5 * self.size.width/16, y: 7 * self.size.height/10)
            stack.zPosition = 17
            
            burnCard1.position = CGPoint(x: 3.5 * self.size.width/16, y: 7 * self.size.height/10)
            burnCard2.position = CGPoint(x: 3.5 * self.size.width/16, y: 7 * self.size.height/10)
            burnCard3.position = CGPoint(x: 3.5 * self.size.width/16, y: 7 * self.size.height/10)
            burnCard1.zPosition = 17

            flopOneCard.position = CGPoint(x: 6.5 * self.size.width/16, y: 7 * self.size.height/10)
            flopOneCard.zPosition = 17
            
            flopTwoCard.position = CGPoint(x: 8 * self.size.width/16, y: 7 * self.size.height/10)
            flopTwoCard.zPosition = 17
            
            flopThreeCard.position = CGPoint(x: 9.5 * self.size.width/16, y: 7 * self.size.height/10)
            flopThreeCard.zPosition = 17
            
            turnCard.position = CGPoint(x: 11 * self.size.width/16, y: 7 * self.size.height/10)
            turnCard.zPosition = 17
            
            riverCard.position = CGPoint(x: 12.5 * self.size.width/16, y: 7 * self.size.height/10)
            riverCard.zPosition = 17
            
            card1.zPosition = 17; card2.zPosition = 17
            
            
            //Play Again
            gameOver.alpha = 0.5
            gameOverLayer2.alpha = 0.15
            ttpLabel.fontName = "Copperplate-Light"
            ttpLabel.text = "Tap to Start New Game"
            ttpLabel.fontSize = CGFloat(51 * Scaler)
            ttpLabel.fontColor = SKColor.white
            ttpLabel.position = CGPoint(x: self.size.width/2, y: 5 * self.size.height/10)
            ttpLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            ttpLabel.zPosition = 20
            
            let fadeInFadeOut = SKAction.sequence([SKAction.fadeIn(withDuration: 1.0), SKAction.wait(forDuration: 1), SKAction.fadeOut(withDuration: 1.0)])
            ttpLabel.run( SKAction.repeatForever(fadeInFadeOut))
            self.addChild(ttpLabel); self.addChild(gameOver); self.addChild(gameOverLayer2)
        }
        
        
        //All Players "Cards"
        if defaults.double(forKey: "numberOfPlayers") == 2.0
        {
            extraCard1.setScale(CGFloat(0.165 * Scaler))
            extraCard1.position = CGPoint(x: 3.75 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard1.zPosition = 1
            extraCard1.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard1)
            extraCard2.setScale(CGFloat(0.165 * Scaler))
            extraCard2.position = CGPoint(x: 4.25 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard2.zPosition = 2
            extraCard2.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard2)
        }
        
        if defaults.double(forKey: "numberOfPlayers") == 3.0
        {
            extraCard1.setScale(CGFloat(0.165 * Scaler))
            extraCard1.position = CGPoint(x: 2.5 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard1.zPosition = 1
            extraCard1.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard1)
            extraCard2.setScale(CGFloat(0.165 * Scaler))
            extraCard2.position = CGPoint(x: 3 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard2.zPosition = 2
            extraCard2.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard2)
            
            extraCard3.setScale(CGFloat(0.165 * Scaler))
            extraCard3.position = CGPoint(x: 5 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard3.zPosition = 1
            extraCard3.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard3)
            extraCard4.setScale(CGFloat(0.165 * Scaler))
            extraCard4.position = CGPoint(x: 5.5 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard4.zPosition = 2
            extraCard4.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard4)
        }
        
        if defaults.double(forKey: "numberOfPlayers") == 4.0
        {
            extraCard1.setScale(CGFloat(0.165 * Scaler))
            extraCard1.position = CGPoint(x: 3.75 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard1.zPosition = 1
            extraCard1.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard1)
            extraCard2.setScale(CGFloat(0.165 * Scaler))
            extraCard2.position = CGPoint(x: 4.25 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard2.zPosition = 2
            extraCard2.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard2)
            
            extraCard3.setScale(CGFloat(0.165 * Scaler))
            extraCard3.position = CGPoint(x: 0, y: 4.75 * self.size.height/8)
            extraCard3.zPosition = 1
            extraCard3.zRotation = CGFloat(1.5 * Double.pi)
            self.addChild(extraCard3)
            extraCard4.setScale(CGFloat(0.165 * Scaler))
            extraCard4.position = CGPoint(x: 0, y: 5.75 * self.size.height/8)
            extraCard4.zPosition = 2
            extraCard4.zRotation = CGFloat(1.5 * Double.pi)
            self.addChild(extraCard4)
            
            extraCard5.setScale(CGFloat(0.165 * Scaler))
            extraCard5.position = CGPoint(x: self.size.width, y: 4.75 * self.size.height/8)
            extraCard5.zPosition = 1
            extraCard5.zRotation = CGFloat(Double.pi/2)
            self.addChild(extraCard5)
            extraCard6.setScale(CGFloat(0.165 * Scaler))
            extraCard6.position = CGPoint(x: self.size.width, y: 5.75 * self.size.height/8)
            extraCard6.zPosition = 2
            extraCard6.zRotation = CGFloat(Double.pi/2)
            self.addChild(extraCard6)
        }
        
        if defaults.double(forKey: "numberOfPlayers") == 5.0
        {
            extraCard1.setScale(CGFloat(0.165 * Scaler))
            extraCard1.position = CGPoint(x: 2.5 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard1.zPosition = 1
            extraCard1.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard1)
            extraCard2.setScale(CGFloat(0.165 * Scaler))
            extraCard2.position = CGPoint(x: 3 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard2.zPosition = 2
            extraCard2.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard2)
            extraCard3.setScale(CGFloat(0.165 * Scaler))
            extraCard3.position = CGPoint(x: 5 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard3.zPosition = 1
            extraCard3.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard3)
            extraCard4.setScale(CGFloat(0.165 * Scaler))
            extraCard4.position = CGPoint(x: 5.5 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard4.zPosition = 2
            extraCard4.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard4)
            
            extraCard5.setScale(CGFloat(0.165 * Scaler))
            extraCard5.position = CGPoint(x: 0, y: 4.75 * self.size.height/8)
            extraCard5.zPosition = 1
            extraCard5.zRotation = CGFloat(1.5 * Double.pi)
            self.addChild(extraCard5)
            extraCard6.setScale(CGFloat(0.165 * Scaler))
            extraCard6.position = CGPoint(x: 0, y: 5.75 * self.size.height/8)
            extraCard6.zPosition = 2
            extraCard6.zRotation = CGFloat(1.5 * Double.pi)
            self.addChild(extraCard6)
            
            extraCard7.setScale(CGFloat(0.165 * Scaler))
            extraCard7.position = CGPoint(x: self.size.width, y: 4.75 * self.size.height/8)
            extraCard7.zPosition = 1
            extraCard7.zRotation = CGFloat(Double.pi/2)
            self.addChild(extraCard7)
            extraCard8.setScale(CGFloat(0.165 * Scaler))
            extraCard8.position = CGPoint(x: self.size.width, y: 5.75 * self.size.height/8)
            extraCard8.zPosition = 2
            extraCard8.zRotation = CGFloat(Double.pi/2)
            self.addChild(extraCard8)
        }
        
        if defaults.double(forKey: "numberOfPlayers") == 6.0
        {
            //Top Panel
            extraCard1.setScale(CGFloat(0.165 * Scaler))
            extraCard1.position = CGPoint(x: 1.75 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard1.zPosition = 1
            extraCard1.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard1)
            extraCard2.setScale(CGFloat(0.165 * Scaler))
            extraCard2.position = CGPoint(x: 2.25 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard2.zPosition = 2
            extraCard2.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard2)
            extraCard3.setScale(CGFloat(0.165 * Scaler))
            extraCard3.position = CGPoint(x: 5.75 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard3.zPosition = 1
            extraCard3.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard3)
            extraCard4.setScale(CGFloat(0.165 * Scaler))
            extraCard4.position = CGPoint(x: 6.25 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard4.zPosition = 2
            extraCard4.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard4)
            extraCard9.setScale(CGFloat(0.165 * Scaler))
            extraCard9.position = CGPoint(x: 3.75 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard9.zPosition = 1
            extraCard9.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard9)
            extraCard10.setScale(CGFloat(0.165 * Scaler))
            extraCard10.position = CGPoint(x: 4.25 * self.size.width/8, y: 10 * self.size.height/10)
            extraCard10.zPosition = 2
            extraCard10.zRotation = CGFloat(Double.pi)
            self.addChild(extraCard10)
            
            //Left and Right Sides
            extraCard5.setScale(CGFloat(0.165 * Scaler))
            extraCard5.position = CGPoint(x: 0, y: 4.75 * self.size.height/8)
            extraCard5.zPosition = 1
            extraCard5.zRotation = CGFloat(1.5 * Double.pi)
            self.addChild(extraCard5)
            extraCard6.setScale(CGFloat(0.165 * Scaler))
            extraCard6.position = CGPoint(x: 0, y: 5.75 * self.size.height/8)
            extraCard6.zPosition = 2
            extraCard6.zRotation = CGFloat(1.5 * Double.pi)
            self.addChild(extraCard6)
            extraCard7.setScale(CGFloat(0.165 * Scaler))
            extraCard7.position = CGPoint(x: self.size.width, y: 4.75 * self.size.height/8)
            extraCard7.zPosition = 1
            extraCard7.zRotation = CGFloat(Double.pi/2)
            self.addChild(extraCard7)
            extraCard8.setScale(CGFloat(0.165 * Scaler))
            extraCard8.position = CGPoint(x: self.size.width, y: 5.75 * self.size.height/8)
            extraCard8.zPosition = 2
            extraCard8.zRotation = CGFloat(Double.pi/2)
            self.addChild(extraCard8)
        }
        
        fadeIn()
    }
    
    func moveBurnCard()
    {
        let moveBurnCard1 = SKAction.move(to: CGPoint(x: 3.5 * self.size.width/16, y: 6.15 * self.size.height/10), duration: 0.5)
        let fadeOutDirections = SKAction.fadeOut(withDuration: 0.5)
        let sequence = SKAction.sequence([moveBurnCard1])
        burnCard1.run(sequence)
        Directions.run(fadeOutDirections)
    }
    func moveBurnCard2()
    {
        let moveBurnCard2 = SKAction.move(to: CGPoint(x: 3.5 * self.size.width/16, y: 6.15 * self.size.height/10), duration: 0.5)
        let fadeOutDirections = SKAction.fadeOut(withDuration: 0.5)
        let sequence = SKAction.sequence([moveBurnCard2])
        burnCard2.run(sequence)
        Directions.run(fadeOutDirections)
    }
    func moveBurnCard3()
    {
        let moveBurnCard3 = SKAction.move(to: CGPoint(x: 3.5 * self.size.width/16, y: 6.15 * self.size.height/10), duration: 0.5)
        let fadeOutDirections = SKAction.fadeOut(withDuration: 0.5)
        let sequence = SKAction.sequence([moveBurnCard3])
        burnCard3.run(sequence)
        Directions.run(fadeOutDirections)
    }
    
    //Origin is top left
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch: AnyObject in touches
        {
            let pointOfTouch = touch.location(in: view)
            
            //Menu Toggle
            if(pointOfTouch.x > SettingsXCoord - Settings.size.width/2 && pointOfTouch.x < SettingsXCoord + Settings.size.width/2) && (pointOfTouch.y > self.size.height - SettingsYCoord - Settings.size.height/2 && pointOfTouch.y <  self.size.height - SettingsYCoord + Settings.size.height/2 )
            {
                settingsTapped += 1
                
                if settingsTapped % 2 != 0
                {
                    settingDisplay = true
                    settingsMenu.alpha = 1
                    settingsLabel.alpha = 1
                    settingsNumPlayers.alpha = 1
                    settingGameMode.alpha = 1
                    onePlayer.alpha = 1; twoPlayers.alpha = 1; threePlayers.alpha = 1; fourPlayers.alpha = 1; fivePlayers.alpha = 1; sixPlayers.alpha = 1
                    overlay.alpha = 0.6; gameModeOverlay.alpha = 0.6
                    gSimulated.alpha = 1; gManual.alpha = 1
                    manualPlay.alpha = 1; simulatedPlay.alpha = 1
                    settingsUpdate.alpha = 1
                    exitGame.alpha = 1; settingsLeaveGame.alpha = 1
                }else{
                    settingDisplay = false
                    settingsMenu.alpha = 0
                    settingsLabel.alpha = 0
                    settingsNumPlayers.alpha = 0
                    settingGameMode.alpha = 0
                    onePlayer.alpha = 0; twoPlayers.alpha = 0; threePlayers.alpha = 0; fourPlayers.alpha = 0; fivePlayers.alpha = 0; sixPlayers.alpha = 0
                    overlay.alpha = 0; gameModeOverlay.alpha = 0
                    gSimulated.alpha = 0; gManual.alpha = 0
                    manualPlay.alpha = 0; simulatedPlay.alpha = 0
                    settingsUpdate.alpha = 0
                    exitGame.alpha = 0; settingsLeaveGame.alpha = 0
                }
                
                self.run(SKAction.wait(forDuration: 0.05))
            }
            
            //Display/Touch Reading
            if settingDisplay == true
            {
                //Number of Players
                if(pointOfTouch.x > 2.14 * self.size.width/10 - onePlayer.size.width/2 && pointOfTouch.x < 2.14 * self.size.width/10 + onePlayer.size.width/2) && (pointOfTouch.y > self.size.height - onePlayer.position.y - onePlayer.size.height/2 && pointOfTouch.y < self.size.height - onePlayer.position.y + onePlayer.size.height/2)
                {
                    overlay.position = CGPoint(x: 2.14 * self.size.width/10, y: 0.23 * self.size.height)
                    defaults.set(1.0, forKey: "tempNumberOfPlayers")
                }
                if(pointOfTouch.x > 3.28 * self.size.width/10 - onePlayer.size.width/2 && pointOfTouch.x < 3.28 * self.size.width/10 + onePlayer.size.width/2) && (pointOfTouch.y > self.size.height - onePlayer.position.y - onePlayer.size.height/2 && pointOfTouch.y < self.size.height - onePlayer.position.y + onePlayer.size.height/2)
                {
                    overlay.position = CGPoint(x: 3.28 * self.size.width/10, y: 0.23 * self.size.height)
                    defaults.set(2.0, forKey: "tempNumberOfPlayers")
                }
                if(pointOfTouch.x > 4.42 * self.size.width/10 - onePlayer.size.width/2 && pointOfTouch.x < 4.42 * self.size.width/10 + onePlayer.size.width/2) && (pointOfTouch.y > self.size.height - onePlayer.position.y - onePlayer.size.height/2 && pointOfTouch.y < self.size.height - onePlayer.position.y + onePlayer.size.height/2)
                {
                    overlay.position = CGPoint(x: 4.42 * self.size.width/10, y: 0.23 * self.size.height)
                    defaults.set(3.0, forKey: "tempNumberOfPlayers")
                }
                if(pointOfTouch.x > 5.56 * self.size.width/10 - onePlayer.size.width/2 && pointOfTouch.x < 5.56 * self.size.width/10 + onePlayer.size.width/2) && (pointOfTouch.y > self.size.height - onePlayer.position.y - onePlayer.size.height/2 && pointOfTouch.y < self.size.height - onePlayer.position.y + onePlayer.size.height/2)
                {
                    overlay.position = CGPoint(x: 5.56 * self.size.width/10, y: 0.23 * self.size.height)
                    defaults.set(4.0, forKey: "tempNumberOfPlayers")
                }
                if(pointOfTouch.x > 6.75 * self.size.width/10 - onePlayer.size.width/2 && pointOfTouch.x < 6.75 * self.size.width/10 + onePlayer.size.width/2) && (pointOfTouch.y > self.size.height - onePlayer.position.y - onePlayer.size.height/2 && pointOfTouch.y < self.size.height - onePlayer.position.y + onePlayer.size.height/2)
                {
                    overlay.position = CGPoint(x: 6.75 * self.size.width/10, y: 0.23 * self.size.height)
                    defaults.set(5.0, forKey: "tempNumberOfPlayers")
                }
                if(pointOfTouch.x > 7.86 * self.size.width/10 - onePlayer.size.width/2 && pointOfTouch.x < 7.86 * self.size.width/10 + onePlayer.size.width/2) && (pointOfTouch.y > self.size.height - onePlayer.position.y - onePlayer.size.height/2 && pointOfTouch.y < self.size.height - onePlayer.position.y + onePlayer.size.height/2)
                {
                    overlay.position = CGPoint(x: 7.86 * self.size.width/10, y: 0.23 * self.size.height)
                    defaults.set(6.0, forKey: "tempNumberOfPlayers")
                }
                
                
                //GameMode
                if (pointOfTouch.x > 3.666 * self.size.width/10 - gameManual.width/2 && pointOfTouch.x <  3.666 * self.size.width/10 + gameManual.width/2) && (pointOfTouch.y > self.size.height - gameSimulated.midY - gameManual.height/2 && pointOfTouch.y < self.size.height - gameSimulated.midY + gameManual.height/2)
                {
                    gameModeOverlay.position = CGPoint(x: 3.666 * self.size.width/10, y: gameManual.midY)
                    defaults.set(0, forKey: "tempGameMode")
                }
                if (pointOfTouch.x > 6.333 * self.size.width/10 - gameManual.width/2 && pointOfTouch.x < 6.333 * self.size.width/10 + gameManual.width/2) && (pointOfTouch.y > self.size.height - gameSimulated.midY - gameManual.height/2 && pointOfTouch.y < self.size.height - gameSimulated.midY + gameManual.height/2)
                {
                    gameModeOverlay.position = CGPoint(x: 6.333 * self.size.width/10, y: gameManual.midY)
                    defaults.set(1, forKey: "tempGameMode")
                }
                
                //Leave Game
                if(pointOfTouch.x > self.size.width/2 - exitGameRect.width/2 && pointOfTouch.x < self.size.width/2 + exitGameRect.width/2) && (pointOfTouch.y > self.size.height - exitGameRect.midY - exitGameRect.height/2 && pointOfTouch.y < self.size.height - exitGameRect.midY + exitGameRect.height/2)
                {
                    settingsMenu.alpha = 0
                    settingsLabel.alpha = 0
                    settingsNumPlayers.alpha = 0
                    settingGameMode.alpha = 0
                    onePlayer.alpha = 0; twoPlayers.alpha = 0; threePlayers.alpha = 0; fourPlayers.alpha = 0; fivePlayers.alpha = 0; sixPlayers.alpha = 0
                    overlay.alpha = 0; gameModeOverlay.alpha = 0
                    gSimulated.alpha = 0; gManual.alpha = 0
                    manualPlay.alpha = 0; simulatedPlay.alpha = 0
                    settingsUpdate.alpha = 0
                    exitGame.alpha = 0; settingsLeaveGame.alpha = 0
                    
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
                    
                    defaults.set(defaults.double(forKey: "tempNumberOfPlayers"), forKey: "numberOfPlayers")
                    defaults.set(defaults.double(forKey: "tempGameMode"), forKey: "gameMode")
                    
                    //self.run(SKAction.wait(forDuration: 0.5))
                    fadeOut(exitNumber: 4)
                }
            }else{
                //Change Stats
                if (pointOfTouch.x > 8.5 * self.size.width/10 - statisticsBackdrop.size.width/2 && pointOfTouch.x < 8.5 * self.size.width/10 + statisticsBackdrop.size.width/2 && pointOfTouch.y > 8.2 * self.size.height/10 - statisticsBackdrop.size.height/2 && pointOfTouch.y < 8.2 * self.size.height/10 + statisticsBackdrop.size.height/2)
                {
                    let fadeIn = SKAction.fadeIn(withDuration: 0.35)
                    let fadeOut = SKAction.fadeOut(withDuration: 0.35)
                    if maxCycle == 0
                    {
                        betterHandLabel.removeFromParent()
                        betterHandLabel2.removeFromParent()
                        betterHandStat.removeFromParent()
                        
                        self.addChild(betterHandLabel)
                        self.addChild(betterHandLabel2)
                        self.addChild(betterHandStat)
                    }
                    
                    if maxCycle == 1
                    {
                        betterHandLabel.alpha = 0; betterHandLabel2.alpha = 0; betterHandStat.alpha = 0
                        sLabel.alpha = 0; statisticsLabel1.alpha = 0; statsLabel1.alpha = 0
                        
                        if statDisplay == 0
                        {
                            sLabel.removeFromParent()
                            statisticsLabel1.removeFromParent()
                            statsLabel1.removeFromParent()
                            
                            self.addChild(betterHandLabel)
                            self.addChild(betterHandLabel2)
                            self.addChild(betterHandStat)
                            betterHandLabel.run(fadeIn); betterHandLabel2.run(fadeIn); betterHandStat.run(fadeIn)
                        }
                        
                        if statDisplay == 1
                        {
                            betterHandLabel.run(fadeOut); betterHandLabel2.run(fadeOut); betterHandStat.run(fadeOut)
                            betterHandLabel.removeFromParent()
                            betterHandLabel2.removeFromParent()
                            betterHandStat.removeFromParent()
                            
                            self.addChild(sLabel)
                            self.addChild(statisticsLabel1)
                            self.addChild(statsLabel1)
                            sLabel.run(fadeIn); statsLabel1.run(fadeIn); statisticsLabel1.run(fadeIn)
                        }
                    }
                    if maxCycle == 2
                    {
                        betterHandLabel.alpha = 0; betterHandLabel2.alpha = 0; betterHandStat.alpha = 0
                        sLabel.alpha = 0; statisticsLabel1.alpha = 0; statsLabel1.alpha = 0
                        statisticsLabel2.alpha = 0; statsLabel2.alpha = 0
                        
                        if statDisplay == 0
                        {
                            sLabel.removeFromParent()
                            statisticsLabel2.removeFromParent()
                            statsLabel2.removeFromParent()
                            
                            self.addChild(betterHandLabel)
                            self.addChild(betterHandLabel2)
                            self.addChild(betterHandStat)
                            betterHandLabel.run(fadeIn); betterHandLabel2.run(fadeIn); betterHandStat.run(fadeIn)
                        }
                        
                        if statDisplay == 1
                        {
                            betterHandLabel.run(fadeOut); betterHandLabel2.run(fadeOut); betterHandStat.run(fadeOut)
                            betterHandLabel.removeFromParent()
                            betterHandLabel2.removeFromParent()
                            betterHandStat.removeFromParent()
                            
                            self.addChild(sLabel)
                            self.addChild(statisticsLabel1)
                            self.addChild(statsLabel1)
                            sLabel.run(fadeIn); statsLabel1.run(fadeIn); statisticsLabel1.run(fadeIn)
                        }
                        if statDisplay == 2
                        {
                            statisticsLabel1.run(fadeOut); statsLabel1.run(fadeOut)
                            statisticsLabel1.removeFromParent()
                            statsLabel1.removeFromParent()
                            
                            self.addChild(statisticsLabel2)
                            self.addChild(statsLabel2)
                            sLabel.run(fadeIn); statsLabel2.run(fadeIn); statisticsLabel2.run(fadeIn)
                        }
                    }
                    
                    if maxCycle == 3
                    {
                        betterHandLabel.alpha = 0; betterHandLabel2.alpha = 0; betterHandStat.alpha = 0
                        sLabel.alpha = 0; statisticsLabel1.alpha = 0; statsLabel1.alpha = 0
                        statisticsLabel2.alpha = 0; statsLabel2.alpha = 0
                        statisticsLabel3.alpha = 0; statsLabel3.alpha = 0
                        
                        if statDisplay == 0
                        {
                            sLabel.removeFromParent()
                            statisticsLabel3.removeFromParent()
                            statsLabel3.removeFromParent()
                            
                            self.addChild(betterHandLabel)
                            self.addChild(betterHandLabel2)
                            self.addChild(betterHandStat)
                            betterHandLabel.run(fadeIn); betterHandLabel2.run(fadeIn); betterHandStat.run(fadeIn)
                        }
                        if statDisplay == 1
                        {
                            betterHandLabel.run(fadeOut); betterHandLabel2.run(fadeOut); betterHandStat.run(fadeOut)
                            betterHandLabel.removeFromParent()
                            betterHandLabel2.removeFromParent()
                            betterHandStat.removeFromParent()
                            self.addChild(sLabel)
                            
                            self.addChild(statisticsLabel1)
                            self.addChild(statsLabel1)
                            sLabel.run(fadeIn); statsLabel1.run(fadeIn); statisticsLabel1.run(fadeIn)
                        }
                        if statDisplay == 2
                        {
                            statisticsLabel1.run(fadeOut); statsLabel1.run(fadeOut)
                            statisticsLabel1.removeFromParent()
                            statsLabel1.removeFromParent()
                            
                            self.addChild(statisticsLabel2)
                            self.addChild(statsLabel2)
                            sLabel.run(fadeIn); statsLabel2.run(fadeIn); statisticsLabel2.run(fadeIn)
                        }
                        if statDisplay == 3
                        {
                            statisticsLabel2.run(fadeOut); statsLabel2.run(fadeOut)
                            statisticsLabel2.removeFromParent()
                            statsLabel2.removeFromParent()
                            
                            self.addChild(statisticsLabel3)
                            self.addChild(statsLabel3)
                            sLabel.run(fadeIn); statsLabel3.run(fadeIn); statisticsLabel3.run(fadeIn)
                        }
                    }
                    
                    if maxCycle == 4
                    {
                        betterHandLabel.alpha = 0; betterHandLabel2.alpha = 0; betterHandStat.alpha = 0
                        sLabel.alpha = 0; statisticsLabel1.alpha = 0; statsLabel1.alpha = 0
                        statisticsLabel2.alpha = 0; statsLabel2.alpha = 0
                        statisticsLabel3.alpha = 0; statsLabel3.alpha = 0
                        statisticsLabel4.alpha = 0; statsLabel4.alpha = 0
                        
                        if statDisplay == 0
                        {
                            sLabel.removeFromParent()
                            statisticsLabel4.removeFromParent()
                            statsLabel4.removeFromParent()
                            
                            self.addChild(betterHandLabel)
                            self.addChild(betterHandLabel2)
                            self.addChild(betterHandStat)
                            betterHandLabel.run(fadeIn); betterHandLabel2.run(fadeIn); betterHandStat.run(fadeIn)
                        }
                        if statDisplay == 1
                        {
                            betterHandLabel.run(fadeOut); betterHandLabel2.run(fadeOut); betterHandStat.run(fadeOut)
                            betterHandLabel.removeFromParent()
                            betterHandLabel2.removeFromParent()
                            betterHandStat.removeFromParent()
                            
                            self.addChild(sLabel)
                            self.addChild(statisticsLabel1)
                            self.addChild(statsLabel1)
                            sLabel.run(fadeIn); statsLabel1.run(fadeIn); statisticsLabel1.run(fadeIn)
                        }
                        if statDisplay == 2
                        {
                            statisticsLabel1.run(fadeOut); statsLabel1.run(fadeOut)
                            statisticsLabel1.removeFromParent()
                            statsLabel1.removeFromParent()
                            
                            self.addChild(statisticsLabel2)
                            self.addChild(statsLabel2)
                            sLabel.run(fadeIn); statsLabel2.run(fadeIn); statisticsLabel2.run(fadeIn)
                        }
                        if statDisplay == 3
                        {
                            statisticsLabel2.run(fadeOut); statsLabel2.run(fadeOut)
                            statisticsLabel2.removeFromParent()
                            statsLabel2.removeFromParent()
                            
                            self.addChild(statisticsLabel3)
                            self.addChild(statsLabel3)
                            sLabel.run(fadeIn); statsLabel3.run(fadeIn); statisticsLabel3.run(fadeIn)
                        }
                        if statDisplay == 4
                        {
                            statisticsLabel3.run(fadeOut); statsLabel3.run(fadeOut)
                            statisticsLabel3.removeFromParent()
                            statsLabel3.removeFromParent()
                            
                            self.addChild(statisticsLabel4)
                            self.addChild(statsLabel4)
                            sLabel.run(fadeIn); statsLabel4.run(fadeIn); statisticsLabel4.run(fadeIn)
                        }
                    }
                    
                    if maxCycle == 5
                    {
                        betterHandLabel.alpha = 0; betterHandLabel2.alpha = 0; betterHandStat.alpha = 0
                        sLabel.alpha = 0; statisticsLabel1.alpha = 0; statsLabel1.alpha = 0
                        statisticsLabel2.alpha = 0; statsLabel2.alpha = 0
                        statisticsLabel3.alpha = 0; statsLabel3.alpha = 0
                        statisticsLabel4.alpha = 0; statsLabel4.alpha = 0
                        statisticsLabel5.alpha = 0; statsLabel5.alpha = 0
                        
                        if statDisplay == 0
                        {
                            sLabel.removeFromParent()
                            statisticsLabel5.removeFromParent()
                            statsLabel5.removeFromParent()
                            
                            self.addChild(betterHandLabel)
                            self.addChild(betterHandLabel2)
                            self.addChild(betterHandStat)
                            betterHandLabel.run(fadeIn); betterHandLabel2.run(fadeIn); betterHandStat.run(fadeIn)
                        }
                        if statDisplay == 1
                        {
                            betterHandLabel.run(fadeOut); betterHandLabel2.run(fadeOut); betterHandStat.run(fadeOut)
                            betterHandLabel.removeFromParent()
                            betterHandLabel2.removeFromParent()
                            betterHandStat.removeFromParent()
                            
                            self.addChild(sLabel)
                            self.addChild(statisticsLabel1)
                            self.addChild(statsLabel1)
                            sLabel.run(fadeIn); statsLabel1.run(fadeIn); statisticsLabel1.run(fadeIn)
                        }
                        if statDisplay == 2
                        {
                            statisticsLabel1.run(fadeOut); statsLabel1.run(fadeOut)
                            statisticsLabel1.removeFromParent()
                            statsLabel1.removeFromParent()
                            
                            self.addChild(statisticsLabel2)
                            self.addChild(statsLabel2)
                            sLabel.run(fadeIn); statsLabel2.run(fadeIn); statisticsLabel2.run(fadeIn)
                        }
                        if statDisplay == 3
                        {
                            statisticsLabel2.run(fadeOut); statsLabel2.run(fadeOut)
                            statisticsLabel2.removeFromParent()
                            statsLabel2.removeFromParent()
                            
                            self.addChild(statisticsLabel3)
                            self.addChild(statsLabel3)
                            sLabel.run(fadeIn); statsLabel3.run(fadeIn); statisticsLabel3.run(fadeIn)
                        }
                        if statDisplay == 4
                        {
                            statisticsLabel3.run(fadeOut); statsLabel3.run(fadeOut)
                            statisticsLabel3.removeFromParent()
                            statsLabel3.removeFromParent()
                            
                            self.addChild(statisticsLabel4)
                            self.addChild(statsLabel4)
                            sLabel.run(fadeIn); statsLabel4.run(fadeIn); statisticsLabel4.run(fadeIn)
                        }
                        if statDisplay == 5
                        {
                            statisticsLabel4.run(fadeOut); statsLabel4.run(fadeOut)
                            statisticsLabel4.removeFromParent()
                            statsLabel4.removeFromParent()
                            
                            self.addChild(statisticsLabel5)
                            self.addChild(statsLabel5)
                            sLabel.run(fadeIn); statsLabel5.run(fadeIn); statisticsLabel5.run(fadeIn)
                        }
                    }
                    
                    //print("Change Stats")
                    statDisplay += 1
                    if statDisplay > maxCycle
                    {
                        statDisplay = 0
                    }
                }
                
                
                //Flop Cards
                if defaults.string(forKey: "Flop3") == "None" && defaults.string(forKey: "Turn") == "None" && defaults.string(forKey: "River") == "None"
                {
                    if ((pointOfTouch.x > (7.5 * self.size.width/16 - flopGuide.size.width/2) && pointOfTouch.x < (7.5 * self.size.width/16 + flopGuide.size.width/2)) && (pointOfTouch.y > (3.25 * self.size.height/10 - flopGuide.size.height/2) && pointOfTouch.y < (3.25 * self.size.height/10 + flopGuide.size.height/2)))
                    {
                        self.run(SKAction.wait(forDuration: 0.05))
                        //print("Random Card: \(randAvailCard())")
                        defaults.set(randAvailCard(), forKey: "Flop1")
                        defaults.set(randAvailCard(), forKey: "Flop2")
                        defaults.set(randAvailCard(), forKey: "Flop3")
                        
                        flopDone = true
                        let burn = SKAction.run(moveBurnCard)
                        let wait = SKAction.wait(forDuration: 0.75)
                        let switchScene = SKAction.run(moveToGameSceneFlop)
                        let sequence = SKAction.sequence([burn,wait,switchScene])
                        self.run(sequence)
                    }
                }
                
                if defaults.string(forKey: "Flop3") != "None" && defaults.string(forKey: "Turn") == "None" && defaults.string(forKey: "River") == "None"
                {
                    /*
                    //Generate New Flop
                    if ((pointOfTouch.x > (7.5 * self.size.width/16 - flopGuide.size.width/2) && pointOfTouch.x < (7.5 * self.size.width/16 + flopGuide.size.width/2)) && (pointOfTouch.y > (3.25 * self.size.height/10 - flopGuide.size.height/2) && pointOfTouch.y < (3.25 * self.size.height/10 + flopGuide.size.height/2)))
                    {
                        self.run(SKAction.wait(forDuration: 0.05))
                        //print("Random Card: \(randAvailCard())")
                        defaults.set(randAvailCard(), forKey: "Flop1")
                        defaults.set(randAvailCard(), forKey: "Flop2")
                        defaults.set(randAvailCard(), forKey: "Flop3")
                        
                        flopDone = true
                        let burn = SKAction.run(moveBurnCard)
                        let wait = SKAction.wait(forDuration: 0.75)
                        let switchScene = SKAction.run(moveToGameSceneFlop)
                        let sequence = SKAction.sequence([burn,wait,switchScene])
                        self.run(sequence)
                    }
                     */
                    //Genrate Turn Card
                    if ((pointOfTouch.x > (10.5 * self.size.width/16 - turnGuide.size.width/2) && pointOfTouch.x < (10.5 * self.size.width/16 + turnGuide.size.width/2)) && (pointOfTouch.y > (3.25 * self.size.height/10 - turnGuide.size.height/2) && pointOfTouch.y < (3.25 * self.size.height/10 + turnGuide.size.height/2)))
                    {
                        defaults.set(randAvailCard(), forKey: "Turn")
                        let burn = SKAction.run(moveBurnCard2)
                        let wait = SKAction.wait(forDuration: 0.75)
                        let switchScene = SKAction.run(moveToGameSceneTurn)
                        let sequence = SKAction.sequence([burn,wait,switchScene])
                        self.run(sequence)
                    }
                }
                
                if defaults.string(forKey: "Flop3") != "None" && defaults.string(forKey: "Turn") != "None" && defaults.string(forKey: "River") == "None"
                {
                    /*
                     //Generate New Turn Card
                     defaults.set(randAvailCard(), forKey: "Turn")
                     let burn = SKAction.run(moveBurnCard2)
                     let wait = SKAction.wait(forDuration: 0.75)
                     let switchScene = SKAction.run(moveToGameSceneTurn)
                     let sequence = SKAction.sequence([burn,wait,switchScene])
                     self.run(sequence)
                     */
                    
                    //Generate River Card
                    if ((pointOfTouch.x > (12 * self.size.width/16 - turnGuide.size.width/2) && pointOfTouch.x < (12 * self.size.width/16 + turnGuide.size.width/2)) && (pointOfTouch.y > (3.25 * self.size.height/10 - turnGuide.size.height/2) && pointOfTouch.y < (3.25 * self.size.height/10 + turnGuide.size.height/2)))
                    {
                        defaults.set(randAvailCard(), forKey: "River")
                        
                        let burn = SKAction.run(moveBurnCard3)
                        let wait = SKAction.wait(forDuration: 0.75)
                        let switchScene = SKAction.run(moveToGameSceneRiver)
                        let sequence = SKAction.sequence([burn,wait,switchScene])
                        self.run(sequence)
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
                    
                    defaults.set(defaults.double(forKey: "tempNumberOfPlayers"), forKey: "numberOfPlayers")
                    defaults.set(defaults.double(forKey: "tempGameMode"), forKey: "gameMode")
                
                    fadeOut(exitNumber: 3)
                }
            }
            
        }
    }
    
    func preFlopStatistics()    //Clean Board -> Flop
    {
        statisticsLabel1.removeFromParent()
        statisticsLabel2.removeFromParent()
        statisticsLabel3.removeFromParent()
        statisticsLabel4.removeFromParent()
        statisticsLabel5.removeFromParent()
        statsLabel1.removeFromParent()
        statsLabel2.removeFromParent()
        statsLabel3.removeFromParent()
        statsLabel4.removeFromParent()
        statsLabel5.removeFromParent()
        
        //print("Pre-Flop Statistics")
        let holeCard1 = defaults.string(forKey: "Card1")
        let holeCard2 = defaults.string(forKey: "Card2")
        
        let holeCard1Array = holeCard1!.components(separatedBy: " - ")
        let holeCard2Array = holeCard2!.components(separatedBy: " - ")
        
        let suitCard1 = holeCard1Array[0]
        let suitCard2 = holeCard2Array[0]
        
        let valCard1 = holeCard1Array[1]
        let valCard2 = holeCard2Array[1]
        
        var number = 10
        //Suited
        if suitCard1 == suitCard2
        {
            number = 10
            
            statisticsLabel1.text = "flush on flop:"
            statsLabel1.text = "\(FlopImproving.scFlush)%"
            statisticsLabel2.text = "flush draw (4/5):"
            statsLabel2.text = "\(FlopImproving.scFlushDraw)%"
            statisticsLabel3.text = "backdoor flush draw (3/5):"
            statsLabel3.text = "\(FlopImproving.scBDFlushDraw)%"
            
            //if Int(valCard1) == i
            
            maxCycle = 3
        }
        //Unpaired
        if valCard1 != valCard2 && suitCard1 != suitCard2
        {
            number = 10
            statisticsLabel1.text = "One pair on flop:"
            statsLabel1.text = "\(FlopImproving.upOnePair)%"
            statisticsLabel2.text = "Two pairs on flop:"
            statsLabel2.text = "\(FlopImproving.upTwoPair)%"
            
            maxCycle = 2
        }
        
        //Pocket Pair
        if valCard1 == valCard2
        {
            number = 9
            
            statisticsLabel1.text = "three of a kind or better:"
            statsLabel1.text = "\(FlopImproving.ppThreeKindBetter)%"
            statisticsLabel2.text = "three of a kind:"
            statsLabel2.text = "\(FlopImproving.ppThreeKind)%"
            statisticsLabel3.text = "full house:"
            statsLabel3.text = "\(FlopImproving.ppFullHouse)%"
            statisticsLabel4.text = "four of a kind:"
            statsLabel4.text = "\(FlopImproving.ppFourKind)%"
            
            maxCycle = 4
        }
        
        if areConnectors() == true
        {
            
            if suitCard1 == suitCard2
            {
                statisticsLabel4.text = "stright or flush draw:"
                statsLabel4.text = "\(FlopImproving.occStraightOrFlush)%"
                
                statisticsLabel5.text = "straight on flop:"
                statsLabel5.text = "\(FlopImproving.occStraight)%"
                
                maxCycle = 5
            }
            
            if suitCard1 != suitCard2
            {
                statisticsLabel3.text = "straight draw:"
                statsLabel3.text = "\(FlopImproving.occOESD)%"
                
                statisticsLabel4.text = "straight on flop:"
                statsLabel4.text = "\(FlopImproving.occStraight)%"
                
                maxCycle = 4
            }
        }
        
        bestHand()
        self.addChild(betterHandStat)
    }
    
    func flopStatistics()       //Flop -> River & Flop -> Turn
    {
        let rank = userBestHand(handSize: 5)
        maxCycle = 0
        
        statisticsLabel1.removeFromParent()
        statisticsLabel2.removeFromParent()
        statisticsLabel3.removeFromParent()
        statisticsLabel4.removeFromParent()
        statisticsLabel5.removeFromParent()
        statsLabel1.removeFromParent()
        statsLabel2.removeFromParent()
        statsLabel3.removeFromParent()
        statsLabel4.removeFromParent()
        statsLabel5.removeFromParent()
        
        //print("Pre-Turn/Flop Statistics")
        /*
         struct TurnImproving
         {
         let gsdStraight = 8.5       //Straight draw missing a card in the middle, the gut
         }
         */
        
        let flushdraw = flushDraw(handSize: 5)//1
        let straightdraw = straightDraw(handSize: 5)
        
        if rank == 10
        {
            statisticsLabel1.text = "pair:"
            statsLabel1.text = "\(TurnImproving.upPair)%"
            maxCycle = 1
            //Need how to distinguish flush draaw
            if flushdraw == true
            {
                statisticsLabel2.text = "flush:"
                statsLabel2.text = "\(TurnImproving.fdFlush)%"
                
                maxCycle = 2
            }
            
            if straightdraw == true
            {
                if flushdraw == true
                {
                    statisticsLabel3.text = "straight:"
                    statsLabel3.text = "\(TurnImproving.oesdStraight)%"
                    maxCycle = 3
                }else{
                    statisticsLabel2.text = "straight:"
                    statsLabel2.text = "\(TurnImproving.oesdStraight)%"
                    maxCycle = 2
                }
            }
        }
        if rank == 9
        {
            statisticsLabel1.text = "three of a kind:"
            statsLabel1.text = "\(TurnImproving.pThreeKind)%"
            
            maxCycle = 1
            
            if flushdraw == true
            {
                statisticsLabel2.text = "flush:"
                statsLabel2.text = "\(TurnImproving.fdFlush)%"
                
                maxCycle = 2
            }
            if straightdraw == true
            {
                if flushdraw == true
                {
                    statisticsLabel3.text = "straight:"
                    statsLabel3.text = "\(TurnImproving.oesdStraight)%"
                    maxCycle = 3
                }else{
                    statisticsLabel2.text = "straight:"
                    statsLabel2.text = "\(TurnImproving.oesdStraight)%"
                    maxCycle = 2
                }
            }
            
        }
        if rank == 8 //Two Pair
        {
            statisticsLabel1.text = "full house:"
            statsLabel1.text = "\(TurnImproving.tpFullHouse)%"
            
            maxCycle = 1
            
            if flushdraw == true
            {
                statisticsLabel2.text = "flush:"
                statsLabel2.text = "\(TurnImproving.fdFlush)%"
                
                maxCycle = 2
            }
            
            if straightdraw == true
            {
                if flushdraw == true
                {
                    statisticsLabel3.text = "straight:"
                    statsLabel3.text = "\(TurnImproving.oesdStraight)%"
                    maxCycle = 3
                }else{
                    statisticsLabel2.text = "straight:"
                    statsLabel2.text = "\(TurnImproving.oesdStraight)%"
                    maxCycle = 2
                }
            }
        }
        if rank == 7 //Three Kind
        {
            statisticsLabel1.text = "four of a kind:"
            statsLabel1.text = "\(TurnImproving.threeKindFourKind)%"
            
            maxCycle = 1
            
            if flushdraw == true
            {
                statisticsLabel2.text = "flush:"
                statsLabel2.text = "\(TurnImproving.fdFlush)%"
                
                maxCycle = 2
            }
            
            if straightdraw == true
            {
                if flushdraw == true
                {
                    statisticsLabel3.text = "straight:"
                    statsLabel3.text = "\(TurnImproving.oesdStraight)%"
                    maxCycle = 3
                }else{
                    statisticsLabel2.text = "straight:"
                    statsLabel2.text = "\(TurnImproving.oesdStraight)%"
                    maxCycle = 2
                }
            }
        }
        
        bestHand()
        self.addChild(betterHandStat)
    }
    
    func riverStatistics()      //River -> Turn
    {
        statisticsLabel1.removeFromParent()
        statisticsLabel2.removeFromParent()
        statisticsLabel3.removeFromParent()
        statisticsLabel4.removeFromParent()
        statisticsLabel5.removeFromParent()
        statsLabel1.removeFromParent()
        statsLabel2.removeFromParent()
        statsLabel3.removeFromParent()
        statsLabel4.removeFromParent()
        statsLabel5.removeFromParent()
        
        maxCycle = 0
        let rank = userBestHand(handSize: 6)
        let flushdraw = flushDraw(handSize: 6)
        let straightdraw = straightDraw(handSize: 6)
        
        if rank == 10
        {
            statisticsLabel1.text = "pair:"
            statsLabel1.text = "\(RiverImproving.upPair)%"
            maxCycle = 1
            
            if flushdraw == true
            {
                statisticsLabel2.text = "flush:"
                statsLabel2.text = "\(RiverImproving.fdFlush)%"
                maxCycle = 2
            }
            
            if straightdraw == true
            {
                if flushdraw == true
                {
                    statisticsLabel3.text = "straight:"
                    statsLabel3.text = "\(RiverImproving.oesdStraight)%"
                    maxCycle = 3
                }else{
                    statisticsLabel2.text = "straight:"
                    statsLabel2.text = "\(RiverImproving.oesdStraight)%"
                    maxCycle = 2
                }
            }
        }
        if rank == 9
        {
            statisticsLabel1.text = "three of a kind:"
            statsLabel1.text = "\(RiverImproving.pThreeKind)%"
            maxCycle = 1
            
            if flushdraw == true
            {
                statisticsLabel2.text = "flush:"
                statsLabel2.text = "\(RiverImproving.fdFlush)%"
                maxCycle = 2
            }
            
            if straightdraw == true
            {
                if flushdraw == true
                {
                    statisticsLabel3.text = "straight:"
                    statsLabel3.text = "\(RiverImproving.oesdStraight)%"
                    maxCycle = 3
                }else{
                    statisticsLabel2.text = "straight:"
                    statsLabel2.text = "\(RiverImproving.oesdStraight)%"
                    maxCycle = 2
                }
            }
        }
        if rank == 8
        {
            statisticsLabel1.text = "full house:"
            statsLabel1.text = "\(RiverImproving.tpFullHouse)%"
            maxCycle = 1
            
            if flushdraw == true
            {
                statisticsLabel2.text = "flush:"
                statsLabel2.text = "\(RiverImproving.fdFlush)%"
                maxCycle = 2
            }
            
            if straightdraw == true
            {
                if flushdraw == true
                {
                    statisticsLabel3.text = "straight:"
                    statsLabel3.text = "\(RiverImproving.oesdStraight)%"
                    maxCycle = 3
                }else{
                    statisticsLabel2.text = "straight:"
                    statsLabel2.text = "\(RiverImproving.oesdStraight)%"
                    maxCycle = 2
                }
            }
        }
        if rank == 7
        {
            statisticsLabel1.text = "four of a kind:"
            statsLabel1.text = "\(RiverImproving.threekindFourKind)%"
            maxCycle = 1
            
            if flushdraw == true
            {
                statisticsLabel2.text = "flush:"
                statsLabel2.text = "\(RiverImproving.fdFlush)%"
                maxCycle = 2
            }
            
            if straightdraw == true
            {
                if flushdraw == true
                {
                    statisticsLabel3.text = "straight:"
                    statsLabel3.text = "\(RiverImproving.oesdStraight)%"
                    maxCycle = 3
                }else{
                    statisticsLabel2.text = "straight:"
                    statsLabel2.text = "\(RiverImproving.oesdStraight)%"
                    maxCycle = 2
                }
            }
        }
        
        
        /*
         let gsdStraight = 8.7
         */
        //let rank = handRanking(handSize: 5)
        
        bestHand()
        self.addChild(betterHandStat)
    }
    
    func endOfGame()
    {
        maxCycle = 0
        userBestHand(handSize: 7)
        bestHand()
        self.addChild(betterHandStat)
    }
    
    func userBestHand(handSize: Int) -> Int
    {
        var suits = [String](); var value = [Int]()
        //Only Hand Cards
        if handSize >= 2
        {
            handCard1 = defaults.string(forKey: "Card1")!
            handCard2 = defaults.string(forKey: "Card2")!
            
            handCard1Arr = handCard1.components(separatedBy: " - ")
            handCard2Arr = handCard2.components(separatedBy: " - ")
            
            cardSuit1 = handCard1Arr[0]; cardSuit2 = handCard2Arr[0]
            suits.append(cardSuit1); suits.append(cardSuit2)
            cardVal1 = handCard1Arr[1]; cardVal2 = handCard2Arr[1]
            value.append(Int(cardVal1)!); value.append(Int(cardVal2)!)
        }
        if handSize >= 5
        {
            FLOPCARD1 = defaults.string(forKey: "Flop1")!
            FLOPCARD2 = defaults.string(forKey: "Flop2")!
            FLOPCARD3 = defaults.string(forKey: "Flop3")!
            
            flopCard1Arr = FLOPCARD1.components(separatedBy: " - ")
            flopCard2Arr = FLOPCARD2.components(separatedBy: " - ")
            flopCard3Arr = FLOPCARD3.components(separatedBy: " - ")
            
            cardSuit3 = flopCard1Arr[0]; cardSuit4 = flopCard2Arr[0]; cardSuit5 = flopCard3Arr[0]
            suits.append(cardSuit3); suits.append(cardSuit4); suits.append(cardSuit5)
            cardVal3 = flopCard1Arr[1]; cardVal4 = flopCard2Arr[1]; cardVal5 = flopCard3Arr[1]
            value.append(Int(cardVal3)!); value.append(Int(cardVal4)!); value.append(Int(cardVal5)!)
        }
        if handSize >= 6
        {
            TURNCARD = defaults.string(forKey: "Turn")!
            
            turnCardArr = TURNCARD.components(separatedBy: " - ")
            
            cardSuit6 = turnCardArr[0]
            suits.append(cardSuit6)
            cardVal6 = turnCardArr[1]
            value.append(Int(cardVal6)!)
        }
        if handSize >= 7
        {
            RIVERCARD = defaults.string(forKey: "River")!
            
            riverCardArr = RIVERCARD.components(separatedBy: " - ")
            
            cardSuit7 = riverCardArr[0]
            suits.append(cardSuit7)
            cardVal7 = riverCardArr[1]
            value.append(Int(cardVal7)!)
        }
        
        suits.sort(); value.sort(); //print(value); print(suits)
        var besthand = 10
        
        //Assign max number of suits to global variable to be used in alignemnt process
        var maxConcCount = -1; var maxSuitsIndex = -1
        for i in 0...allSuits.count-1
        {
            if allSuits[i] > maxConcCount
            {
                //print(allSuits[i])
                maxConcCount = allSuits[i]
                maxSuitsIndex = i
            }
        }
        if maxSuitsIndex == 0
        {maxSuitInHand = "Heart"}
        if maxSuitsIndex == 1
        {maxSuitInHand = "Clubs"}
        if maxSuitsIndex == 2
        {maxSuitInHand = "Diamond"}
        if maxSuitsIndex == 3
        {maxSuitInHand = "Spades"}
        //print("Max Cone of Suit: \(maxSuitInHand)")
        
        
        //Counts the amount of hearts in array [hearts, clubs, diamonds, spades]
        for i in 0...suits.count-1
        {
            //print("SUIT: \(suits[i])   MACSUIT:\(maxSuitInHand)")
            //Used to Have correlating array to access both suit and value at same index and if there are pairs, prevent issue
            if suits[i] == maxSuitInHand
            {
                //print("HERE")
                suitsOrdered[value[i]-1] = suits[i]
            }
            
            var index = -1
            if suits[i] == "Heart"
            {index = 0}
            if suits[i] == "Clubs"
            {index = 1}
            if suits[i] == "Diamond"
            {index = 2}
            if suits[i] == "Spades"
            {index = 3}
            
            let temp = allSuits[index]
            allSuits[index] = (temp + 1)
        }
        suitsOrdered[0] = suitsOrdered[13]
        
        //Places values into array in spot where val is [1-14]
        for i in 0...value.count-1
        {
            let temp = allValues[value[i]-1]
            allValues[value[i]-1] = (temp + 1)
        }
        //Code to add values of Ace as values of 1
        allValues[0] = allValues[13]
        
        
        print("All Vals: \(allValues)")
        print("All Suits: \(suitsOrdered)")
        //print(allSuits)
        
        //Amount of Pairs
        var maxKind = -1; var maxKindIndex = -1; var twoPairFrequency = 0; var threeKindFrequency = 0;
        for i in 0...allValues.count-1
        {
            if allValues[i] >= maxKind
            {
                maxKind = allValues[i]
                maxKindIndex = i
            }
            //Two Pair Searcher
            if allValues[i] == 2
            {twoPairFrequency += 1}
            
            //Three Pair Searcher
            if allValues[i] == 3
            {threeKindFrequency += 1}
        }
        //print("Two Par Freq: \(twoPairFrequency)")
        //print("ThreeKind: \(threeKindFrequency)")
        
        //Sift through Suits
        var maxNumSuits = -1
        for i in 0...allSuits.count-1
        {
            if allSuits[i] >= maxNumSuits
            {
                maxNumSuits = allSuits[i]
            }
        }
        
        //Fixes Hand
        if maxKind == 2
        {
            besthand = 9
        }
        if twoPairFrequency >= 2
        {
            besthand = 8
        }
        if maxKind == 3
        {
            besthand = 7
        }
        if isThereAStraightHere(vals: allValues) == true //-> royal straight terriroty issue
        {
            besthand = 6
        }
        if maxNumSuits >= 5
        {
            besthand = 5
        }
        if threeKindFrequency >= 1 && twoPairFrequency >= 1
        {
            besthand = 4
        }
        if maxKind == 4
        {
            besthand = 3
        }
        //Straight Flush
        if maxNumSuits >= 5
        {
            if isThereStraightFlush(vals: allValues, suits: suitsOrdered) == true
            {
                besthand = 2
            }
        }
        //Royal Flush
        if allValues[9] >= 1 && allValues[10] >= 1 && allValues[11] >= 1 && allValues[12] >= 1 && allValues[13] >= 1 && suitsOrdered[9] == maxSuitInHand && suitsOrdered[10] == maxSuitInHand && suitsOrdered[11] == maxSuitInHand && suitsOrdered[12] == maxSuitInHand && suitsOrdered[13] == maxSuitInHand
        {
            besthand = 1
        }
        
        
        print("Best Hand Rank: \(besthand)")
        defaults.set(besthand, forKey: "bestHand")
        return besthand
    }
    
    //Straight?
    func isThereAStraightHere(vals: [Int]) -> Bool
    {
        var isThereStraight = false
        //Look for Straight
        var streak = 0; var maxStreak = -1;
        for i in 0...vals.count-1
        {
            print(vals[i])
            if vals[i] > 0
            {
                streak += 1
            }else{
                if vals[i] == 0
                {
                    if maxStreak < streak
                    {
                        maxStreak = streak
                    }
                }
                streak = 0
            }
        }
        print(maxStreak)
        
        //If there five cards in a row
        if maxStreak >= 5
        {isThereStraight = true}
        
        //print("Longest Streak: \(maxStreak)")
        return isThereStraight
    }
    
    //Works needs incoming s
    func isThereStraightFlush(vals: [Int], suits: [String]) -> Bool
    {
        var isThereStraight = false
        //Look for Straight
        var streak = 0; var maxStreak = -1;
        for i in 0...vals.count-1
        {
            //print("\(suits[i]): \(vals[i])")
            if vals[i] > 0 && suits[i] == maxSuitInHand
            {
                streak += 1
            }else{
                if vals[i] == 0
                {
                    if maxStreak < streak
                    {
                        maxStreak = streak
                    }
                }
                streak = 0
            }
        }
        
        //If there five cards in a row
        if maxStreak >= 5
        {isThereStraight = true}
        
        //print("Longest Streak: \(maxStreak)")
        return isThereStraight
    }
    
    /*
    func handRanking(handSize: Int) -> Int
    {
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
        
        var value = [Int]()
        value.append(Int(valCard1)!); value.append(Int(valCard2)!); value.append(Int(valCard3)!); value.append(Int(valCard4)!); value.append(Int(valCard5)!)
        
        if handSize >= 6
        {
            let turnCard = defaults.string(forKey: "Turn")
            let turnCardArray = turnCard!.components(separatedBy: " - ")
            let suitCard6 = turnCardArray[0]
            let valCard6 = turnCardArray[1]
            suits.append(suitCard6)
            value.append(Int(valCard6)!)
        }
        
        if handSize >= 7
        {
            let riverCard = defaults.string(forKey: "River")
            let riverCardArray = riverCard!.components(separatedBy: " - ")
            let suitCard7 = riverCardArray[0]
            let valCard7 = riverCardArray[1]
            suits.append(suitCard7)
            value.append(Int(valCard7)!)
        }
        
        //Sorts the two Arrays
        var suitsPreSort = suits; var valuePreSort = value
        suits.sort(); value.sort()
        
        ///Counts Max Number of Suit Pairs
        var count = 0; var suitPairs = 0; var tempSuit = ""; var suitPairsMaxSuit = ""
        for i in 0...(handSize-1)
        {
            for j in 0...(handSize-1)
            {
                if suits[i] == suits[j]
                {
                    count += 1
                    tempSuit = suits[i]
                }
            }
            if(count > suitPairs)
            {
                suitPairs = count
                suitPairsMaxSuit = tempSuit
            }
            count = 0
            tempSuit = ""
        }
        //print(suitPairsMaxSuit)
        
        //Counts Max Number of Value Pairs
        var multPairs = [Int]()
        var pairCount = 0
        var valuePairs = 0
        for i in 0...handSize-1
        {
            for j in 0...handSize-1
            {
                if value[i] == value[j]
                {
                    pairCount += 1
                    //print("Val1: \(value[i])    Val2: \(value[j])")
                }
            }
            if(pairCount > valuePairs)
            {
                valuePairs = pairCount
            }
            if pairCount >= 2
            {
                multPairs.append(value[i])
            }
            pairCount = 0
        }
        //print("ValuePairs: \(valuePairs)")
        //print("Multiple pairs: \(multPairs.count)")
        //print(multPairs)
        
        
        var rank = 10
        var number = 10
        
        //9. One Pair
        if valuePairs == 2 && multPairs.count == 2
        {
            number = 9
            if rank > number
            {rank = number}
        }
        
        //8. Two Pair
        if valuePairs == 2 && multPairs.count >= 4
        {
            number = 8
            if rank > number
            {rank = number}
        }
        
        //7. Three Kind
        if multPairs.count == 3 && (multPairs[0] == multPairs[1]) && (multPairs[1] == multPairs[2])
        {
            number = 7
            if rank > number
            {rank = number}
        }
        
        //6. Straight
        if (isThereStraight(values: value) == true)
        {
            number = 6
            if number < rank
            {rank = number}
        }
        
        //5. Flush
        if suitPairs == 5
        {
            number = 5
            if number < rank
            {rank = number}
        }
        
        //4. FullHouse
        if (multPairs.count == 5 || multPairs.count == 7) && (multPairs[0] != multPairs[multPairs.count-1])
        {
            number = 4
            if number < rank
            {rank = number}
        }
        
        //3. Four Kind
        if valuePairs == 4
        {
            number = 3
            if number < rank
            {rank = number}
        }
        
        //2. Straight Flush
        var sfValues = [Int]()
        if suitPairs >= 5
        {
            for i in 0...handSize-1
            {
                if suitsPreSort[i] == suitPairsMaxSuit
                {
                    sfValues.append(valuePreSort[i])
                }
            }
            //sfValues
            if (isThereStraight(values: sfValues) == true)
            {
                number = 2
                if number < rank
                {rank = number}
            }
        }
        
        //1. Royal Flush
        var rfCount = 0
        if sfValues.count >= 5
        {
            for i in 0...sfValues.count-1
            {
                if(sfValues[i] >= 10)
                {
                    rfCount += 1
                }
            }
        }
        //print(rfCount)
        if rfCount == 5
        {
            rank = 1
        }
        
        return rank
    }
    
    func isThereStraight(values: [Int]) -> Bool
    {
        var vals = values
        vals.sort()
        if(vals[vals.count-1] == 14)
        {
            vals.append(1)
        }
        vals.sort()
        var count = 0
        var temp = 0
        
        for i in 1...vals.count-1
        {
            if(vals[i-1] + 1 == vals[i])
            {
                count += 1
            }else{
                if (vals[i-1] + 1 != vals[i])
                {
                    if count > temp
                    {
                        temp = count
                    }
                    count = 0
                }
            }
        }
        
        if temp >= 4
        {
            return true
        }else{
            return false
        }
    }
 */
    
    func areConnectors() -> Bool
    {
        let holeCard1 = defaults.string(forKey: "Card1")
        let holeCard2 = defaults.string(forKey: "Card2")
        
        let holeCard1Array = holeCard1!.components(separatedBy: " - ")
        let holeCard2Array = holeCard2!.components(separatedBy: " - ")
        
        let valCard1 = holeCard1Array[1]
        let valCard2 = holeCard2Array[1]
        
        
        //Suits
        
        var value = [Int]()
        value.append(Int(valCard1)!); value.append(Int(valCard2)!);
        var vals = value
        vals.sort()
        if(vals[vals.count-1] == 14)
        {
            vals.append(1)
        }
        vals.sort()
        
        if(vals[0] + 1 == vals[1])
        {
            return true
        }else{
            return false
        }
        
    }
    
    func straightDraw(handSize: Int) -> Bool
    {
        let holeCard1 = defaults.string(forKey: "Card1")
        let holeCard2 = defaults.string(forKey: "Card2")
        
        let holeCard1Array = holeCard1!.components(separatedBy: " - ")
        let holeCard2Array = holeCard2!.components(separatedBy: " - ")
        
        let valCard1 = holeCard1Array[1]
        let valCard2 = holeCard2Array[1]
        
        
        //Suits
        
        var value = [Int]()
        value.append(Int(valCard1)!); value.append(Int(valCard2)!);
        
        if handSize >= 5
        {
            let flopCard1 = defaults.string(forKey: "Flop1")
            let flopCard2 = defaults.string(forKey: "Flop2")
            let flopCard3 = defaults.string(forKey: "Flop3")
            let flopCard1Array = flopCard1!.components(separatedBy: " - ")
            let flopCard2Array = flopCard2!.components(separatedBy: " - ")
            let flopCard3Array = flopCard3!.components(separatedBy: " - ")
            let valCard3 = flopCard1Array[1]
            let valCard4 = flopCard2Array[1]
            let valCard5 = flopCard3Array[1]
            value.append(Int(valCard3)!); value.append(Int(valCard4)!); value.append(Int(valCard5)!)
        }
        
        
        if handSize >= 6
        {
            let turnCard = defaults.string(forKey: "Turn")
            let turnCardArray = turnCard!.components(separatedBy: " - ")
            let valCard6 = turnCardArray[1]
            value.append(Int(valCard6)!)
        }
        
        if handSize >= 7
        {
            let riverCard = defaults.string(forKey: "River")
            let riverCardArray = riverCard!.components(separatedBy: " - ")
            let valCard7 = riverCardArray[1]
            value.append(Int(valCard7)!)
        }
        
        
        
        var vals = value
        vals.sort()
        if(vals[vals.count-1] == 14)
        {
            vals.append(1)
        }
        vals.sort()
        
        var count = 0
        var temp = 0
        for i in 1...vals.count-1
        {
            if(vals[i-1] + 1 == vals[i])
            {
                count += 1
            }else{
                if (vals[i-1] + 1 != vals[i])
                {
                    if count > temp
                    {
                        temp = count
                    }
                    count = 0
                }
            }
        }
        
        if temp == 3
        {
            return true
            
        }else{
            return false
        }
    }
    
    
    func flushDraw(handSize: Int) -> Bool
    {
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
        
        //Suits
        var suits = [String]()
        suits.append(suitCard1); suits.append(suitCard2); suits.append(suitCard3); suits.append(suitCard4); suits.append(suitCard5)
        
        if handSize >= 6
        {
            let turnCard = defaults.string(forKey: "Turn")
            let turnCardArray = turnCard!.components(separatedBy: " - ")
            let suitCard6 = turnCardArray[0]
            suits.append(suitCard6)
        }
        
        if handSize >= 7
        {
            let riverCard = defaults.string(forKey: "River")
            let riverCardArray = riverCard!.components(separatedBy: " - ")
            let suitCard7 = riverCardArray[0]
            suits.append(suitCard7)
        }
        
        //Sorts the two Arrays
        //var suitsPreSort = suits; suits.sort()
        
        ///Counts Max Number of Suit Pairs
        var count = 0; var suitPairs = 0; var tempSuit = ""; var suitPairsMaxSuit = ""
        for i in 0...(handSize-1)
        {
            for j in 0...(handSize-1)
            {
                if suits[i] == suits[j]
                {
                    count += 1
                    tempSuit = suits[i]
                }
            }
            if(count > suitPairs)
            {
                suitPairs = count
                suitPairsMaxSuit = tempSuit
            }
            count = 0
            tempSuit = ""
        }
        
        if suitPairs == 4
        {
            return true
        }else{
            return false
        }
    }
    
    
    func bestHand()
    {
        let number = defaults.double(forKey: "bestHand")
        betterHandStat.removeFromParent()
        if  defaults.double(forKey: "numberOfPlayers") == 1.0
        {
            if(number == 1)
            {
                bestHandValue.text = "royal flush"
                betterHandStat.text = "\(betterHandOnePlayer.royalFlush)%"
            }
            if(number == 2)
            {
                bestHandValue.text = "straight flush"
                betterHandStat.text = "\(betterHandOnePlayer.straightFlush)%"
            }
            if(number == 3)
            {
                bestHandValue.text = "four of a kind"
                betterHandStat.text = "\(betterHandOnePlayer.fourKind)%"
                
            }
            if(number == 4)
            {
                bestHandValue.text = "full house"
                betterHandStat.text = "\(betterHandOnePlayer.fullHouse)%"
            }
            if(number == 5)
            {
                bestHandValue.text = "flush"
                betterHandStat.text = "\(betterHandOnePlayer.flush)%"
            }
            if(number == 6)
            {
                bestHandValue.text = "straight"
                betterHandStat.text = "\(betterHandOnePlayer.straight)%"
            }
            if(number == 7)
            {
                bestHandValue.text = "three of a kind"
                betterHandStat.text = "\(betterHandOnePlayer.threeKind)%"
            }
            if(number == 8)
            {
                bestHandValue.text = "two pair"
                betterHandStat.text = "\(betterHandOnePlayer.twoPair)%"
            }
            if(number == 9)
            {
                bestHandValue.text = "one pair"
                betterHandStat.text = "\(betterHandOnePlayer.pair)%"
            }
            if(number == 10)
            {
                bestHandValue.text = "high card"
                betterHandStat.text = "\(betterHandOnePlayer.highCard)%"
            }
        }
        
        if  defaults.double(forKey: "numberOfPlayers") == 2.0
        {
            if(number == 1)
            {
                bestHandValue.text = "royal flush"
                betterHandStat.text = "\(betterHandTwoPlayers.royalFlush)%"
            }
            if(number == 2)
            {
                bestHandValue.text = "straight flush"
                betterHandStat.text = "\(betterHandTwoPlayers.straightFlush)%"
            }
            if(number == 3)
            {
                bestHandValue.text = "four of a kind"
                betterHandStat.text = "\(betterHandTwoPlayers.fourKind)%"
            }
            if(number == 4)
            {
                bestHandValue.text = "full house"
                betterHandStat.text = "\(betterHandTwoPlayers.fullHouse)%"
            }
            if(number == 5)
            {
                bestHandValue.text = "flush"
                betterHandStat.text = "\(betterHandTwoPlayers.flush)%"
            }
            if(number == 6)
            {
                bestHandValue.text = "straight"
                betterHandStat.text = "\(betterHandTwoPlayers.straight)%"
            }
            if(number == 7)
            {
                bestHandValue.text = "three of a kind"
                betterHandStat.text = "\(betterHandTwoPlayers.threeKind)%"
            }
            if(number == 8)
            {
                bestHandValue.text = "two pair"
                betterHandStat.text = "\(betterHandTwoPlayers.twoPair)%"
            }
            if(number == 9)
            {
                bestHandValue.text = "one pair"
                betterHandStat.text = "\(betterHandTwoPlayers.pair)%"
            }
            if(number == 10)
            {
                bestHandValue.text = "high card"
                betterHandStat.text = "\(betterHandTwoPlayers.highCard)%"
            }
        }
        
        if  defaults.double(forKey: "numberOfPlayers") == 3.0
        {
            if(number == 1)
            {
                bestHandValue.text = "royal flush"
                betterHandStat.text = "\(betterHandThreePlayers.royalFlush)%"
            }
            if(number == 2)
            {
                bestHandValue.text = "straight flush"
                betterHandStat.text = "\(betterHandThreePlayers.straightFlush)%"
            }
            if(number == 3)
            {
                bestHandValue.text = "four of a kind"
                betterHandStat.text = "\(betterHandThreePlayers.fourKind)%"
            }
            if(number == 4)
            {
                bestHandValue.text = "full house"
                betterHandStat.text = "\(betterHandThreePlayers.fullHouse)%"
            }
            if(number == 5)
            {
                bestHandValue.text = "flush"
                betterHandStat.text = "\(betterHandThreePlayers.flush)%"
            }
            if(number == 6)
            {
                bestHandValue.text = "straight"
                betterHandStat.text = "\(betterHandThreePlayers.straight)%"
            }
            if(number == 7)
            {
                bestHandValue.text = "three of a kind"
                betterHandStat.text = "\(betterHandThreePlayers.threeKind)%"
            }
            if(number == 8)
            {
                bestHandValue.text = "two pair"
                betterHandStat.text = "\(betterHandThreePlayers.twoPair)%"
            }
            if(number == 9)
            {
                bestHandValue.text = "one pair"
                betterHandStat.text = "\(betterHandThreePlayers.pair)%"
            }
            if(number == 10)
            {
                bestHandValue.text = "high card"
                betterHandStat.text = "\(betterHandThreePlayers.highCard)%"
            }
        }
        
        if  defaults.double(forKey: "numberOfPlayers") == 4.0
        {
            if(number == 1)
            {
                bestHandValue.text = "royal flush"
                betterHandStat.text = "\(betterHandFourPlayers.royalFlush)%"
            }
            if(number == 2)
            {
                bestHandValue.text = "straight flush"
                betterHandStat.text = "\(betterHandFourPlayers.straightFlush)%"
            }
            if(number == 3)
            {
                bestHandValue.text = "four of a kind"
                betterHandStat.text = "\(betterHandFourPlayers.fourKind)%"
            }
            if(number == 4)
            {
                bestHandValue.text = "full house"
                betterHandStat.text = "\(betterHandFourPlayers.fullHouse)%"
            }
            if(number == 5)
            {
                bestHandValue.text = "flush"
                betterHandStat.text = "\(betterHandFourPlayers.flush)%"
            }
            if(number == 6)
            {
                bestHandValue.text = "straight"
                betterHandStat.text = "\(betterHandFourPlayers.straight)%"
            }
            if(number == 7)
            {
                bestHandValue.text = "three of a kind"
                betterHandStat.text = "\(betterHandFourPlayers.threeKind)%"
            }
            if(number == 8)
            {
                bestHandValue.text = "two pair"
                betterHandStat.text = "\(betterHandFourPlayers.twoPair)%"
            }
            if(number == 9)
            {
                bestHandValue.text = "one pair"
                betterHandStat.text = "\(betterHandFourPlayers.pair)%"
            }
            if(number == 10)
            {
                bestHandValue.text = "high card"
                betterHandStat.text = "\(betterHandThreePlayers.highCard)%"
            }
        }
        
        if  defaults.double(forKey: "numberOfPlayers") == 5.0
        {
            if(number == 1)
            {
                bestHandValue.text = "royal flush"
                betterHandStat.text = "\(betterHandFivePlayers.royalFlush)%"
            }
            if(number == 2)
            {
                bestHandValue.text = "straight flush"
                betterHandStat.text = "\(betterHandFivePlayers.straightFlush)%"
            }
            if(number == 3)
            {
                bestHandValue.text = "four of a kind"
                betterHandStat.text = "\(betterHandFivePlayers.fourKind)%"
            }
            if(number == 4)
            {
                bestHandValue.text = "full house"
                betterHandStat.text = "\(betterHandFivePlayers.fullHouse)%"
            }
            if(number == 5)
            {
                bestHandValue.text = "flush"
                betterHandStat.text = "\(betterHandFivePlayers.flush)%"
            }
            if(number == 6)
            {
                bestHandValue.text = "straight"
                betterHandStat.text = "\(betterHandFivePlayers.straight)%"
            }
            if(number == 7)
            {
                bestHandValue.text = "three of a kind"
                betterHandStat.text = "\(betterHandFivePlayers.threeKind)%"
            }
            if(number == 8)
            {
                bestHandValue.text = "two pair"
                betterHandStat.text = "\(betterHandFivePlayers.twoPair)%"
            }
            if(number == 9)
            {
                bestHandValue.text = "one pair"
                betterHandStat.text = "\(betterHandFivePlayers.pair)%"
            }
            if(number == 10)
            {
                bestHandValue.text = "high card"
                betterHandStat.text = "\(betterHandFivePlayers.highCard)%"
            }
        }
        
        if  defaults.double(forKey: "numberOfPlayers") == 6.0
        {
            if(number == 1)
            {
                bestHandValue.text = "royal flush"
                betterHandStat.text = "\(betterHandSixPlayers.royalFlush)%"
            }
            if(number == 2)
            {
                bestHandValue.text = "straight flush"
                betterHandStat.text = "\(betterHandSixPlayers.straightFlush)%"
            }
            if(number == 3)
            {
                bestHandValue.text = "four of a kind"
                betterHandStat.text = "\(betterHandSixPlayers.fourKind)%"
            }
            if(number == 4)
            {
                bestHandValue.text = "full house"
                betterHandStat.text = "\(betterHandSixPlayers.fullHouse)%"
            }
            if(number == 5)
            {
                bestHandValue.text = "flush"
                betterHandStat.text = "\(betterHandSixPlayers.flush)%"
            }
            if(number == 6)
            {
                bestHandValue.text = "straight"
                betterHandStat.text = "\(betterHandSixPlayers.straight)%"
            }
            if(number == 7)
            {
                bestHandValue.text = "three of a kind"
                betterHandStat.text = "\(betterHandSixPlayers.threeKind)%"
            }
            if(number == 8)
            {
                bestHandValue.text = "two pair"
                betterHandStat.text = "\(betterHandSixPlayers.twoPair)%"
            }
            if(number == 9)
            {
                bestHandValue.text = "one pair"
                betterHandStat.text = "\(betterHandSixPlayers.pair)%"
            }
            if(number == 10)
            {
                bestHandValue.text = "high card"
                betterHandStat.text = "\(betterHandSixPlayers.highCard)%"
            }
        }
        
        betterHandStat.removeFromParent()
        bestHandValue.removeFromParent()
        //self.addChild(betterHandStat)
        self.addChild(bestHandValue)
    }
    
    
    
    
    func randAvailCard() -> String
    {
        var unavailCards = [String]()
        
        unavailCards.append(defaults.string(forKey: "Card1")!); unavailCards.append(defaults.string(forKey: "Card2")!)
        
        if defaults.string(forKey: "Flop1") != "None"
        {
            unavailCards.append(defaults.string(forKey: "Flop1")!)
        }
        
        if defaults.string(forKey: "Flop2") != "None"
        {
            unavailCards.append(defaults.string(forKey: "Flop2")!)
        }
        
        if defaults.string(forKey: "Flop3") != "None"
        {
            unavailCards.append(defaults.string(forKey: "Flop3")!)
        }
        
        if defaults.string(forKey: "Turn") != "None"
        {
            unavailCards.append(defaults.string(forKey: "Turn")!)
        }
        
        
        var cards = allCardsArray()
        var adjustCount = 0
        for i in 0...cards.count-1
        {
            for j in 0...unavailCards.count-1
            {
                if(unavailCards[j] == cards[i])
                {
                    cards.remove(at: i)
                    cards.append("")
                    adjustCount += 1
                }
            }
        }
        
        let randomCars = cards[Int.random(in:0 ..< cards.count-1-adjustCount)]
        
        return randomCars
    }
    
    
    func allCardsArray() -> [String]
    {
        var cards = [String]()
        cards.append("Heart - 2"); cards.append("Heart - 3"); cards.append("Heart - 4"); cards.append("Heart - 5"); cards.append("Heart - 6"); cards.append("Heart - 7"); cards.append("Heart - 8"); cards.append("Heart - 9"); cards.append("Heart - 10"); cards.append("Heart - 11"); cards.append("Heart - 12"); cards.append("Heart - 13"); cards.append("Heart - 14");
        cards.append("Diamond - 2"); cards.append("Diamond - 3"); cards.append("Diamond - 4"); cards.append("Diamond - 5"); cards.append("Diamond - 6"); cards.append("Diamond - 7"); cards.append("Diamond - 8"); cards.append("Diamond - 9"); cards.append("Diamond - 10"); cards.append("Diamond - 11"); cards.append("Diamond - 12"); cards.append("Diamond - 13"); cards.append("Diamond - 14");
        cards.append("Spades - 2"); cards.append("Spades - 3"); cards.append("Spades - 4"); cards.append("Spades - 5"); cards.append("Spades - 6"); cards.append("Spades - 7"); cards.append("Spades - 8"); cards.append("Spades - 9"); cards.append("Spades - 10"); cards.append("Spades - 11"); cards.append("Spades - 12"); cards.append("Spades - 13"); cards.append("Spades - 14");
        cards.append("Clubs - 2"); cards.append("Clubs - 3"); cards.append("Clubs - 4"); cards.append("Clubs - 5"); cards.append("Clubs - 6"); cards.append("Clubs - 7"); cards.append("Clubs - 8"); cards.append("Clubs - 9"); cards.append("Clubs - 10"); cards.append("Clubs - 11"); cards.append("Clubs - 12"); cards.append("Clubs - 13"); cards.append("Clubs - 14");
        return cards
    }
    
    
    func moveToGameSceneFlop()
    {
        fadeOut(exitNumber: 0)
    }
    func moveToGameSceneTurn()
    {
        fadeOut(exitNumber: 1)
    }
    func moveToGameSceneRiver()
    {
        fadeOut(exitNumber: 2)
    }
    
    func fadeIn()
    {
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        let fadeInOverlay = SKAction.fadeAlpha(by: 0.5, duration: 0.5)
        
        Settings.run(fadeIn);
        bestHandBackdrop.run(fadeIn); besthandLabel.run(fadeIn); bestHandValue.run(fadeIn); betterHandLabel.run(fadeIn); betterHandLabel2.run(fadeIn); betterHandStat.run(fadeIn)
        statisticsBackdrop.run(fadeIn); statsLabel.run(fadeIn); sLabel.run(fadeIn)
        card1.run(fadeIn); card2.run(fadeIn); burnPile.run(fadeIn); stack.run(fadeIn)
        
        burnCard1.run(fadeIn); burnCard2.run(fadeIn); burnCard3.run(fadeIn); turnCard.run(fadeIn); riverCard.run(fadeIn)
        flopOneCard.run(fadeIn); flopTwoCard.run(fadeIn); flopThreeCard.run(fadeIn)
        
        flopGuide.run(fadeInOverlay); turnGuide.run(fadeInOverlay); riverGuide.run(fadeInOverlay)
    }
    
    func fadeOut(exitNumber: Int)
    {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let fadeOutOverlay = SKAction.fadeAlpha(by: -0.5, duration: 0.5)
        Directions.run(fadeOut)
        
        Settings.run(fadeOut);
        bestHandBackdrop.run(fadeOut); besthandLabel.run(fadeOut); bestHandValue.run(fadeOut); betterHandLabel.run(fadeOut); betterHandLabel2.run(fadeOut); betterHandStat.run(fadeOut)
        statisticsBackdrop.run(fadeOut); statsLabel.run(fadeOut); sLabel.run(fadeOut)
        card1.run(fadeOut); card2.run(fadeOut); burnPile.run(fadeOut); stack.run(fadeOut)
        
        burnCard1.run(fadeOut); burnCard2.run(fadeOut); burnCard3.run(fadeOut); turnCard.run(fadeOut); riverCard.run(fadeOut)
        flopOneCard.run(fadeOut); flopTwoCard.run(fadeOut); flopThreeCard.run(fadeOut)
        
        flopGuide.run(fadeOutOverlay); turnGuide.run(fadeOutOverlay); riverGuide.run(fadeOutOverlay)
        
        if exitNumber == 0
        {
            sceneToMoveTo = GameSceneFlop(size: self.size)
        }
        if exitNumber == 1
        {
            sceneToMoveTo = GameSceneTurn(size: self.size)
        }
        if exitNumber == 2
        {
            sceneToMoveTo = GameSceneRiver(size: self.size)
        }
        if exitNumber == 3
        {
            sceneToMoveTo = GameScene(size: self.size)
        }
        if exitNumber == 4
        {
            sceneToMoveTo = startScreen(size: self.size)
        }
        
        let seq = SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run(exitScene)])
        self.run(seq)
    }
    
    func exitScene()
    {
        sceneToMoveTo.scaleMode = self.scaleMode
        let myTransition = SKTransition.fade(withDuration:  0.0)
        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
    }
}
