//
//  Extension.swift
//  GoldSweeper
//
//  Created by COX, LUKE (Student) on 03/12/2021.
//  Copyright © 2021 COX, LUKE (Student). All rights reserved.
//

import UIKit

//Screen struct to help with global acess of bounds
struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let diagonalLength = sqrt((UIScreen.main.bounds.size.width) * (UIScreen.main.bounds.size.width) + (UIScreen.main.bounds.size.height) * (UIScreen.main.bounds.size.height))
}

