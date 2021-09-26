//
//  AddNewCourseView+PublicInterface.swift
//  Pills
//
//  Created by aprirez on 8/30/21.
//

import Foundation
import UIKit

// public interface
extension AddNewCourseView {
    /// Set pill name
    public func setPillName(_ name: String) {
        pillNameInput.text = name
    }
    /// Set pill type
    public func setPillType(_ type: PillType) {
        pillTypeName.text = type.rawValue.localized()
        typeImage.image = type.image()
    }
    /// Set pill dose
    public func setPillDose(_ dose: Double) {
        doseInput.text = "\(dose)"
    }
    /// Set dose unit
    public func setDoseUnit(_ unit: Text.Unit) {
        doseUnitInput.isUserInteractionEnabled = true
        doseUnitInput.text = unit.rawValue.localized()
    }
    /// Set dose unit selector options
    public func setDoseUnitOptions(_ units: [String]) {
        doseUnitInput.pickerOptions = units
    }
    /// Set taking frequency
    public func setTakeFreq(_ freq: Frequency) {
        frequencyInput.text = freq.rawValue.localized()
    }
    /// Set course start date
    public func setStartDate(_ date: Date) {
        startInput.text = CustomTextField.dateFormatter.string(from: date)
        if let tillDate = takePeriodDatePickerInput.date {
            updateTakePeriodText(fromDate: date, tillDate: tillDate)
        }
    }
    /// Set course start time
    public func setStartTime(_ time: Date) {
        timeInput.text = CustomTextField.timeFormatter.string(from: time)
    }
    /// Set taking period
    public func setTakePeriod(_ days: Int, fromDate: Date) {
        let date = Calendar.current.date(byAdding: .day, value: days, to: fromDate) ?? fromDate
        updateTakePeriodText(fromDate: fromDate, tillDate: date)
    }
    /// Update take period field
    public func updateTakePeriodText(fromDate: Date, tillDate: Date) {
        if (tillDate <= fromDate) {
            takePeriodInput.placeholder = Text.periodExpired
            takePeriodInput.text = ""
            return
        }

        let calendar = Calendar.current
        let dateStart = calendar.startOfDay(for: fromDate)
        let dateEnd = calendar.startOfDay(for: tillDate)

        guard let days =
            calendar.dateComponents(
                [Calendar.Component.day],
                from: dateStart,
                to: dateEnd).day
        else {return}

        let dateString = CustomTextField.dateFormatter.string(from: dateEnd)
        takePeriodInput.text =
            "\(days) \(days.days()), \(Text.till) \(dateString)"
        takePeriodDatePickerInput.date = dateEnd
    }
    /// Set taking meal dependency
    public func setMealDependency(_ mealDependency: Text.Period) {
        mealDependencyInput.text = mealDependency.rawValue.localized()
    }
    /// Set comment
    public func setComment(_ note: String) {
        noteInput.text = note
    }
    /// Set submit button state
    public func setDoneButtonEnabled(_ enabled: Bool) {
        doneButton.isEnabled = enabled
    }
}
