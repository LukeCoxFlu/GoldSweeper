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
    let background = SKSpriteNode(imageNamed: "Map1")
    
    var ShovelLable = SKLabelNode(fontNamed: "HelveticaNeue-Thin")
    var ShovelCount = 4 {
        didSet {
            ShovelLable.text  = "Number Of Shovels: \(ShovelCount)"
        }
    }
    
    let randomPoint = CGPoint(x:  CGFloat.random(in: 0...ScreenSize.width / 2) , y: CGFloat.random(in: 0...ScreenSize.height))
    
    
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: ScreenSize.width / 2 - 20, y: ScreenSize.height / 2)
        
        background.scale(to: CGSize(width: ScreenSize.height, height: ScreenSize.height))
        background.alpha = 0.5
        background.zPosition = -1
        addChild(background)
        
        ShovelLable.text = "Number Of Shovels: 4"
        ShovelLable.fontSize = frame.width / 15
        ShovelLable.position = CGPoint(x: 110, y: 20)
        
        addChild(ShovelLable)
        
        print(randomPoint)
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPos = touches.first?.location(in: self) else {return}
        
        let tex = view?.texture(from: background, crop: CGRect(x: touchPos.x, y: touchPos.y, width: 1, height: 1))
        let image = tex?.cgImage()
        let rawData = image?.dataProvider?.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(rawData)
        
        let g = CGFloat(data[1])
        let b = CGFloat(data[2])
        
        if(g > b + 20)
        {
            ShovelCount = ShovelCount - 1
        }
        else
        {
            GameManager.shared.transition(self, toScene: .game, transitionType: SKTransition.moveIn(with: .down, duration: 2))
            
        }
        
        
    }
}
