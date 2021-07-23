//
//  CourseCellModel.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 21.07.2021.
//

import Foundation
import UIKit
struct CourseCellModel {
    var imagePill: UIImage
    var namePill: String
    var durationOfCourse: String
    var passedDaysLabel: String
    var passedDosesLabel: String
    var typeOfDose: String
}

final class CourseCellModelFactory {
    static func cellModel (from model: Course) -> CourseCellModel {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateStartOfCourse = dateFormatter.string(from: model.dateStartOfCourse)
        let dateEndOfCourse = dateFormatter.string(from: model.dateEndOfCourse)
        let countOfCourseDays = Int(model.dateEndOfCourse.timeIntervalSince(model.dateStartOfCourse)/60/60/24)
        let countOfDaysPassed = Int(model.dateEndOfCourse.timeIntervalSinceNow/60/60/24)
        return CourseCellModel(
            imagePill: model.imagePill,
            namePill: model.namePill,
            durationOfCourse: dateStartOfCourse + " - " + dateEndOfCourse,
            passedDaysLabel: String(countOfDaysPassed) + "/" + String(countOfCourseDays),
            passedDosesLabel: String(Int(model.countOfDosesPassed)) + "/" + String(Int(model.countOfCourseDoses)),
            typeOfDose: model.typeOfDose)
    }
}
