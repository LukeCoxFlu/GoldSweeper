//
//  tutorialScene.swift
//  GoldSweeper
//
//  Created by COX, LUKE (Student) on 15/12/2021.
//  Copyright © 2021 COX, LUKE (Student). All rights reserved.
//

import Foundation
import SpriteKit

class tutorialScene: GameScene {
    let background = SKSpriteNode(imageNamed: "THEWATER")
    let textLable = SKLabelNode(fontNamed: "AmericanTypewriter")
    var textArray: Array<String> = [String]()
    var currentTextIndex = 0 {
        didSet {
            if(!(currentTextIndex + 1 > textArray.count))
            {
                textLable.text = textArray[currentTextIndex]
            }
            else
            {
                textLable.fontSize = ScreenSize.width / 20
                textLable.text = "You're Ready To Play"
                GameManager.shared.transition(self, toScene: .MainMenu, transitionType: SKTransition.push(with: .right, duration: 3))
            }
        }
    }
    
    override func didMove(to view: SKView) {
        background.size = CGSize(width: ScreenSize.height, height: ScreenSize.height)
        background.position = CGPoint(x: ScreenSize.width / 2, y: ScreenSize.height/2)
        background.zPosition = -1
        background.alpha = 0.5
        addChild(background)
        
        //SHADER INIT
        let uniform: [SKUniform] =
        [
            SKUniform(name: "u_speed", float: 2),
            SKUniform(name: "u_strength", float: 3),
            SKUniform(name: "u_frequency", float: 10)
        ]
        
        let shaderB = SKShader(fileNamed: "backgroundShader")
        shaderB.uniforms = uniform
        background.shader = shaderB
        
        
        let HomeButton: CSKButton = {
            let button = CSKButton(fileName: "Button", buttonAction:
            {
                GameManager.shared.transition(self, toScene: .MainMenu, transitionType: SKTransition.push(with: .right, duration: 1))
            })
            return button
        }()
        HomeButton.initText(fontNamed: "AmericanTypewriter-Bold", buttonText: "Home", fontSize: 32)
        HomeButton.linearScale(ScreenSize.width / 2)
        HomeButton.position = CGPoint(x: ScreenSize.width/2, y: ScreenSize.height/8)
        addChild(HomeButton)
        
        addText()
        
        let nextText: CSKButton = {
            let button = CSKButton(fileName: "Button", buttonAction:
            {
                self.currentTextIndex = self.currentTextIndex + 1
            })
            return button
        }()
        nextText.initText(fontNamed: "AmericanTypewriter-Bold", buttonText: "Next", fontSize: 16)
        nextText.linearScale(ScreenSize.width / 4)
        nextText.position = CGPoint(x: ScreenSize.width/2, y: ScreenSize.height/3)
        addChild(nextText)
        
        textLable.text = textArray[0]
        textLable.position = CGPoint(x: ScreenSize.width / 2, y: ScreenSize.height / 1.5)
        textLable.fontSize = ScreenSize.width / 37
        addChild(textLable)
        
    }
    
    func addText()
    {
        textArray.append("This game is about sifting gold to find the treasure")
        textArray.append("3 difficulties dictate how close to the treasure you have to be to collect")
        textArray.append("Once you've selected you difficulty press play and you'll be taken to the map")
        textArray.append("If you tap on the grass you'll dig a hole, searching that area for gold")
        textArray.append("If you tap the water you'll sift for gold. This lasts for 10 seconds")
        textArray.append("The more gold you see the closer you are to the golds source on land")
        textArray.append("If you find the gold you win, but be carefull you have limited shovels")
    }
}
