//
//  CalendarViewController.swift
//  Pills
//
//  Created by Rayen on 22.07.2021.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    
    fileprivate weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        calendar.scope = .week

        view.addSubview(calendar)
        self.calendar = calendar
        calendar.scope = .week
        calendar.allowsMultipleSelection = true
//        calendar.firstWeekday = 2
    }
    
}
