//
//  GameViewController.swift
//  NinjaGameIThink
//
//  Created by COX, LUKE (Student) on 02/11/2021.
//  Copyright © 2021 COX, LUKE (Student). All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    let skView: SKView = {
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(skView)
        
        //Setting View Anchors
        skView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        skView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        skView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        skView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        
        
    }

    @objc func didTapStartButton()
    {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    
    
    
    override var shouldAutorotate: Bool {
         return true
     }

     override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
         if UIDevice.current.userInterfaceIdiom == .phone {
             return .allButUpsideDown
         } else {
             return .all
         }
     }

     override var prefersStatusBarHidden: Bool {
         return true
     }
     
}
