//
//  RealmMedKitEntry.swift
//  Pills
//
//  Created by aprirez on 7/19/21.
//

import Foundation
import RealmSwift

enum PillType: String {
    case tablets
    case capsules
    case drops
    case procedure
    case salve
    case spoon
    case syringe
    case suppository
    case suspension
}

enum Usage: String {
    case beforeMeals
    case whileEating
    case afterMeals
    case noMatter
}

// swiftlint:disable variable_name
enum Unit: String {
    case pill
    case piece
    case mg
    case ml
    case g
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
    @objc dynamic var comments = "(no comments)"
    @objc dynamic var startDate = Date()
    @objc dynamic var endDate = Date()
    @objc dynamic var pillTypeHolder = PillType.tablets.rawValue
    @objc dynamic var usageHolder = Usage.noMatter.rawValue
    @objc dynamic var unitHolder = Unit.pill.rawValue

    var pillType: PillType {
      get { return PillType(rawValue: pillTypeHolder)! }
      set { pillTypeHolder = newValue.rawValue }
    }

    var usage: Usage {
      get { return Usage(rawValue: usageHolder)! }
      set { usageHolder = newValue.rawValue }
    }
    
    var unit: Unit {
      get { return Unit(rawValue: unitHolder)! }
      set { unitHolder = newValue.rawValue }
    }

    var schedule = List<RealmTimePoint>()
    
    override class func primaryKey() -> String? {
        return "entryID"
    }

    required override init() {}

    init(name: String,
         pillType: PillType,
         singleDose: Double,
         unit: Unit,
         usage: Usage,
         comments: String,
         startDate: Date,
         endDate: Date,
         schedule: List<RealmTimePoint>
    ) {
        self.name = name
        self.singleDose = singleDose
        self.comments = comments
        self.startDate = startDate
        self.endDate = endDate
        self.pillTypeHolder = pillType.rawValue
        self.usageHolder = usage.rawValue
        self.unitHolder = unit.rawValue

        super.init()
        self.schedule.append(objectsIn: schedule)
    }
}
