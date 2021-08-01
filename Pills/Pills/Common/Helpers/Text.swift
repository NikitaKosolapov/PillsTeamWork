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
    static let addNewPill = "addNewPill".localized()
    static let name = "name".localized()
    static let singleDose = "singleDose".localized()
    static let instruction = "instruction".localized()
    static let comments = "comments".localized()
    static let time = "time".localized()
    static let add = "add".localized()

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

    // swiftlint:disable variable_name
    enum Unit {
        static let pill = "pill".localized()
        static let piece = "piece".localized()
        static let mg = "mg".localized()
        static let ml = "ml".localized()
        static let g = "g".localized()
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

    // MARK: - TabBar
    enum Tabs {
        static let aidkit = "aidkit".localized()
        static let journal = "journal".localized()
        static let settings = "settings".localized()
    }
}
