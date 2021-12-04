//
//  Map.swift
//  GoldSweeper
//
//  Created by COX, LUKE (Student) on 03/12/2021.
//  Copyright © 2021 COX, LUKE (Student). All rights reserved.
//

import SpriteKit

class MapScene: SKScene
{
    override func didMove(to view: SKView) {
        
        
        backgroundColor = .green
        
        //GRID
        
        let nOfVertGridSquares = 9
        
        gridSetup(nOfVertGridSquares)
        
        
        
        
    }
    
    func gridSetup(_ nOfVertGridSquares: Int)
    {
        let verticalLines = CGRect(x: 0, y: 0, width: 1, height: ScreenSize.height)
        let horizonralLines =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: 1)
        
        let gridSize = CGFloat(ScreenSize.height/CGFloat(nOfVertGridSquares))
        
        let gridHorizontalOffset = Int(ScreenSize.width) % nOfVertGridSquares
        
        let verticalGrid = ScreenSize.height / gridSize
        let horizontalGrid = ScreenSize.width / gridSize
        
        for V in 1...Int(verticalGrid)
        {
            let newH = SKShapeNode(rect: horizonralLines)
            newH.position =  CGPoint(x: 0, y: V*Int(gridSize))
            newH.fillColor = .black
            newH.alpha = 0.5
            addChild(newH)
        }
        
        for H in 1...Int(horizontalGrid)
        {
            let newV = SKShapeNode(rect: verticalLines)
            newV.position = CGPoint(x: H*Int(gridSize) + gridHorizontalOffset/2, y: 0)
            newV.fillColor = .black
            newV.alpha = 0.5
            addChild(newV)
        }
    }
}
