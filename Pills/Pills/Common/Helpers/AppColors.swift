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
    
    //    static let cellBackgroundColor = lightGray
    //    static let selectedCellBackgroundColor = lightBlue
    //    static let addNewCourseBackgroundColor = lightBlue
    //    static let semiTransparentBlack = semiBlack
    
        //        static let addButton = blue
        //        static let background = white
//        static let cellBackgroundColor = lightGray
//        static let selectedCellBackgroundColor = lightBlue
//        static let addNewCourseBackgroundColor = lightBlue
//        static let semiTransparentBlack = semiBlack
        
        enum AidKit {
            static let addButton = blue
            static let background = white
            static let cell = lightGray
            static let progress = blue
            static let segmentActive = blue
            static let segmentNoActive = lightGray
            static let shadowOfCell = semiGray
            
            //        static let addButtonText = white
            static let addButtonText = white
            static let cellTextDays = gray
            static let cellTextDuration = black
            static let cellTextName = black
            static let segmentTextActive = white
            static let segmentTextNoActive = gray
            static let stubText = black
        }
        
        //    enum Rate {
        //        static let backgroundTransparentRateView = semiWhite
        //        static let backgroundRateView = lightGray
        //        static let noThanksButton = red
        //        static let provideFeedbackButton = blue
        //    }
        
        enum CalendarColor {
            static let weekdayTextColor = black
            static let selectionDefaultColor = white
            static let selectionColor = blue
            static let todayColor = white
            static let todayDefaultColor = blue
            static let titleDefaultTodayColor = white
            static let titleTodayColor = blue
            static let titleSelectionDefaultColor = black
            static let titleSelectionColor = white
            static let eventDefaultColor = semiBlack
            static let titleWeekendColor = semiBlack
            static let headerTitleDefaultColor = black
            static let headerTitleColor = white
        }
        
        //    enum SettingsColor {
        //        static let cellHighlight = lightBlue
        //        static let cellUnhighlight = lightGray
        //    }
}
