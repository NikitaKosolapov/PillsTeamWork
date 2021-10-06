//
//  JournalMock.swift
//  Pills
//
//  Created by aprirez on 7/23/21.
//

import Foundation
import RealmSwift

// TODO: remove me completely when Realm DB is ready
final class JournalMock {

    let entryExample1: RealmMedKitEntry
    let entryExample2: RealmMedKitEntry

    static let shared = JournalMock()

    private init() {
        let now = Date()

        var startDate = now.addingTimeInterval(-3600 * 24 * 7)
        startDate = startDate.startOfDay

        var endDate = now.addingTimeInterval(3600 * 24 * 7)
        endDate = endDate.endOfDay

        let schedule = List<RealmTimePoint>()

        var scheduleTime = startDate
        while scheduleTime < endDate {
            schedule.append(
                RealmTimePoint(
                    time: scheduleTime,
                    acceptedType: .undefined
                )
            )
            // move to 8 hours forward
            scheduleTime.addTimeInterval(3600 * 8)
        }

        // external
        var pillType = PillType.tablets
        let unitIndex = Int.random(in: 0..<Text.Unit.allCases.count)

        // usage
        entryExample1 = RealmMedKitEntry(
            name: "Aspirin",
            pillType: .tablets,
            singleDose: 0.5,
            unitString: Text.Unit.allCases[unitIndex].rawValue,
            startDate: startDate,
            takeAtTime: startDate.startOfDay,
            endDate: endDate,
            usage: .whileEating,
            frequency: .daysOfTheWeek,
            note: "",
            schedule: schedule
        )

        pillType = PillType.syringe
        entryExample2 = RealmMedKitEntry(
            name: "Haloperidol",
            pillType: pillType,
            singleDose: 1,
            unitString: Text.Unit.allCases.last?.rawValue ?? "#error",
            startDate: startDate,
            takeAtTime: startDate.startOfDay,
            endDate: endDate,
            usage: .afterMeals,
            frequency: .daysOfTheWeek,
            note:
            "Проглатывать, запивая водой, нельзя принимать одновременно с другими лекарствами, особенно с антибиотиком",
            schedule: schedule
            // concentration: 100,
            // concentrationUnit: .mg,
        )
    }
}
