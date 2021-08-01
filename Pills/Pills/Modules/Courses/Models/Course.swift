//
//  Course.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 19.07.2021.
//

import Foundation
import UIKit

class Course {
    // MARK: Init
    init(imagePill: UIImage, namePill: String, dateStartOfCourse: Date, dateEndOfCourse: Date) {
        self.imagePill = imagePill
        self.namePill = namePill
        self.dateStartOfCourse = dateStartOfCourse
        self.dateEndOfCourse = dateEndOfCourse
    }
    
    // MARK: Properties
    var imagePill: UIImage
    var namePill: String
    var dateStartOfCourse: Date
    var dateEndOfCourse: Date
}
