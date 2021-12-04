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
        addButtons()
        
       
    }
    
    
    func addButtons()
    {
        let playButton: CSKButton = {
            let button = CSKButton(fileName: "ballYellow", buttonAction:
            {
                GameManager.shared.transition(self, toScene: .map, transitionType: SKTransition.moveIn(with: .down, duration: 2))
            })
            
            return button
        }()
        
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        playButton.position = CGPoint.zero
        
        addChild(playButton)
    }
    
}
