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
    let difficultyLable = SKLabelNode(fontNamed: UIFont.italicSystemFont(ofSize: 16).fontName)
    
    override func didMove(to view: SKView) {
        
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(imageNamed: "THEWATER")
        background.position = CGPoint(x: 0, y: 0)
        background.scale(to: CGSize(width: ScreenSize.height, height: ScreenSize.height))
        background.alpha = 0.5
        background.zPosition = -1
        addChild(background)
        
        
        switch GameManager.shared.difficulty
        {
        case .easy:
            difficultyLable.text = "Difficulty: Easy"
            break
        case .medium:
            difficultyLable.text = "Difficulty: Medium"
            break
        case.hard:
            difficultyLable.text = "Difficulty: Hard"
            break
        }
        difficultyLable.position = CGPoint(x: 0, y: -325)
        addChild(difficultyLable)
        
        
        addButtons()
        
        let title = SKLabelNode(fontNamed: UIFont.boldSystemFont(ofSize: 16).fontName)
        title.text = "GoldSweeper"
        title.position = CGPoint(x: 0, y: 300)
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
        
        
        playButton.position = CGPoint(x: 0, y: -200)
        playButton.linearScale(frame.width * 0.6)
        playButton.initText(fontNamed: UIFont.boldSystemFont(ofSize: 32).fontName, buttonText: "Start")
        
        
        addChild(playButton)
        
        let easyButton: CSKButton = {
            let button = CSKButton(fileName: "Button", buttonAction:
            {
                GameManager.shared.difficulty = .easy
                self.difficultyLable.text = "Difficulty: Easy"
            })
            
            return button
        }()
        
        easyButton.position = CGPoint(x: -200, y: -400)
        easyButton.linearScale(frame.width * 0.2)
        easyButton.initText(fontNamed: UIFont.boldSystemFont(ofSize: 10).fontName, buttonText: "Easy")
        
        addChild(easyButton)
        
        let mediumButton: CSKButton = {
            let button = CSKButton(fileName: "Button", buttonAction:
            {
                GameManager.shared.difficulty = .medium
                self.difficultyLable.text = "Difficulty: Medium"
            })
            
            return button
        }()
        
        mediumButton.position = CGPoint(x: 0, y: -400)
        mediumButton.linearScale(frame.width * 0.2)
        mediumButton.initText(fontNamed: UIFont.boldSystemFont(ofSize: 8).fontName, buttonText: "Medium")
        
        addChild(mediumButton)
        
        let hardButton: CSKButton = {
            let button = CSKButton(fileName: "Button", buttonAction:
            {
                GameManager.shared.difficulty = .hard
                self.difficultyLable.text = "Difficulty: Hard"
            })
            
            return button
        }()
        
        hardButton.position = CGPoint(x: 200, y: -400)
        hardButton.linearScale(frame.width * 0.2)
        hardButton.initText(fontNamed: UIFont.boldSystemFont(ofSize: 8).fontName, buttonText: "Hard")
        
        addChild(hardButton)
        
    }
}
