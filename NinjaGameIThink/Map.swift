//
//  Map.swift
//  GoldSweeper
//
//  Created by COX, LUKE (Student) on 03/12/2021.
//  Copyright © 2021 COX, LUKE (Student). All rights reserved.
//

import SpriteKit
import Foundation
import CoreGraphics


class MapScene: SKScene
{
    let backgroundMap = SKSpriteNode(imageNamed: "Map1")
    var distanceToTressureToFind = CGFloat(200)
    
    
    var ShovelLable = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    var ShovelCount = 4 {
        didSet {
            ShovelLable.text  = "Number Of Shovels: \(ShovelCount)"
        }
    }
    
    var gameOverLable = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")

    var randomPoint = CGPoint(x: 0, y: 0)
    
    
    
    override func didMove(to view: SKView) {
        
        ShovelCount = GameManager.shared.curruntShovels
        
        switch GameManager.shared.difficulty
        {
        case .easy:
            distanceToTressureToFind = ScreenSize.diagonalLength * 0.14
            break
        case .medium:
            distanceToTressureToFind = ScreenSize.diagonalLength * 0.07
            break
        case.hard:
            distanceToTressureToFind = ScreenSize.diagonalLength * 0.035
            break
        }
        
        for hole in GameManager.shared.arrayOfHoles
        {
            addChild(hole)
        }
        
        backgroundMap.position = CGPoint(x: ScreenSize.width / 2 - 20, y: ScreenSize.height / 2)
        
        backgroundMap.scale(to: CGSize(width: ScreenSize.height, height: ScreenSize.height))
        backgroundMap.alpha = 0.5
        backgroundMap.zPosition = -1
        addChild(backgroundMap)
        
        ShovelLable.fontSize = frame.width / 15
        ShovelLable.position = CGPoint(x: frame.width / 2, y: 20)
        addChild(ShovelLable)
        
        gameOverLable.fontSize = frame.width / 5
        gameOverLable.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        gameOverLable.fontSize = 64
        addChild(gameOverLable)
        
        
        if(!GameManager.shared.gameStarted)
        {
            randomPoint = newRandomPoint()
            GameManager.shared.gameStarted = true
            GameManager.shared.setGoldPoint(randomPoint)
        }
        else
        {
            randomPoint = GameManager.shared.getGoldPoint()
        }
        
        let shape = SKShapeNode(rect: CGRect(x: randomPoint.x, y: randomPoint.y, width: 20, height: 20))
        shape.fillColor = .yellow
        
        //addChild(shape)
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPos = touches.first?.location(in: self) else {return}
        
        //Converting the place where the player touched into a texture so I can grab the raw color data
        let tex = view?.texture(from: backgroundMap, crop: CGRect(x: touchPos.x, y: touchPos.y, width: 1, height: 1))
        let image = tex?.cgImage()
        let rawData = image?.dataProvider?.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(rawData)
        
        let g = CGFloat(data[1])
        let b = CGFloat(data[2])
        
        
        //print(b + g)
        //Getting the distence from the point touched and the gold
        let dist = (touchPos.x - randomPoint.x) * (touchPos.x - randomPoint.x) + (touchPos.y - randomPoint.y) * (touchPos.y - randomPoint.y)
        
        //If the below statement is true the player tapped on something green and it means theyre searching for treasure
        if(g > b + 20)
        {
            //This tests weather the treasure is close enough to find
            if(dist < distanceToTressureToFind * distanceToTressureToFind)
            {
                gameOverLable.text = "YOU WIN !"
                
                var scoreGainedFromThisWin = Int(0)
                
                //Adding score after a win based on difficulty and number of shovels remaining
                switch GameManager.shared.difficulty
                {
                case .easy:
                    scoreGainedFromThisWin = 101
                    break
                case .medium:
                    scoreGainedFromThisWin = 404
                    break
                case.hard:
                    scoreGainedFromThisWin = 1616
                    break
                }
                
                scoreGainedFromThisWin = scoreGainedFromThisWin * ShovelCount
                
                let currentScore = GameManager.shared.getScore()
                UserDefaults.standard.set(currentScore + scoreGainedFromThisWin, forKey: "Score")
                UserDefaults.standard.synchronize()
                
                //Game over code including transition to main menu
                endOfGameAdmin()
                GameManager.shared.transition(self, toScene: .MainMenu, transitionType: SKTransition.moveIn(with: .up, duration: 3))
            }
            else
            {
                //Didnt find it so you loose a shovel
                ShovelCount = ShovelCount - 1
                let hole = SKShapeNode(circleOfRadius: distanceToTressureToFind)
                hole.fillColor = .brown
                hole.strokeColor = .brown
                hole.position = touchPos
                addChild(hole)
                GameManager.shared.arrayOfHoles.append(hole)
            }
        }
        else
        {
            //This transitions to the sifting game section as you tapped on blue
            GameManager.shared.curruntShovels = ShovelCount
            GameManager.shared.setDistanceToSource(dist: dist.squareRoot())
            GameManager.shared.transition(self, toScene: .game, transitionType: SKTransition.moveIn(with: .right, duration: 0.2))
        }
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if(ShovelCount <= 0)
        {
            gameOverLable.text = "You loose !"
            endOfGameAdmin()
            GameManager.shared.transition(self, toScene: .MainMenu, transitionType: SKTransition.moveIn(with: .up, duration: 3))
        }
    }
    
    
    func newRandomPoint() -> CGPoint
    {
        var notFound =  true
        var newRandomPoint = CGPoint(x: 0, y: 0)
        while notFound {
            newRandomPoint = CGPoint(x:  CGFloat.random(in: 0...ScreenSize.width) , y: CGFloat.random(in: 0...ScreenSize.height))
            let tex = view?.texture(from: backgroundMap, crop: CGRect(x: newRandomPoint.x, y: newRandomPoint.y, width: 1, height: 1))
            let image = tex?.cgImage()
            let rawData = image?.dataProvider?.data
            let data: UnsafePointer<UInt8> = CFDataGetBytePtr(rawData)
            
            let g = CGFloat(data[1])
            let b = CGFloat(data[2])
            
            if(g > b + 20)
            {
                notFound = false
            }
            else
            {
                notFound = true
            }
            
        }
        return newRandomPoint
    }
    
    func endOfGameAdmin()
    {
        GameManager.shared.gameStarted = false
        GameManager.shared.curruntShovels = 4
        GameManager.shared.arrayOfHoles.removeAll()
    }
}
