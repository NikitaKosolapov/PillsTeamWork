//
//  RealmModelsTest.swift
//  PillsTests
//
//  Created by aprirez on 7/20/21.
//

import RealmSwift
import XCTest
@testable import Pills

extension RealmTimePoint {
    func debugDump() {
        debugPrint("isUsed: \(self.isUsed)")
        debugPrint("time: \(self.time.timeIntervalSince1970)")
    }
}

extension RealmMedKitEntry {
    func debugDump() {
        debugPrint("MedKitEntry \(self.entryID)")
        debugPrint("  name = \(self.name)")
        debugPrint("  singleDose = \(self.singleDose)")
        debugPrint("  comments = \(self.comments)")
        debugPrint("  startDate = \(self.startDate)")
        debugPrint("  endDate = \(self.endDate)")
        debugPrint("  pillType = \(self.pillType)")
        debugPrint("  usage = \(self.usage)")
        debugPrint("  unit = \(self.unitString)")

        for time in self.schedule {
            time.debugDump()
        }
    }
}

class RealmModelsTest: XCTestCase {

    var realm: Realm?

    override func setUpWithError() throws {
        try? FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
        realm = try? Realm()
    }

    override func tearDownWithError() throws {}

    // swiftlint:disable function_body_length
    func testRealmMedKitEntry() throws {

        guard let realm = self.realm else {
            XCTAssertNotNil(self.realm)
            return
        }

        let currentTime = Date()

        let dates = List<RealmTimePoint>()
        dates.append(RealmTimePoint(time: currentTime, isUsed: false))
        dates.append(RealmTimePoint(time: currentTime, isUsed: true))

        let pillType = PillType.syringe
        let unit = pillType.pillUnits().last!

        let units = pillType.pillUnits().map { $0.localized("ru") }
        debugPrint(units)

        let entry = RealmMedKitEntry(
            name: "Vitamine B12",
            pillType: pillType,
            singleDose: 2,
            unitString: unit,
            usage: .afterMeals,
            comments: "bla-bla",
            startDate: currentTime,
            endDate: currentTime,
            schedule: dates
        )

        entry.debugDump()

        debugPrint("REALM: Saving...")
        try? realm.write {
            realm.deleteAll()
            realm.add(entry)
            try? realm.commitWrite()
        }

        debugPrint("REALM: Loading...")
        let loadedOpt = realm.objects(RealmMedKitEntry.self).first
        guard let loaded = loadedOpt
        else {
            debugPrint("REALM: No object found!")
            XCTAssertNotNil(loadedOpt)
            return
        }

        loaded.debugDump()

        XCTAssertTrue(loaded.entryID == entry.entryID)
        XCTAssertTrue(loaded.name == entry.name)
        XCTAssertTrue(loaded.pillType == entry.pillType)
        XCTAssertTrue(loaded.singleDose == entry.singleDose)
        XCTAssertTrue(loaded.unitString == entry.unitString)
        XCTAssertTrue(loaded.usage == entry.usage)
        XCTAssertTrue(loaded.comments == entry.comments)
        XCTAssertTrue(loaded.startDate == entry.startDate)
        XCTAssertTrue(loaded.endDate == entry.endDate)

        XCTAssertTrue(loaded.schedule.count == entry.schedule.count)

        while loaded.schedule.isEmpty {
            guard let loadedScheduleEntry = loaded.schedule.first,
                  let savedScheduleEntry = entry.schedule.first
            else {
                XCTAssertTrue(false)
                break
            }
            
            XCTAssertTrue(loadedScheduleEntry.time == savedScheduleEntry.time)
            XCTAssertTrue(loadedScheduleEntry.isUsed == savedScheduleEntry.isUsed)

            loaded.schedule.removeFirst()
            entry.schedule.removeFirst()
        }
    }
    
    // swiftlint:disable function_body_length
    func testRealmService() throws {

        let currentTime = Date()

        let dates = List<RealmTimePoint>()
        dates.append(RealmTimePoint(time: currentTime, isUsed: false))
        dates.append(RealmTimePoint(time: currentTime, isUsed: true))

        let entry = RealmMedKitEntry(
            name: "Aspirine",
            pillType: .capsules,
            singleDose: 2,
            unitString: PillType.capsules.pillUnits().first!,
            usage: .afterMeals,
            comments: "bla-bla",
            startDate: currentTime,
            endDate: currentTime,
            schedule: dates
        )

        entry.debugDump()

        try? RealmService.shared.realm?.write {
            RealmService.shared.realm?.deleteAll()
            try? RealmService.shared.realm?.commitWrite()
        }

        debugPrint("REALM: Saving...")
        RealmService.shared.create(entry)

        RealmService.shared.update {
            entry.comments = "updated"
        }

        debugPrint("REALM: Loading...")
        let loadedSet = RealmService.shared.get(RealmMedKitEntry.self)

        guard let loaded = loadedSet.first
        else {
            debugPrint("REALM: No object found!")
            XCTAssertNotNil(loadedSet)
            return
        }

        loaded.debugDump()

        XCTAssertTrue(loaded.entryID == entry.entryID)
        XCTAssertTrue(loaded.name == entry.name)
        XCTAssertTrue(loaded.pillType == entry.pillType)
        XCTAssertTrue(loaded.singleDose == entry.singleDose)
        XCTAssertTrue(loaded.unitString == entry.unitString)
        XCTAssertTrue(loaded.usage == entry.usage)
        XCTAssertTrue(loaded.comments == entry.comments)
        XCTAssertTrue(loaded.startDate == entry.startDate)
        XCTAssertTrue(loaded.endDate == entry.endDate)

        XCTAssertTrue(loaded.schedule.count == entry.schedule.count)

        while loaded.schedule.isEmpty {
            guard let loadedScheduleEntry = loaded.schedule.first,
                  let savedScheduleEntry = entry.schedule.first
            else {
                XCTAssertTrue(false)
                break
            }
            
            XCTAssertTrue(loadedScheduleEntry.time == savedScheduleEntry.time)
            XCTAssertTrue(loadedScheduleEntry.isUsed == savedScheduleEntry.isUsed)

            loaded.schedule.removeFirst()
            entry.schedule.removeFirst()
        }

        RealmService.shared.delete(entry)

        let loadedSet2 = RealmService.shared.get(RealmMedKitEntry.self)

        XCTAssertTrue(loadedSet2.isEmpty)
    }

}
