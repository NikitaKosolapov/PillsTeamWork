//
//  AppColors.swift
//  Pills
//
//  Created by aprirez on 7/17/21.
//

import Foundation
import UIKit

// TUTORIAL:
//   Colors for App
// USAGE:
//   let color: UIColor = AppColors.white
//   let color = AppColors.white

enum AppColors {
    
    // bad color will be set for colors missed in Colors.xcassets
    static let badColor = UIColor.yellow
    
    static let black = UIColor(named: "black") ?? badColor
    static let blue = UIColor(named: "blue") ?? badColor
    static let gray = UIColor(named: "gray") ?? badColor
    static let lightBlue = UIColor(named: "lightBlue") ?? badColor
    static let lightGray = UIColor(named: "lightGray") ?? badColor
    static let red = UIColor(named: "red") ?? badColor
    static let semiBlack = UIColor(named: "semiBlack") ?? badColor
    static let semiGray = UIColor(named: "semiGray") ?? badColor
    static let semiWhite = UIColor(named: "semiWhite") ?? badColor
    static let white = UIColor(named: "white") ?? badColor

}
