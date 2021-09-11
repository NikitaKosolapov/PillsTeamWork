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
    static let blue = UIColor(named: "blue") ?? badColor
    static let gray = UIColor(named: "gray") ?? badColor
    static let lightBlue = UIColor(named: "lightBlue") ?? badColor
    static let lightGray = UIColor(named: "lightGray") ?? badColor
    static let red = UIColor(named: "red") ?? badColor
    static let semiBlack = UIColor(named: "semiBlack") ?? badColor
    static let semiGray = UIColor(named: "semiGray") ?? badColor
    static let semiWhite = UIColor(named: "semiWhite") ?? badColor
    static let white = UIColor(named: "white") ?? badColor
    
    /// TabBar colors section
    static let blueTintTabBar = UIColor(named: "blueTintTabBar") ?? badColor
    static let grayUnselectedItemTintTabBar = UIColor(named: "grayUnselectedItemTintTabBar") ?? badColor
    static let whiteTabBarTintColor = UIColor(named: "whiteTabBarTintColor") ?? badColor
    
    /// CoursesVC colors section
    static let whiteCoursesVCBG = UIColor(named: "whiteCoursesVCBG") ?? badColor
    
    // CoursesVC SegmentedControl(SC) colors section
    static let lightGrayBackgroundSC = UIColor(named: "lightGrayBackgroundSC") ?? badColor
    static let whiteSelectedTextSC = UIColor(named: "whiteSelectedTextSC") ?? badColor
    static let blueSelectedSegmentSC = UIColor(named: "blueSelectedSegmentSC") ?? badColor
    
    // CoursesVC TableView colors section
    static let whiteTableViewBG = UIColor(named: "whiteTableViewBG") ?? badColor
    
    // CoursesVC TableViewCell colors section
    static let grayTextPassedDaysLabel = UIColor(named: "grayTextPassedDaysLabel") ?? badColor
    static let semiGrayProgressViewBG = UIColor(named: "semiGrayProgressViewBG") ?? badColor
    static let whiteCellBG = UIColor(named: "whiteCellBG") ?? badColor
    static let blackPillNameLabel = UIColor(named: "blackPillNameLabel") ?? badColor
    static let blackDurationOfCoursesLabel = UIColor(named: "blackDurationOfCoursesLabel") ?? badColor
    static let lightGrayCoursesCellView = UIColor(named: "lightGrayCoursesCellView") ?? badColor
    static let whitePillImageContainer = UIColor(named: "whitePillImageContainer") ?? badColor
    
    // CoursesVC AddButton colors section
    static let blueAddButtonBG = UIColor(named: "blueAddButtonBG") ?? badColor
    static let whiteTextAddButton = UIColor(named: "whiteTextAddButton") ?? badColor
    
    // StubCoursesView colors section
    static let whiteStubCoursesBG = UIColor(named: "whiteStubCoursesBG") ?? badColor
    static let blackStubInfoLabel = UIColor(named: "blackStubInfoLabel") ?? badColor
    static let lightBlueStubImageViewBG = UIColor(named: "lightBlueStubImageViewBG") ?? badColor
    
    /// JournalVC colors section
    static let whiteJournalVCBG = UIColor(named: "whiteJournalVCBG") ?? badColor
    
    // JournalVC Views colors section
    static let whiteRounderСornersViewBG = UIColor(named: "whiteRounderСornersViewBG") ?? badColor
    static let semiGrayMinusViewBG = UIColor(named: "semiGrayMinusViewBG") ?? badColor
    
    // JournalVC TableView colors section
    static let whiteJournalTableViewBG = UIColor(named: "whiteJournalTableViewBG") ?? badColor
    
    // JournalVC AddButton colors section
    static let whiteTextJournalAddButton = UIColor(named: "whiteTextJournalAddButton") ?? badColor
    static let blueJournalAddButtonBG = UIColor(named: "blueJournalAddButtonBG") ?? badColor
    
    // JournalVC TableViewCell colors section
    static let whiteJournalPillImageContainer = UIColor(named: "whiteJournalPillImageContainer") ?? badColor
    static let blackJournalPillNameLabel = UIColor(named: "blackJournalPillNameLabel") ?? badColor
    static let semiBlackJournalInstructionLabel = UIColor(named: "semiBlackJournalInstructionLabel") ?? badColor
    static let semiBlackJournalUsageLabel = UIColor(named: "semiBlackJournalUsageLabel") ?? badColor
    static let blackJournalTimeLabel = UIColor(named: "blackJournalTimeLabel") ?? badColor
    static let whiteJournalTimeLabelBG = UIColor(named: "whiteJournalTimeLabelBG") ?? badColor
    
    // JournalVC Calendar colors section
    static let blackWeekdayTextJournalCalendar = UIColor(named: "blackWeekdayTextJournalCalendar") ?? badColor
    static let blackHeaderTitleJournalCalendar = UIColor(named: "blackHeaderTitleJournalCalendar") ?? badColor
    static let whiteSelectedDayTextJournalCalendar = UIColor(named: "whiteSelectedDayTextJournalCalendar") ?? badColor
    static let semiBlackWeekendTextJournalCalendar = UIColor(named: "semiBlackWeekendTextJournalCalendar") ?? badColor
    static let blackDayTextJournalCalendar = UIColor(named: "blackDayTextJournalCalendar") ?? badColor
    static let blueTodayDateTextJournalCalendar = UIColor(named: "blueTodayDateTextJournalCalendar") ?? badColor
    
    // JournalVC DebugView colors section
    static let lightBlueJournalManImageViewBG = UIColor(named: "lightBlueJournalManImageViewBG") ?? badColor
    static let blackTextManHintHeaderLabel = UIColor(named: "blackTextManHintHeaderLabel") ?? badColor
    static let blackTextManHintSubtitleLabel = UIColor(named: "blackTextManHintSubtitleLabel") ?? badColor
    
    /// SettingsVC colors section
    
    // SettingsVC TableView colors section
    static let whiteSettingsTableViewBG = UIColor(named: "whiteSettingsTableViewBG") ?? badColor
    
    // SettingsVC TableViewCell colors section
    static let lightGrayTableViewCellBG = UIColor(named: "lightGrayTableViewCellBG") ?? badColor
    static let blackCellTitleLabel = UIColor(named: "blackCellTitleLabel") ?? badColor
    static let semiGrayAccessoryButton = UIColor(named: "semiGrayAccessoryButton") ?? badColor
    static let greenSwitcherBG = UIColor(named: "greenSwitcherBG") ?? badColor
    
    /// RateVC colors section
    static let semiWhiteRateVCBG = UIColor(named: "semiWhiteRateVCBG") ?? badColor
    
    // RateVC view colors section
    static let lightBlueRateViewBG = UIColor(named: "lightBlueRateViewBG") ?? badColor
    static let blackRateViewTopLabel = UIColor(named: "blackRateViewTopLabel") ?? badColor
    static let blackCenterStyleLabel = UIColor(named: "blackCenterStyleLabel") ?? badColor
    static let whiteRateStyleButtonTextColor = UIColor(named: "whiteRateStyleButtonTextColor") ?? badColor
    
    /// AddNewCourseVC colors section
    static let lightBlueAddNewCourseVCBG = UIColor(named: "lightBlueAddNewCourseVCBG") ?? badColor
    
    // SaveButton colors section
    static let lightBlueSaveButtonBG = UIColor(named: "lightBlueSaveButtonBG") ?? badColor
    static let blackSaveButtonTextColor = UIColor(named: "blackSaveButtonTextColor") ?? badColor
    
    // ScrollView colors section
    static let lightBlueScrollViewBG = UIColor(named: "lightBlueScrollViewBG") ?? badColor
    static let lightBlueTypeImageHolder = UIColor(named: "lightBlueTypeImageHolder") ?? badColor
    
    // CustomtextField colors section
    static let whiteTextFieldBG = UIColor(named: "whiteTextFieldBG") ?? badColor
    
    // NavBar colors section
    static let lightBlueNavBarTintColor = UIColor(named: "lightBlueNavBarTintColor") ?? badColor
}
