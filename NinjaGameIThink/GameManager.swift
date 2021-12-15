//
//  GameManager.swift
//  GoldSweeper
//
//  Created by COX, LUKE (Student) on 03/12/2021.
//  Copyright © 2021 COX, LUKE (Student). All rights reserved.
//

import Foundation
import SpriteKit

//Game manager for transfer from scene to scene as well as holding data that is used between scenes
class GameManager{
    
    
    enum E_GameScenes{
        case MainMenu, map, game, tutorial
    }
    
    enum E_Difficulty{
        case easy, medium, hard
    }
    
    private init(){}
    
    static let shared = GameManager()
    
    private var distanceToSourceTemp = CGFloat(-1)
    
    public var gameStarted = false
    
    private var currentPosition = CGPoint(x: 0, y: 0)
    
    public var difficulty = E_Difficulty.easy
    
    public var curruntShovels = 4
    
    public var arrayOfHoles: Array<SKShapeNode> = [SKShapeNode]()

    
    func getScene(_ sceneType: E_GameScenes) -> SKScene?
    {
        switch sceneType{
        case E_GameScenes.MainMenu:
            return MainMenu(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        case E_GameScenes.game:
            return GameScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        case .map:
            return MapScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        case .tutorial:
            return tutorialScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
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
    
    
    func setDistanceToSource(dist: CGFloat)
    {
        distanceToSourceTemp = dist
    }
    
    func getDistanceToSource() -> CGFloat
    {
        if(distanceToSourceTemp >= 0)
        {
            return distanceToSourceTemp
        }
        else
        {
            return -1
        }
    }
    
    func resetDist()
    {
        distanceToSourceTemp = -1
    }
    
    
    func setGoldPoint(_ point: CGPoint)
    {
        currentPosition = point
    }
    
    func getGoldPoint() -> CGPoint
    {
        return currentPosition
    }
    
    //Adding Score Singleton
    
    public func firstLanch()
    {
        if (!(UserDefaults.standard.integer(forKey: "Score") > 0))
        {
            print("First time run")
            UserDefaults.standard.set(Int(0), forKey: "Score")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    public func getScore() -> Int
    {
        return UserDefaults.standard.integer(forKey: "Score")
    }
    
    public func addToScore(_ addedScore: Int)
    {
        let currentScore = getScore()
        UserDefaults.standard.set(currentScore + addedScore, forKey: "Score")
        UserDefaults.standard.synchronize()
    }
    
}
