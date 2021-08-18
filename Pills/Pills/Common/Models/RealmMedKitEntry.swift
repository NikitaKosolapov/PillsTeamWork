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
        ].map {$0.localized()},
        PillType.tablets: [
            "pill",
            "piece",
            "mg",
            "g"
        ].map {$0.localized()},
        PillType.syringe: [
            "piece",
            "ampoule",
            "syringe",
            "ml",
            "mg",
            "g",
            "cm3"
        ].map {$0.localized()},
        PillType.drops: [
            "drop",
            "times",
            "piece"
        ].map {$0.localized()},
        PillType.salve: [
            "taking",
            "times",
            "piece"
        ].map {$0.localized()},
        PillType.liquid: [
            "bowl",
            "flask",
            "teaspoon",
            "tablespoon",
            "ml"
        ].map {$0.localized()},
        PillType.suspension: [
            "bowl",
            "flask",
            "teaspoon",
            "tablespoon",
            "ml"
        ].map {$0.localized()},
        PillType.spray: [
            "times",
            "injection"
        ].map {$0.localized()},
        PillType.procedure: [
            "times",
            "inhalation",
            "taking",
            "suppository",
            "enema"
        ].map {$0.localized()}
    ]

    func image() -> UIImage {
        return UIImage(named: self.rawValue) ?? UIImage()
    }
    
    func units() -> [String] {
        return PillType.unitsMap[self] ?? []
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
    @objc dynamic var isUsed = false // false - wasn't used yet, true - was used

    required override init() {}
    
    init(time: Date, isUsed: Bool) {
        self.time = time
        self.isUsed = isUsed
    }
}

class RealmMedKitEntry: Object {
    @objc dynamic var entryID = UUID.init().uuidString
    @objc dynamic var name = "(not named)"
    @objc dynamic var singleDose: Double = 0
    @objc dynamic var concentration: Double = 0
    @objc dynamic var comments = "(no comments)"
    @objc dynamic var startDate = Date()
    @objc dynamic var endDate = Date()
    @objc dynamic var pillTypeHolder = PillType.tablets.rawValue
    @objc dynamic var concentrationUnitHolder = ConcentrationUnit.g.rawValue
    @objc dynamic var usageHolder = Usage.noMatter.rawValue
    @objc dynamic var unitString = ""

    var pillType: PillType {
      get { return PillType(rawValue: pillTypeHolder)! }
      set { pillTypeHolder = newValue.rawValue }
    }
    
    var concentrationUnit: ConcentrationUnit {
      get { return ConcentrationUnit(rawValue: concentrationUnitHolder)! }
      set { concentrationUnitHolder = newValue.rawValue }
    }

    var usage: Usage {
      get { return Usage(rawValue: usageHolder)! }
      set { usageHolder = newValue.rawValue }
    }

    var schedule = List<RealmTimePoint>()
    
    override class func primaryKey() -> String? {
        return "entryID"
    }

    required override init() {}

    init(name: String,
         pillType: PillType,
         singleDose: Double,
         concentration: Double,
         concentrationUnit: ConcentrationUnit,
         unitString: String,
         usage: Usage,
         comments: String,
         startDate: Date,
         endDate: Date,
         schedule: List<RealmTimePoint>
    ) {
        self.name = name
        self.singleDose = singleDose
        self.concentration = concentration
        self.concentrationUnitHolder = concentrationUnit.rawValue
        self.comments = comments
        self.startDate = startDate
        self.endDate = endDate
        self.pillTypeHolder = pillType.rawValue
        self.usageHolder = usage.rawValue
        self.unitString = unitString

        super.init()
        self.schedule.append(objectsIn: schedule)
    }
}
