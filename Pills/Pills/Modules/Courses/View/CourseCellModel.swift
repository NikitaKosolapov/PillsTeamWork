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
    var durationOfCourseString: String
    var countPassedDaysString: String
    var widthProgress: CGFloat
}

final class CourseCellModelFactory {
    static func cellModel (from model: Course) -> CourseCellModel {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateStartOfCourse = dateFormatter.string(from: model.dateStartOfCourse)
        let dateEndOfCourse = dateFormatter.string(from: model.dateEndOfCourse)
        let countOfCourseDays = Int(model.dateEndOfCourse.timeIntervalSince(model.dateStartOfCourse)/60/60/24)
        let countOfDaysPassed = countOfCourseDays - Int(model.dateEndOfCourse.timeIntervalSinceNow/60/60/24)
        let widthProgress = CGFloat(countOfDaysPassed)/CGFloat(countOfCourseDays)*AppLayout.AidKit.widthProgressiveView
        return CourseCellModel(
            imagePill: model.imagePill,
            namePill: model.namePill,
            durationOfCourseString: dateStartOfCourse + " - " + dateEndOfCourse,
            countPassedDaysString:  String(countOfDaysPassed) + " " + Text.AidKit.from + " " + String(countOfCourseDays) + " " + Text.AidKit.days,
            widthProgress: widthProgress)
        }
}
