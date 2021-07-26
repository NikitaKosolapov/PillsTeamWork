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
                    isUsed: scheduleTime < now ? true : false
                )
            )
            // move to 8 hours forward
            scheduleTime.addTimeInterval(3600 * 8)
        }

        entryExample1 = RealmMedKitEntry(
            name: "Aspirin",
            pillType: .tablets,
            singleDose: 0.5,
            unit: .pill,
            usage: .whileEating,
            comments: "",
            startDate: startDate,
            endDate: endDate,
            schedule: schedule
        )

        entryExample2 = RealmMedKitEntry(
            name: "Haloperidol",
            pillType: .capsules,
            singleDose: 1,
            unit: .pill,
            usage: .afterMeals,
            comments: "",
            startDate: startDate,
            endDate: endDate,
            schedule: schedule
        )
    }
}
