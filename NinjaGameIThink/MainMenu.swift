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
    let sideBar = CSKSideBar(isLeftHanded: false, sideBarWidth: 300, backgroundColor: .lightGray)
    
    override func didMove(to view: SKView) {
        
        setupGestures()
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
        
        
        let title = SKSpriteNode(imageNamed: "Title")
        title.name = "Title"
        title.position = CGPoint(x: 0, y: 300)
        addChild(title)
        
        let score = SKLabelNode(fontNamed: UIFont.boldSystemFont(ofSize: 32).fontName)
        score.text = "SCORE: \(GameManager.shared.getScore())"
        score.position = CGPoint(x: 0, y: 200)
        addChild(score)
        
        
        addSideBarNodes()
        addChild(sideBar)
    
        
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
    
    func addSideBarNodes()
    {
        let SettingsLable = SKLabelNode(fontNamed: UIFont.boldSystemFont(ofSize: 12).fontName)
        SettingsLable.text = "SETTINGS: "
        sideBar.addNode(SettingsLable, yPositionOutFromMinus1to1: 0.8)
        
        let HomeButton: CSKButton = {
            let button = CSKButton(fileName: "Button", buttonAction:
            {
                if(!(self.classForCoder == MainMenu.classForCoder()))
                {
                    GameManager.shared.transition(self, toScene: .MainMenu, transitionType: SKTransition.moveIn(with: .up, duration: 3))
                }
            })
            return button
        }()
        HomeButton.initText(fontNamed: UIFont.boldSystemFont(ofSize: 8).fontName, buttonText: "HOME")
        
        HomeButton.linearScale(250)
        sideBar.addNode(HomeButton, yPositionOutFromMinus1to1: 0)
        
        
        let TutorialButton: CSKButton = {
            let button = CSKButton(fileName: "Button", buttonAction:
            {
                print("Nothing Yet")
            })
            return button
        }()
        TutorialButton.initText(fontNamed: UIFont.boldSystemFont(ofSize: 8).fontName, buttonText: "TUTORIAL")
        
        TutorialButton.linearScale(250)
        
        sideBar.addNode(TutorialButton, yPositionOutFromMinus1to1: 0.2)
    }
    
    
    func setupGestures() {

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(MainMenu.handleGesture(_:)))
        swipeRight.direction = .right
        view?.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(MainMenu.handleGesture(_:)))
        swipeLeft.direction = .left
        view?.addGestureRecognizer(swipeLeft)

       }
    
    @objc func handleGesture(_ sender: UISwipeGestureRecognizer)
    {
        switch sender.direction {
        case UISwipeGestureRecognizer.Direction.left:
            if(!sideBar.IsEnabled) {sideBar.enable()}
            break
        case UISwipeGestureRecognizer.Direction.right:
            if(sideBar.IsEnabled) {sideBar.disable()}
            break
        default:
            print("NO NO ")
            break
        }
    }
}
