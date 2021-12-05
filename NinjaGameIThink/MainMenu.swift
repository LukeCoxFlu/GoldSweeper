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
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(imageNamed: "THEWATER")
        background.position = CGPoint(x: 0, y: 0)
        background.scale(to: CGSize(width: ScreenSize.height, height: ScreenSize.height))
        background.alpha = 0.5
        background.zPosition = -1
        addChild(background)
        addButtons()
        
        let title = SKLabelNode(fontNamed: UIFont.boldSystemFont(ofSize: 16).fontName)
        title.text = "GoldSweeper"
        title.position = CGPoint(x: 0, y: 150)
        addChild(title)
        
        
    }
    
    
    func addButtons()
    {
        let playButton: CSKButton = {
            let button = CSKButton(fileName: "Button", buttonAction:
            {
                GameManager.shared.transition(self, toScene: .map, transitionType: SKTransition.moveIn(with: .down, duration: 2))
            })
            
            return button
        }()
        
        playButton.position = CGPoint(x: 0, y: -150)
        playButton.initText(fontNamed: UIFont.boldSystemFont(ofSize: 16).fontName, buttonText: "Start")
        
        
        addChild(playButton)
    }
    
}
