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
    let distanceToTressureToFind = CGFloat(200)
    
    
    var ShovelLable = SKLabelNode(fontNamed: "HelveticaNeue-Thin")
    var ShovelCount = 4 {
        didSet {
            ShovelLable.text  = "Number Of Shovels: \(ShovelCount)"
        }
    }

    //let randomPoint = CGPoint(x:  CGFloat.random(in: 0...ScreenSize.width / 2) , y: CGFloat.random(in: 0...ScreenSize.height))
    var randomPoint = CGPoint(x: 0, y: 0)
    
    
    
    override func didMove(to view: SKView) {
        backgroundMap.position = CGPoint(x: ScreenSize.width / 2 - 20, y: ScreenSize.height / 2)
        
        backgroundMap.scale(to: CGSize(width: ScreenSize.height, height: ScreenSize.height))
        backgroundMap.alpha = 0.5
        backgroundMap.zPosition = -1
        addChild(backgroundMap)
        
        ShovelLable.text = "Number Of Shovels: 4"
        ShovelLable.fontSize = frame.width / 15
        ShovelLable.position = CGPoint(x: frame.width / 2, y: 20)
        
        addChild(ShovelLable)
        
        
        randomPoint = newRandomPoint()
        
        let node = SKShapeNode(rect: CGRect(x: randomPoint.x, y: randomPoint.y, width: 10, height: 10))
        node.fillColor = .cyan
        addChild(node)
        
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPos = touches.first?.location(in: self) else {return}
        
        let tex = view?.texture(from: backgroundMap, crop: CGRect(x: touchPos.x, y: touchPos.y, width: 1, height: 1))
        let image = tex?.cgImage()
        let rawData = image?.dataProvider?.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(rawData)
        
        let g = CGFloat(data[1])
        let b = CGFloat(data[2])
        
        let dist = (touchPos.x - randomPoint.x) * (touchPos.x - randomPoint.x) + (touchPos.y - randomPoint.y) * (touchPos.y - randomPoint.y)
        if(g > b + 20)
        {
            ShovelCount = ShovelCount - 1
            
            if(dist < distanceToTressureToFind * distanceToTressureToFind)
            {
                print("YOU WIN")
            }
        }
        else
        {
            GameManager.shared.setDistanceToSource(dist: dist.squareRoot())
            GameManager.shared.transition(self, toScene: .game, transitionType: SKTransition.moveIn(with: .down, duration: 2))
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
}
