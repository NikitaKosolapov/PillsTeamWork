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
    static let badColor = UIColor(hex: 0xFFFF00)

    static let white = UIColor(named: "white") ?? badColor
    static let black = UIColor(named: "black") ?? badColor
    static let red = UIColor(named: "red") ?? badColor
    static let green = UIColor(named: "green") ?? badColor
    static let blue = UIColor(named: "blue") ?? badColor

    static let cellBackgroundColor = UIColor(red: 0.922, green: 0.957, blue: 0.996, alpha: 1)
    static let semiTransparentBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 0.46)
    
    enum AidKit {
        static let addButton = UIColor(named: "addButton") ?? badColor
        static let background = UIColor(named: "background") ?? badColor
        static let cell = UIColor(named: "cell") ?? badColor
        static let progress = UIColor(named: "progress") ?? badColor
        static let segmentActive = UIColor(named: "segmentActive") ?? badColor
        static let segmentNoActive = UIColor(named: "segmentNoActive") ?? badColor
        static let shadowOfCell = UIColor(named: "shadowOfCell") ?? badColor
        
        static let addButtonText = UIColor(named: "addButtonText") ?? badColor
        static let cellTextDays = UIColor(named: "cellTextDays") ?? badColor
        static let cellTextDuration = UIColor(named: "cellTextDuration") ?? badColor
        static let cellTextName = UIColor(named: "cellTextName") ?? badColor
        static let segmentTextActive = UIColor(named: "segmentTextActive") ?? badColor
        static let segmentTextNoActive = UIColor(named: "segmentTextNoActive") ?? badColor
        static let stubText = UIColor(named: "stubText") ?? badColor
    }
    
    enum Rate {
        static let backgroundTransparentRateView = UIColor(named: "backgroundTransparentRateView") ?? badColor
        static let backgroundRateView = UIColor(named: "backgroundRateView") ?? badColor
        static let noThanksButton = UIColor(named: "noThanksButton") ?? badColor
        static let provideFeedbackButton = UIColor(named: "provideFeedbackButton") ?? badColor
    }
    
    enum CalendarColor {
        static let weekdayTextColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        static let selectionDefaultColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        static let selectionColor = UIColor.init(red: 0, green: 0.478, blue: 1, alpha: 1)
        static let todayColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        static let todayDeafaultColor = UIColor.init(red: 0, green: 0.478, blue: 1, alpha: 1)
        static let titleDefaultTodayColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        static let titleTodayColor = UIColor.init(red: 0, green: 0.478, blue: 1, alpha: 1)
        static let titleSelectionDefaultColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        static let titleSelectionColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        static let eventDefaultColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        static let titleWeekendColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        static let headerTitleDefaultColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        static let headerTitleColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1) 
    }
}
