//
//  CourseCellModel.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 21.07.2021.
//

import Foundation
import UIKit

struct CourseViewModel {
    var imagePill: UIImage
    var namePill: String
    var durationOfCourseString: String
    var countPassedDaysString: String
    var widthProgress: CGFloat
}

final class CourseViewModelFactory {
    static func cellModel (from model: Course) -> CourseViewModel {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        let dateStartOfCourse = dateFormatter.string(from: model.dateStartOfCourse)
        let dateEndOfCourse = dateFormatter.string(from: model.dateEndOfCourse)
        let countOfCourseDays = Int(model.dateEndOfCourse.timeIntervalSince(model.dateStartOfCourse)/60/60/24)
        var countOfDaysPassed = countOfCourseDays - Int(model.dateEndOfCourse.timeIntervalSinceNow/60/60/24)
        if countOfDaysPassed > countOfCourseDays {
            countOfDaysPassed = countOfCourseDays
        }
        
        let widthProgress = CGFloat(countOfDaysPassed)/CGFloat(countOfCourseDays)*AppLayout.AidKit.widthProgressiveView
        return CourseViewModel(
            imagePill: model.imagePill,
            namePill: model.namePill,
            durationOfCourseString: dateStartOfCourse + " - " + dateEndOfCourse,
            countPassedDaysString:  String(countOfDaysPassed) + " " + Text.AidKit.from +
                " " + String(countOfCourseDays) + " " + Text.AidKit.days,
            widthProgress: widthProgress)
        }
}
