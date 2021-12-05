//
//  CSKButton.swift
//  GoldSweeper
//
//  Created by COX, LUKE (Student) on 04/12/2021.
//  Copyright © 2021 COX, LUKE (Student). All rights reserved.
//

import SpriteKit

class CSKButton: SKNode {
    let button: SKSpriteNode
    private var action: () -> Void
    var isEnabled = true
    let buttonLable = SKLabelNode()
    
    init(fileName: String, buttonAction: @escaping () -> Void)
    {
        button = SKSpriteNode(imageNamed: fileName)
        action = buttonAction
        
        super.init()
        
        isUserInteractionEnabled = true
        button.zPosition = 0
        addChild(button)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled{
            run(SKAction.scale(by: 1.05, duration: 0.2))
            
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled{
            for touch in touches
            {
                let location: CGPoint = touch.location(in: self)
                
                if button.contains(location)
                {
                    disable()
                    action()
                    run(SKAction.sequence([SKAction.wait(forDuration: 0.2), SKAction.run(
                        {
                            self.enable()
                    })]))
                }
            }
        }
    }
    
    func disable()
    {
        isEnabled = false
        button.alpha = 0.5
        buttonLable.alpha = 0.5
        
    }
    
    func enable()
    {
        isEnabled = true
        button.alpha = 1.0
        button.alpha = 1.0
    }
    
    func initText(fontNamed: String, buttonText: String)
    {
        buttonLable.fontName = fontNamed
        buttonLable.text = buttonText
        buttonLable.zPosition = 1
        
        print(buttonLable.position)
        
        addChild(buttonLable)
    }
    
    
}
