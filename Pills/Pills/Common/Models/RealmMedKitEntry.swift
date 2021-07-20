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

class RealmTimePoint: Object {
    @objc dynamic var time: Date // time and date when to use a pill
    @objc dynamic var status: Bool // false - wasn't used yet, true - was used
    
    init(time: Date, status: Bool) {
        self.time = time
        self.status = status
    }
    
    required override init() {
        self.time = Date()
        self.status = false
    }
}

class RealmMedKitEntry: Object {
    @objc dynamic var entryID: String = UUID.init().uuidString
    @objc dynamic var name: String
    @objc dynamic var singleDose: Double
    @objc dynamic var comments: String
    @objc dynamic var startDate: Date
    @objc dynamic var endDate: Date
    @objc dynamic var pillTypeHolder: String
    @objc dynamic var usageHolder: String

    var pillType: PillType {
      get { return PillType(rawValue: pillTypeHolder)! }
      set { pillTypeHolder = newValue.rawValue }
    }

    var usage: Usage {
      get { return Usage(rawValue: usageHolder)! }
      set { usageHolder = newValue.rawValue }
    }
    
    var schedule = List<RealmTimePoint>()
    
    override class func primaryKey() -> String? {
        return "entryID"
    }
    
    required override init() {
        self.name = "(not named)"
        self.singleDose = 0
        self.comments = "(no comments)"
        self.startDate = Date()
        self.endDate = Date()
        self.pillTypeHolder = PillType.tablets.rawValue
        self.usageHolder = Usage.noMatter.rawValue
    }

    init(name: String,
         pillType: PillType,
         singleDose: Double,
         usage: Usage,
         comments: String,
         startDate: Date,
         endDate: Date,
         schedule: List<RealmTimePoint>
    ) {
        self.name = name
        self.singleDose = singleDose
        self.comments = comments
        self.startDate = Date()
        self.endDate = Date()
        self.pillTypeHolder = pillType.rawValue
        self.usageHolder = usage.rawValue

        super.init()
        self.schedule.append(objectsIn: schedule)
    }
}
