//
//  CSKSideBar.swift
//  GoldSweeper
//
//  Created by COX, LUKE (Student) on 10/12/2021.
//  Copyright © 2021 COX, LUKE (Student). All rights reserved.
//

import SpriteKit

class CSKSideBar: SKNode {
    public var IsEnabled = false
    public let isLeft: Bool
    
    private let background: SKShapeNode
    private let backgroundWidth: CGFloat
    
    init(isLeftHanded: Bool, sideBarWidth: CGFloat, backgroundColor: UIColor = .white)
    {
        self.isLeft = isLeftHanded
        self.backgroundWidth = sideBarWidth
        if(isLeft) {background = SKShapeNode(rect: CGRect(x:  -(ScreenSize.width / 2) - backgroundWidth, y: -(ScreenSize.height/2), width: sideBarWidth, height: ScreenSize.height))}
        else { background = SKShapeNode(rect: CGRect(x: (ScreenSize.width/2), y: -(ScreenSize.height/2), width: sideBarWidth, height: ScreenSize.height))}
        background.fillColor = backgroundColor
        super.init()
        
        zPosition = 1000
        
        addChild(background)
    
        isUserInteractionEnabled = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func enable()
    {
        IsEnabled = true
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: isLeft ? backgroundWidth : -backgroundWidth, y: 0))
        
        let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: false, speed: 200)
        background.run(move)
    }
    
    public func disable()
    {
        IsEnabled = false
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: isLeft ? -backgroundWidth : backgroundWidth, y: 0))
        
        let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: false, speed: 200)
        background.run(move)
    }
    
    public func addNode(_ node: SKNode, yPositionOutFromMinus1to1: CGFloat)
    {
        //Clamping values
        var yP = yPositionOutFromMinus1to1
        if(yP > 1) {yP = 1}
        if(yP < -1) {yP = -1}
        
        yP = yP * (ScreenSize.height / 2)
        
        let newNode: SKNode = node
        newNode.position = CGPoint(x: isLeft ? -(ScreenSize.width / 2) - backgroundWidth/2 : (ScreenSize.width/2)  + backgroundWidth/2, y: yP)
        newNode.zPosition = 1001
        background.addChild(newNode)
    }
    
    
    
}
