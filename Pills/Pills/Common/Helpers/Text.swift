//
//  Text.swift
//  Pills
//
//  Created by aprirez on 7/17/21.
//

import Foundation

// TUTORIAL:
//   Localized strings for English and Russian
// USAGE:
//   let text: String = Text.Pills.tablets
//   let text = Text.Pills.tablets

import UIKit

enum Text {

    // MARK: - Add a new pill
    // swiftlint:disable variable_name
    static let addNewPill = "addNewPill".localized()
    static let newPill = "newPill".localized()
    static let name = "name".localized()
    static let namePlaceholder = "namePlaceholder".localized()
    static let dose = "dose".localized()
    static let dosePlaceholder = "dosePlaceholder".localized()
    static let pillType = "pillType".localized()
    static let singleDose = "singleDose".localized()
    static let takingFrequencyTitle = "takingFrequencyTitle".localized()
    static let takingFrequency = "takingFrequency".localized()
    static let startFrom = "startFrom".localized()
    static let takeAtTime = "takeAtTime".localized()
    static let takePeriod = "takePeriod".localized()
    static let takePeriodPlaceholder = "takePeriodPlaceholder".localized()
    static let unit = "unit".localized()
    static let instruction = "instruction".localized()
    static let notes = "notes".localized()
    static let time = "time".localized()
    static let add = "add".localized()
    static let of = "of".localized()
    static let one = "1"
    static let takePillsInTime = "takePillsInTime".localized()
    static let justAddAnOrder = "justAddAnOrder".localized()
    static let periodExpired = "periodExpired".localized()
    static let till = "till".localized()
    static let save = "save".localized()
    static let singleDoseByNumber = "100"
    static let mg = "mg".localized()
    static let beforeMeal = "beforeMeal".localized()
    static let featuresOfTaking = "featuresOfTaking".localized()
    static let xDays = "xDays".localized()
    static let yDays = "yDays".localized()

    enum DatePickerButtons {
        static let done = "done".localized()
        static let now = "now".localized()
        static let cancel = "cancel".localized()
        static let today = "today".localized()
    }

    enum DaysOfAWeek: String, CaseIterable {
        case Monday
        case Tuesday
        case Wednesday
        case Thursday
        case Friday
        case Saturday
        case Sunday

        static func all() -> [String] {
            allCases.map {$0.rawValue.localized()}
        }
    }

    enum Pills: String, CaseIterable {
        case tablets
        case capsules
        case procedure
        case salve
        case liquid
        case syringe
        case suspension
        
        static func all() -> [String] {
            Text.Pills.allCases.map {$0.rawValue.localized()}
        }
    }

    enum Usage: String, CaseIterable {
        case beforeMeals
        case whileEating
        case afterMeals
        case noMatter

        static func all() -> [String] {
            Text.Usage.allCases.map {$0.rawValue.localized()}
        }
    }

    enum Unit: String, CaseIterable {
        case pill
        case piece
        case mg
        case ml
        case g
        case capsule
        case drop
        case times
        case inhalation
        case taking
        case suppository
        case enema
        case bowl
        case flask
        case teaspoon
        case tablespoon
        case ampoule
        case syringe
        case cm3
        case injection

        static func all() -> [String] {
            Text.Unit.allCases.map {$0.rawValue.localized()}
        }
    }
    
    enum ConcentrationUnit: String, CaseIterable {
        case g
        case mg
        case IU
        case mсg
        case mEq
        case ml
        case percent
        case mgToG
        case mgToCm2
        case mgToMl

        static func all() -> [String] {
            Text.ConcentrationUnit.allCases.map {$0.rawValue.localized()}
        }
    }

    enum Period: String, CaseIterable {
        case week
        case month
        case halfYear
        case year

        static func all() -> [String] {
            Text.Period.allCases.map { $0.rawValue.localized() }
        }
    }
    
    // MARK: - Journal Event Status
    enum Journal {
        static let accepted = "accepted".localized()
        static let missed = "missed".localized()
    }

    // MARK: - AidKit Event Type
    enum AidKit {
        static let active = "active".localized()
        static let completed = "completed".localized()
        static let stubText = "stubTextAidKit".localized()
        static let from = "from".localized()
        static let days = "days".localized()
    }

    // MARK: - Settings
    enum Settings {
        static let aboutApp = "aboutApp".localized()
        static let writeSupport = "writeSupport".localized()
        static let notification = "notification".localized()
        static let appearance = "appearance".localized()
        static let privacy = "privacy".localized()
        static let termsOfUsage = "termsOfUsage".localized()
        static let privacyPolicy = "privacyPolicy".localized()
        static let rate = "rate".localized()
    }
    
    // MARK: - Medicine Description
    enum MedicineDescription {
        static let accept = "accept".localized()
        static let skip = "skip".localized()
    }

    // MARK: - Rating
    enum Rating {
        static let rateApp = "rateApp".localized()
        static let badRate = "badRate".localized()
        static let normRate = "normRate".localized()
        static let bestRate = "bestRate".localized()
        static let provideFeedback = "provideFeedback".localized()
        static let noThanks = "noThanks".localized()
    }
    
    // MARK: - TabBar
    enum Tabs {
        static let aidkit = "aidkit".localized()
        static let journal = "journal".localized()
        static let settings = "settings".localized()
    }
    
    // MARK: - Feedback email text
    enum Feedback {
        static let subject = "subject".localized()
        static let hello = "hello".localized()
        static let iOSVersion = "iOSVersion".localized()
        static let deviceModel = "deviceModel".localized()
        static let appVersion = "appVersion".localized()
    }
    
    // MARK: - Push Notifications
    enum PushNotifications {
        static let itIsTimeToTakePill = "itIsTimeToTakePill".localized()
    }
}
