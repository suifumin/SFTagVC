//
//  head.swift
//  Test
//
//  Created by suifumin on 2020/12/15.
//

import Foundation
import UIKit
func RGB(_ red: CGFloat = 255.0, _ green: CGFloat = 255.0, _ blue: CGFloat = 255.0) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
}
func isIphoneX() -> Bool {
    return (UIApplication.shared.statusBarFrame.size.height == 44.0) ? true : false
}
struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
