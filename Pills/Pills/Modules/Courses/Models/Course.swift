//
//  Course.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 19.07.2021.
//

import Foundation
import UIKit

enum TypeOfCourse {
    case current
    case passed
}

class Course {
    
    // MARK: - Public Properties
    
    var imagePill: UIImage
    var namePill: String
    var dateStartOfCourse: Date
    var dateEndOfCourse: Date
    
    // MARK: - Initializers
    
    init(imagePill: UIImage, namePill: String, dateStartOfCourse: Date, dateEndOfCourse: Date) {
        self.imagePill = imagePill
        self.namePill = namePill
        self.dateStartOfCourse = dateStartOfCourse
        self.dateEndOfCourse = dateEndOfCourse
    }
    
}
