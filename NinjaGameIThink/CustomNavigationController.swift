//
//  CustomNavigationController.swift
//  GoldSweeper
//
//  Created by COX, LUKE (Student) on 10/12/2021.
//  Copyright © 2021 COX, LUKE (Student). All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

}
