//
//  AddNewCourseDelegate.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 11.10.2021.
//

import UIKit

/// View Events
protocol AddNewCourseDelegate: AnyObject {
    func onPillNameChanged(_ name: String)
    func onPillTypeChanged(_ type: PillType)
    func onPillDoseChanged(_ dose: Double)
    func onDoseUnitChanged(_ unit: Text.Unit)
    func onPillFreqTypeChanged(_ freq: Frequency)
    func onStartDateChanged(_ date: Date)
    func onStartTimeChanged(_ time: Date)
    func onTakePeriodChanged(_ days: Int)
    func onTakePeriodTill(_ tillDate: Date)
    func onMealDependencyChanged(_ usage: Text.Usage)
    func onCommentChanged(_ text: String)
    func onFrequencyDateChanged(_ frequency: ReceiveFreqPills)
    func onSubmit()
}
