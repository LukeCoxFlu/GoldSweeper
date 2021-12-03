//
//  MainMenu.swift
//  GoldSweeper
//
//  Created by COX, LUKE (Student) on 03/12/2021.
//  Copyright © 2021 COX, LUKE (Student). All rights reserved.
//

import SpriteKit
import GameplayKit



class MainMenu: SKScene
{
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "checkerboard")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.alpha = 0.5
        background.zPosition = -1
        addChild(background)
        
        let button = SKShapeNode(rect: CGRect(x: 0, y: 0, width: frame.width * 0.8, height: frame.height * 0.1))
        button.position = CGPoint(x: 20, y: 20)
        button.fillColor = .label
        addChild(button)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        //GameManager.shared.transition(self, toScene: .game)
        GameManager.shared.transition(self, toScene: .game, transitionType: SKTransition.moveIn(with: .down, duration: 2))
                
   
    }
}
