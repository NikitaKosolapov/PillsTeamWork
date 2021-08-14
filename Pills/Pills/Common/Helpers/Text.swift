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

enum Text {

    // MARK: - Add a new pill
    // swiftlint:disable variable_name
    static let addNewPill = "addNewPill".localized()
    static let name = "name".localized()
    static let singleDose = "singleDose".localized()
    static let concentration = "concentration".localized()
    static let instruction = "instruction".localized()
    static let comments = "comments".localized()
    static let time = "time".localized()
    static let add = "add".localized()
    static let of = "of".localized()
    static let takePillsInTime = "takePillsInTime".localized()
    static let justAddAnOrder = "justAddAnOrder".localized()

    enum Pills {
        static let tablets = "tablets".localized()
        static let capsules = "capsules".localized()
        static let drops = "drops".localized()
        static let procedure = "procedure".localized()
        static let salve = "salve".localized()
        static let liquid = "liquid".localized()
        static let syringe = "syringe".localized()
        static let suspension = "suspension".localized()
    }

    enum Usage {
        static let beforeMeals = "beforeMeals".localized()
        static let whileEating = "whileEating".localized()
        static let afterMeals = "afterMeals".localized()
        static let noMatter = "noMatter".localized()
    }

    enum Unit {
        static let pill = "pill".localized()
        static let piece = "piece".localized()
        static let mg = "mg".localized()
        static let ml = "ml".localized()
        static let g = "g".localized()
        static let capsule = "capsule".localized()
        static let drop = "drop".localized()
        static let times = "times".localized()
        static let inhalation = "inhalation".localized()
        static let taking = "taking".localized()
        static let suppository = "suppository".localized()
        static let enema = "enema".localized()
        static let bowl = "bowl".localized()
        static let flask = "flask".localized()
        static let teaspoon = "teaspoon".localized()
        static let tablespoon = "tablespoon".localized()
        static let ampoule = "ampoule".localized()
        static let syringe = "syringe".localized()
        static let cm3 = "cm3".localized()
        static let injection = "injection".localized()
    }
    
    enum ConcentrationUnit {
        static let g = "g".localized()
        static let mg = "mg".localized()
        static let IU = "IU".localized()
        static let mсg = "mсg".localized()
        static let mEq = "mEq".localized()
        static let ml = "ml".localized()
        static let percent = "percent".localized()
        static let mgToG = "mgToG".localized()
        static let mgToCm2 = "mgToCm2".localized()
        static let mgToMl = "mgToMl".localized()
        
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
        static let language = "language".localized()
        static let aboutApp = "aboutApp".localized()
        static let writeSupport = "writeSupport".localized()
        static let notification = "notification".localized()
        static let appearance = "appearance".localized()
        static let privacy = "privacy".localized()
        static let termsOfUsage = "termsOfUsage".localized()
        static let privacyPolicy = "privacyPolicy".localized()
        static let rate = "rate".localized()
        static let mainSection = "mainSection".localized()
        static let infoSection = "infoSection".localized()
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
}
