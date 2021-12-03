//
//  GameScene.swift
//  GoldSweeper
//
//  Created by COX, LUKE (Student) on 02/11/2021.
//  Copyright © 2021 COX, LUKE (Student). All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class Ball: SKSpriteNode{
    var isGold: Bool
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        isGold = false
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(gold: Bool, name: String)
    {
        self.init(imageNamed: name)
        isGold = gold
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) Hass not been implemented")
    }

}


class GameScene: SKScene {
    
    let viewWidth = CGFloat(ScreenSize.width)
    let viewHeight = CGFloat(ScreenSize.height)
    
    //DO DEVICE ERROR CHECKING FOR SCREEN ASPECT RATIO, number of balls based on size and change font size based on width
    let numberOfBalls = 100;
    let luckyNumberOfBalls = 2;
    var goldScore = SKLabelNode(fontNamed: "HelveticaNeue-Thick")
    var ballNodes: Array<Ball> = [Ball]()
    
    var motionManager: CMMotionManager?
    
    var score = 0 {
        didSet {
            goldScore.text  = "Gold Count: \(score)"
        }
    }
    
    
    
    override func didMove(to view: SKView) {
        
        // The background
        let background = SKSpriteNode(imageNamed: "checkerboard")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.alpha = 0.5
        background.zPosition = -1
        addChild(background)
        
        //The border Collision Objects
        let panelWidth = 10
        let TopAndBottom = CGRect(x: 0, y: 0, width: Int(frame.width), height: panelWidth)
        
        
        let TopNode = SKShapeNode(rect: TopAndBottom)
        TopNode.fillColor = SKColor(red: 0.58, green: 0.294, blue: 0, alpha: 1)
        TopNode.position = CGPoint(x: 0, y: frame.height - CGFloat(panelWidth))
        TopNode.physicsBody = SKPhysicsBody(edgeLoopFrom: TopAndBottom)
        TopNode.physicsBody?.isDynamic = false
        addChild(TopNode)
        
        let BottomNode = SKShapeNode(rect: TopAndBottom)
        BottomNode.fillColor = SKColor(red: 0.58, green: 0.294, blue: 0, alpha: 1)
        BottomNode.position = CGPoint(x: 0,y: 0)
        BottomNode.physicsBody = SKPhysicsBody(edgeLoopFrom: TopAndBottom)
        BottomNode.physicsBody?.isDynamic = false
        addChild(BottomNode)
        
        let SideToSide = CGRect(x: 0, y: 0, width: panelWidth, height: Int(frame.height))
        
        let rightNode = SKShapeNode(rect: SideToSide)
        rightNode.fillColor = SKColor(red: 0.58, green: 0.294, blue: 0, alpha: 1)
        rightNode.position = CGPoint(x: 0, y: 0)
        rightNode.physicsBody = SKPhysicsBody(edgeLoopFrom: SideToSide)
        rightNode.physicsBody?.isDynamic = false
        addChild(rightNode)
        
        let leftNode = SKShapeNode(rect: SideToSide)
        leftNode.fillColor = SKColor(red: 0.58, green: 0.294, blue: 0, alpha: 1)
        leftNode.position = CGPoint(x: frame.width - CGFloat(panelWidth), y: 0)
        leftNode.physicsBody = SKPhysicsBody(edgeLoopFrom: SideToSide)
        leftNode.physicsBody?.isDynamic = false
        addChild(leftNode)
        
        
        
        
        let ball = SKSpriteNode(imageNamed: "ballGrey")
        let ballRadius = ball.frame.width / 2
    
        
        var luckyNumbersz: Array<Int> = [Int]()
        
        for i  in 1...luckyNumberOfBalls
        {
            let randnum = Int.random(in: 1...numberOfBalls)
            luckyNumbersz.append(randnum)
        }
        
        for i2 in 1...numberOfBalls
        {
            let randomX = CGFloat.random(in: ballRadius + viewWidth/4...viewWidth/2 + viewWidth/4 - ballRadius)
            let randomY = CGFloat.random(in: ballRadius + viewHeight/4...viewHeight/2 + viewHeight/4 - ballRadius)
            let randomZ = CGFloat.random(in: CGFloat(1)...CGFloat(numberOfBalls/2))
            var ballColour = ""
            var isGold = false
            
            for item in luckyNumbersz {
                if(i2 == item)
                {
                    ballColour = "ballYellow"
                    isGold = true
                }
            }
            
            if (ballColour == "")
            {
                ballColour = "ballGrey"
            }
            
            let ball = Ball(gold: isGold, name: ballColour)
            ball.position = CGPoint(x: randomX, y: randomY)
            ball.zPosition = randomZ
            ball.name = ballColour
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
            ball.physicsBody?.allowsRotation = false
            ball.physicsBody?.affectedByGravity = false
            ball.physicsBody?.categoryBitMask = 0
            ball.physicsBody?.velocity = CGVector(dx: CGFloat.random(in: -400...400), dy: CGFloat.random(in: -400...400))
            
            //Adding to the scene and the ball register
            addChild(ball)
            ballNodes.append(ball)
        }
        
        //Setting up font based on the screen size
        goldScore.fontSize = frame.width / 20
        goldScore.position = CGPoint(x: 20, y: 20)
        goldScore.text = "Gold Count: 0"
        goldScore.zPosition = CGFloat(numberOfBalls + 1)
        goldScore.fontColor = UIColor(red: 0.8314, green: 0.6863, blue: 0.2157, alpha: 1)
        goldScore.horizontalAlignmentMode = .left
        addChild(goldScore)
        
        
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
        //Code Goes in here
 
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if let accelerometerData = motionManager?.accelerometerData {
            for nug in ballNodes {
                let xP = CGFloat(nug.position.x) + CGFloat(accelerometerData.acceleration.x)
                let yP = CGFloat(nug.position.y) + CGFloat(accelerometerData.acceleration.y)
                nug.position = CGPoint(x: xP , y: yP)
            }
            //physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let ball = SKSpriteNode(imageNamed: "ballGrey")
        let ballRadius = ball.frame.width / 2
        
        guard let touchPos = touches.first?.location(in: self) else {return}
        
        for nug in ballNodes {
            if (nug.isGold)
            {
                let dist = (nug.position.x - touchPos.x) * (nug.position.x - touchPos.x) + (nug.position.y - touchPos.y) * (nug.position.y - touchPos.y)
                if(dist <= ballRadius * ballRadius)
                {
                    score += Int(1)
                }

            }
        }

    }
    
}
