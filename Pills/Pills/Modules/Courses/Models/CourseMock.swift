//
//  CourseMock.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 03.08.2021.
//

import Foundation
import UIKit

final class CourseMock {
    // MARK: - Properties
    static let shared = CourseMock()
    var coursesCurrent: [Course]
    var coursesPassed: [Course]
    
    // MARK: - Init
    private init() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        var startDate = dateFormatter.date(from: "01.01.2021")!
        var endDate = dateFormatter.date(from: "01.09.2022")!
        let firstCurrentCourse = Course(
            imagePill: AppImages.Pills.tablets ?? UIImage(),
            namePill: "Valium",
            dateStartOfCourse: startDate,
            dateEndOfCourse: endDate)
        let secondCurrentCourse = Course(
            imagePill: AppImages.Pills.tablets ?? UIImage(),
            namePill: "Gydroxizin",
            dateStartOfCourse: startDate,
            dateEndOfCourse: endDate)
        let thirdCurrentCourse = Course(
            imagePill: AppImages.Pills.tablets ?? UIImage(),
            namePill: "Sulpirid",
            dateStartOfCourse: startDate,
            dateEndOfCourse: endDate)
        coursesCurrent = [firstCurrentCourse, secondCurrentCourse, thirdCurrentCourse]
        
        startDate = dateFormatter.date(from: "01.01.2021")!
        endDate = dateFormatter.date(from: "10.08.2021")!
        let firstPassedCourse = Course(
            imagePill: AppImages.Pills.tablets ?? UIImage(),
            namePill: "Sulpirid",
            dateStartOfCourse: startDate,
            dateEndOfCourse: endDate)
        let secondPassedCourse = Course(
            imagePill: AppImages.Pills.tablets ?? UIImage(),
            namePill: "Donormil",
            dateStartOfCourse: startDate,
            dateEndOfCourse: endDate)
        coursesPassed = [firstPassedCourse, secondPassedCourse]
    }
}
