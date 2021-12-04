//
//  GameManager.swift
//  GoldSweeper
//
//  Created by COX, LUKE (Student) on 03/12/2021.
//  Copyright © 2021 COX, LUKE (Student). All rights reserved.
//

import Foundation
import SpriteKit

class GameManager{
    
    enum E_GameScenes{
        case MainMenu, map, game
    }
    
    private init(){}
    
    static let shared = GameManager()
    
    
    func getScene(_ sceneType: E_GameScenes) -> SKScene?
    {
        switch sceneType{
        case E_GameScenes.MainMenu:
            return MainMenu(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        case E_GameScenes.game:
            return GameScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        case .map:
            return MapScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        }
    }
    
    func transition(_ fromScene: SKScene, toScene: E_GameScenes, transitionType: SKTransition? = nil)
    {
        guard let scene = getScene(toScene) else { return}
        if let transitionType = transitionType
        {
            scene.scaleMode = .resizeFill
            fromScene.view?.presentScene(scene, transition: transitionType)
        }
        else
        {
            scene.scaleMode = .resizeFill
            fromScene.view?.presentScene(scene)
        }
    }
}
