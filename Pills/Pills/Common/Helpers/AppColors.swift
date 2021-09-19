//
//  AppColors.swift
//  Pills
//
//  Created by aprirez on 7/17/21.
//

import UIKit

// TUTORIAL:
//   Colors for App
// USAGE:
//   let color: UIColor = AppColors.white
//   let color = AppColors.white

enum AppColors {
    
    // bad color will be set for colors missed in Colors.xcassets
    static let badColor = UIColor.yellow
    
    // Commom colors section
    static let black = UIColor(named: "black") ?? badColor
    static let blackOnly = UIColor(named: "blackOnly") ?? badColor
    static let blue = UIColor(named: "blue") ?? badColor
    static let lightBlueSapphire = UIColor(named: "lightBlueSapphire") ?? badColor
    static let gray = UIColor(named: "gray") ?? badColor
    static let lightBlue = UIColor(named: "lightBlue") ?? badColor
    static let lightGray = UIColor(named: "lightGray") ?? badColor
    static let lightGrayOnly = UIColor(named: "lightGrayOnly") ?? badColor
    static let red = UIColor(named: "red") ?? badColor
    static let semiBlack = UIColor(named: "semiBlack") ?? badColor
    static let semiGrayOnly = UIColor(named: "semiGrayOnly") ?? badColor
    static let semiWhite = UIColor(named: "semiWhite") ?? badColor
    static let semiWhiteDarkTheme = UIColor(named: "semiWhiteDarkTheme") ?? badColor
    static let white = UIColor(named: "white") ?? badColor
    static let whiteOnly = UIColor(named: "whiteOnly") ?? badColor
    static let whiteSapphire = UIColor(named: "whiteSapphire") ?? badColor
    static let greenBlue = UIColor(named: "greenBlue") ?? badColor
    static let whiteAnthracite = UIColor(named: "whiteAnthracite") ?? badColor
    static let lightBlueBlack = UIColor(named: "lightBlueBlack") ?? badColor
}
