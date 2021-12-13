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
    let moveSpeed: CGFloat
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        moveSpeed = CGFloat.random(in: 5...15)
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
    
    //Remove these
    let viewWidth = CGFloat(ScreenSize.width)
    let viewHeight = CGFloat(ScreenSize.height)
    
    let rocks = ["Rock1", "Rock2", "Rock3", "Rock4"]
    let golds = ["Gold1", "Gold2"]
    
    var distanceToSource = CGFloat(-1)
    
    //DO DEVICE ERROR CHECKING FOR SCREEN ASPECT RATIO, number of balls based on size and change font size based on width
    let numberOfBalls = 200;
    
    var ballNodes: Array<Ball> = [Ball]()
    
    var motionManager: CMMotionManager?

    
    var timer = Timer()
    
    var TimeRemainingLable = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    var timeRemaining = 10 {
        didSet {
            if(timeRemaining > 0)
            {
                TimeRemainingLable.text  = "Time : \(timeRemaining)"
            }
        }
    }
    
    
    override func didMove(to view: SKView) {
        
        // The background
        let background = SKSpriteNode(imageNamed: "THEWATER")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.scale(to: CGSize(width: ScreenSize.height, height: ScreenSize.height))
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
        
        
        distanceToSource = GameManager.shared.getDistanceToSource()
               
        var scaler = distanceToSource / (ScreenSize.width * ScreenSize.width + ScreenSize.height * ScreenSize.height).squareRoot()
        scaler = round(scaler * 10)
        //Calculating the number of gold based on distance to the source
        let amountOfGold = 10 - scaler
        
        
        let ball = SKSpriteNode(imageNamed: "Rock1")
        let ballRadius = ball.frame.width / 2
    
        
        var luckyNumbersz: Array<Int> = [Int]()
        
        for i  in 1...Int(amountOfGold)
        {
            let randnum = Int.random(in: i...numberOfBalls)
            luckyNumbersz.append(randnum)
        }
        
        for i2 in 1...numberOfBalls
        {
            let randomX = CGFloat.random(in: ballRadius + viewWidth/4...viewWidth/2 + viewWidth/4 - ballRadius)
            let randomY = CGFloat.random(in: ballRadius + viewHeight/4...viewHeight/2 + viewHeight/4 - ballRadius)
            let randomZ = CGFloat.random(in: CGFloat(1)...CGFloat(numberOfBalls/2))
            var texture = ""
            var isGold = false
            
            for item in luckyNumbersz {
                if(i2 == item)
                {
                    texture = golds[i2%2]
                    isGold = true
                }
            }
            
            if (texture == "")
            {
                texture = rocks[i2%4]
            }
            
            let ball = Ball(gold: isGold, name: texture)
            ball.position = CGPoint(x: randomX, y: randomY)
            ball.zPosition = randomZ
            ball.name = texture
            ball.scale(to: CGSize(width: frame.width * 0.25, height: frame.width * 0.25))
            ball.zRotation = CGFloat.random(in: 0.1 ... 6.2)
            ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
            ball.physicsBody?.allowsRotation = false
            ball.physicsBody?.affectedByGravity = false
            ball.physicsBody?.categoryBitMask = 0
            ball.physicsBody?.velocity = CGVector(dx: CGFloat.random(in: -400...400), dy: CGFloat.random(in: -400...400))
            
            //Adding to the scene and the ball register
            addChild(ball)
            ballNodes.append(ball)
        }
        
        //Setting up font based on the screen size
        TimeRemainingLable.fontSize = frame.width / 20
        TimeRemainingLable.position = CGPoint(x: 20, y: 20)
        TimeRemainingLable.text = "Time : 10"
        TimeRemainingLable.zPosition = CGFloat(numberOfBalls + 1)
        TimeRemainingLable.fontColor = UIColor(red: 0.8314, green: 0.6863, blue: 0.2157, alpha: 1)
        TimeRemainingLable.horizontalAlignmentMode = .left
        addChild(TimeRemainingLable)
        
        
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameScene.timeChanges), userInfo: nil, repeats: true)
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if let accelerometerData = motionManager?.accelerometerData {
            for nug in ballNodes {
                let xP = CGFloat((nug.physicsBody?.velocity.dx)!)
                let yP = CGFloat((nug.physicsBody?.velocity.dy)!)
                
                
                //Shuffling the rocks z poition based on how hard the
                if(CGFloat(accelerometerData.acceleration.x) > 1 || CGFloat(accelerometerData.acceleration.y) > 1)
                {
                    nug.zPosition = nug.zPosition + CGFloat.random(in: 1...5)
                }
                else if (CGFloat(accelerometerData.acceleration.x) < -2 || CGFloat(accelerometerData.acceleration.y) < -2)
                {
                    nug.zPosition = nug.zPosition - CGFloat.random(in: 1...5)
                }
                
                if(nug.zPosition < 1)
                {
                    nug.zPosition = 1
                }
                if(nug.zPosition > CGFloat(numberOfBalls))
                {
                    nug.zPosition = CGFloat(numberOfBalls)
                }
                
                
                nug.physicsBody?.velocity = CGVector(dx: xP + CGFloat(accelerometerData.acceleration.x) * nug.moveSpeed, dy: yP + CGFloat(accelerometerData.acceleration.y) * nug.moveSpeed)
            }
        }
        
        if(timeRemaining <= 0)
        {
            TimeRemainingLable.text = "TIMES UP"
            if(timeRemaining <= 2)
            {
                GameManager.shared.transition(self, toScene: .map, transitionType: SKTransition.moveIn(with: .left, duration: 0.2))
            }
            
        }
    }
    
    @objc func timeChanges() -> Void
    {
        timeRemaining -= 1
    }
    
    //SIDE BAR ----------------------
    
}
