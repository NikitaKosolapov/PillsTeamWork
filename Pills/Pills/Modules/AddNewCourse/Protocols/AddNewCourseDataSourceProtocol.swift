//
//  AddNewCourseDataSourceProtocol.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 11.10.2021.
//

import UIKit

/// Data Source
protocol AddNewCourseDataSourceProtocol: AnyObject {
    func pillTypeOptions() -> [String]
    func frequencyOptions() -> [String]
    func mealOptions() -> [String]
}
