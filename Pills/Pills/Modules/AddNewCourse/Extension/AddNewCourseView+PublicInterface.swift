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
        pillNameTextField.text = name
    }
    /// Set pill type
    public func setPillType(_ type: PillType) {
        pillTypeNameTextField.text = type.rawValue.localized()
        typeImage.image = type.image()
    }
    /// Set pill dose
    public func setPillDose(_ dose: Double) {
        doseInputTextField.text = "\(dose)"
    }
    /// Set dose unit
    public func setDoseUnit(_ unit: Text.Unit) {
        doseUnitTextField.isUserInteractionEnabled = true
        doseUnitTextField.text = unit.rawValue.localized()
    }
    /// Set dose unit selector options
    public func setDoseUnitOptions(_ units: [String]) {
        doseUnitTextField.pickerOptions = units
    }
    /// Set taking frequency
    public func setTakeFreq(_ freq: Frequency) {
        frequencyTextField.text = freq.rawValue.localized()
    }
    /// Set course start date
    public func setStartDate(_ date: Date) {
        startTextField.text = CustomTextField.dateFormatter.string(from: date)
        if let tillDate = takePeriodDatePickerTextField.date {
            updateTakePeriodText(fromDate: date, tillDate: tillDate)
        }
    }
    /// Set course start time
    public func setStartTime(_ time: Date) {
        timeTextField.text = CustomTextField.timeFormatter.string(from: time)
    }
    /// Set taking period
    public func setTakePeriod(_ days: Int, fromDate: Date) {
        let date = Calendar.current.date(byAdding: .day, value: days, to: fromDate) ?? fromDate
        updateTakePeriodText(fromDate: fromDate, tillDate: date)
    }
    /// Update take period field
    public func updateTakePeriodText(fromDate: Date, tillDate: Date) {
        if (tillDate <= fromDate) {
            takePeriodTextField.placeholder = Text.periodExpired
            takePeriodTextField.text = ""
            return
        }
        
        let calendar = Calendar.current
        let dateStart = calendar.startOfDay(for: fromDate)
        let dateEnd = calendar.startOfDay(for: tillDate)

        let datesBetween = Date.dates(from: fromDate, to: tillDate)

        datesPeriod = datesBetween
        
        disableWrongButtons(for: daysButtons, on: datesPeriod)
        
        createScheduleDays(from: certainDays, from: datesPeriod)
        
        guard let days =
            calendar.dateComponents(
                [Calendar.Component.day],
                from: dateStart,
                to: dateEnd).day
        else {return}
        
        let dateString = CustomTextField.dateFormatter.string(from: dateEnd)
        takePeriodTextField.text =
        "\(days) \(days.days()), \(Text.till) \(dateString)"
        takePeriodDatePickerTextField.date = dateEnd
    }
    /// Set taking meal dependency
    public func setMealDependency(_ mealDependency: Text.Period) {
        mealDependencyTextField.text = mealDependency.rawValue.localized()
    }
    /// Set comment
    public func setComment(_ note: String) {
        noteInput.text = note
    }
    /// Set submit button state
    public func setDoneButtonEnabled(_ enabled: Bool) {
        saveButton.isEnabled = enabled
    }
}
