//
//  DeviceManagerExt.swift
//  GoldSweeper
//
//  Created by COX, LUKE (Student) on 03/12/2021.
//  Copyright © 2021 COX, LUKE (Student). All rights reserved.
//

import UIKit
enum UIUserInterfaceIdiom: Int {
    case underfinded
    case phone
    case pad
}

struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    
    static let maxHeight = max(ScreenSize.width, ScreenSize.height)
}


struct DeviceType {
    static let isIphone4OrLess = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxHeight < 568.0
    
    static let isIphone5 = 
}
