//
//  RealmMedKitEntry.swift
//  Pills
//
//  Created by aprirez on 7/19/21.
//

import Foundation
import RealmSwift

// USAGE:
//   let pillType = PillType.capsules // or any user-selected type
//
//   // getting localized list of units:
//   let units = pillType.pillUnits().map { $0.localized() }
//
// We will not ever need to convert unit type from DB to any enum type because
// will use it only for displaying. To display localized unit type do:
//
//   // var entry: RealmMedKitEntry ...
//   entry.unitString.localized()

enum Frequency: String, CaseIterable {
    case daysOfTheWeek
    case dailyXTimes
    case dailyEveryXHour
    case daysCycle

    static func all() -> [String] {
        Frequency.allCases.map { $0.rawValue.localized() }
    }
}

enum PillType: String, CaseIterable {
    case capsules
    case tablets
    case syringe
    case drops
    case salve
    case liquid
    case suspension
    case spray
    case procedure

    fileprivate static let unitsMap = [
        PillType.capsules: [
            "capsule",
            "piece",
            "mg",
            "g"
        ],
        PillType.tablets: [
            "pill",
            "piece",
            "mg",
            "g"
        ],
        PillType.syringe: [
            "piece",
            "ampoule",
            "syringe",
            "ml",
            "mg",
            "g",
            "cm3"
        ],
        PillType.drops: [
            "drop",
            "times",
            "piece"
        ],
        PillType.salve: [
            "taking",
            "times",
            "piece"
        ],
        PillType.liquid: [
            "bowl",
            "flask",
            "teaspoon",
            "tablespoon",
            "ml"
        ],
        PillType.suspension: [
            "bowl",
            "flask",
            "teaspoon",
            "tablespoon",
            "ml"
        ],
        PillType.spray: [
            "times",
            "injection"
        ],
        PillType.procedure: [
            "times",
            "inhalation",
            "taking",
            "suppository",
            "enema"
        ]
    ]

    func image() -> UIImage {
        return UIImage(named: self.rawValue) ?? UIImage()
    }
    
    func units() -> [String] {
        return PillType.unitsMap[self] ?? []
    }
    
    static func allLocalized() -> [String] {
        PillType.allCases.map {$0.rawValue.localized()}
    }
}

enum Usage: String {
    case beforeMeals
    case whileEating
    case afterMeals
    case noMatter
}

// swiftlint:disable variable_name
enum ConcentrationUnit: String {
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
    
}

class RealmTimePoint: Object {
    @objc dynamic var time = Date()  // time and date when to use a pill
    var isUsed = RealmOptional<Bool>() // false - wasn't used yet, true - was used

    required override init() {}
    
    init(time: Date, isUsed: Bool?) {
        self.time = time
        self.isUsed.value = isUsed
    }
}

class RealmMedKitEntry: Object {
    @objc dynamic var entryID = UUID.init().uuidString
    @objc dynamic var name = "(not named)"
    @objc dynamic var singleDose: Double = 0
    @objc dynamic var startDate = Date.distantPast
    @objc dynamic var takeAtTime = Date.distantPast
    @objc dynamic var endDate = Date.distantPast
    @objc dynamic var pillTypeString = PillType.tablets.rawValue
    @objc dynamic var usageString = Usage.noMatter.rawValue
    @objc dynamic var freqString = Frequency.daysOfTheWeek.rawValue
    @objc dynamic var unitString = ""
    @objc dynamic var note = ""
    var schedule = List<RealmTimePoint>()
    
    public private(set) var isValid = false

    var frequency: Frequency {
        get { return Frequency(rawValue: freqString)! }
        set { freqString = newValue.rawValue }
      }

    var pillType: PillType {
      get { return PillType(rawValue: pillTypeString)! }
      set { pillTypeString = newValue.rawValue }
    }

    var usage: Usage {
      get { return Usage(rawValue: usageString)! }
      set { usageString = newValue.rawValue }
    }
    
    override class func primaryKey() -> String? {
        return "entryID"
    }

    required override init() {}

    init(name: String,
         pillType: PillType,
         singleDose: Double,
         unitString: String,
         startDate: Date,
         takeAtTime: Date,
         endDate: Date,
         usage: Usage,
         frequency: Frequency,
         note: String,
         schedule: List<RealmTimePoint>
    ) {
        self.name = name

        self.pillTypeString = pillType.rawValue

        self.singleDose = singleDose
        self.unitString = unitString

        self.startDate = startDate
        self.takeAtTime = takeAtTime

        self.endDate = endDate

        self.usageString = usage.rawValue
        self.freqString = frequency.rawValue
        self.note = note

        super.init()
        _ = validate()
        self.schedule.append(objectsIn: schedule)
    }
    
    func validate() -> Bool {
        guard name.isEmpty.not,
              pillTypeString.isEmpty.not,
              unitString.isEmpty.not,
              usageString.isEmpty.not,
              freqString.isEmpty.not,
              startDate > Date.distantPast,
              takeAtTime > Date.distantPast,
              endDate > Date.distantPast,
              singleDose > 0
              //TODO: Добавить проверку на наличие расписания, когда будут готовы все методы
//              schedule.isEmpty.not
        else {
            isValid = false
            return isValid
        }
        isValid = true
        return isValid
    }
}
