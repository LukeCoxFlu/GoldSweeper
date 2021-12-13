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
    let difficultyLable = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    let sideBar = CSKSideBar(isLeftHanded: false, sideBarWidth: 300, backgroundColor: .lightGray)
    
    override func didMove(to view: SKView) {
        
        setupGestures()
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        //Background
        let background = SKSpriteNode(imageNamed: "THEWATER")
        background.position = CGPoint(x: 0, y: 0)
        background.scale(to: CGSize(width: ScreenSize.height, height: ScreenSize.height))
        background.alpha = 0.5
        background.zPosition = -1
        addChild(background)
        
        //Arrow to indicate that you should use a gesture
        let arrow = SKSpriteNode(imageNamed: "arrow")
        arrow.position = CGPoint(x: ScreenSize.width * 0.4, y: 0)
        arrow.alpha = 0.5
        addChild(arrow)
        
        //difficulty gotten from the Game manager and assigned to the difficulty lable to make it obvious to the play what difficulty theyre about to play on
        difficultyLable.fontSize = 32
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
        difficultyLable.position = CGPoint(x: 0, y: ScreenSize.height * -0.3)
        addChild(difficultyLable)
        
        // Adding buttons, too cumbersome to put in the main "Did move"
        addButtons()
        
        // Title and score lable all the nodes in this project are based on the screen size so its compatable with multiple devices
        let title = SKSpriteNode(imageNamed: "Title")
        title.name = "Title"
        title.size = CGSize(width: ScreenSize.width * 0.9, height: ScreenSize.width / 8.57 * 0.9)
        title.position = CGPoint(x: 0, y: 300)
        addChild(title)
        
        let score = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
        score.fontSize = 32
        score.text = "SCORE: \(GameManager.shared.getScore())"
        score.position = CGPoint(x: 0, y: ScreenSize.height * 0.2)
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
        
        
        playButton.position = CGPoint(x: 0, y: ScreenSize.height * -0.15)
        playButton.linearScale(frame.width * 0.6)
        playButton.initText(fontNamed: "AmericanTypewriter-Bold", buttonText: "Start", fontSize: 32)
        
        
        addChild(playButton)
        
        let easyButton: CSKButton = {
            let button = CSKButton(fileName: "Button", buttonAction:
            {
                GameManager.shared.difficulty = .easy
                self.difficultyLable.text = "Difficulty: Easy"
            })
            
            return button
        }()
        
        easyButton.position = CGPoint(x: -(ScreenSize.width/4), y: -(ScreenSize.height / 2.7))
        easyButton.linearScale(frame.width * 0.2)
        easyButton.initText(fontNamed: "AmericanTypewriter-Bold", buttonText: "Easy", fontSize: 16)
        
        addChild(easyButton)
        
        let mediumButton: CSKButton = {
            let button = CSKButton(fileName: "Button", buttonAction:
            {
                GameManager.shared.difficulty = .medium
                self.difficultyLable.text = "Difficulty: Medium"
            })
            
            return button
        }()
        
        mediumButton.position = CGPoint(x: 0, y: -(ScreenSize.height / 2.7))
        mediumButton.linearScale(frame.width * 0.2)
        mediumButton.initText(fontNamed: "AmericanTypewriter-Bold", buttonText: "Medium", fontSize: 16)
        
        addChild(mediumButton)
        
        let hardButton: CSKButton = {
            let button = CSKButton(fileName: "Button", buttonAction:
            {
                GameManager.shared.difficulty = .hard
                self.difficultyLable.text = "Difficulty: Hard"
            })
            
            return button
        }()
        hardButton.position = CGPoint(x: ScreenSize.width/4, y: -(ScreenSize.height / 2.7))
        hardButton.linearScale(frame.width * 0.2)
        hardButton.initText(fontNamed: "AmericanTypewriter-Bold", buttonText: "Hard", fontSize: 16)
        
        addChild(hardButton)
        
    }
    
    func addSideBarNodes()
    {
        //adding the side bar text and adding buttons to the side bar
        let SettingsLable = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
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
        HomeButton.initText(fontNamed: "AmericanTypewriter-Bold", buttonText: "Home", fontSize: 16)
        
        HomeButton.linearScale(250)
        sideBar.addNode(HomeButton, yPositionOutFromMinus1to1: 0)
        
        
        let TutorialButton: CSKButton = {
            let button = CSKButton(fileName: "Button", buttonAction:
            {
                print("Nothing Yet")
            })
            return button
        }()
        TutorialButton.initText(fontNamed: "AmericanTypewriter-Bold", buttonText: "Tutorial", fontSize: 16)
        
        TutorialButton.linearScale(250)
        
        sideBar.addNode(TutorialButton, yPositionOutFromMinus1to1: 0.4)
    }
    
    //Standard gesture setup
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
            //Turning off and on the side bar based on gesture
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
