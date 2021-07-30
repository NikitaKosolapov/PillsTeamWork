//
//  CalendarViewController.swift
//  Pills
//
//  Created by Rayen on 22.07.2021.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var calendarHeighConstraint: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.scope = .week
        calendar.allowsMultipleSelection = true
        return calendar
    }()

    private var journalTableView: JournalTableView = {
        let view = JournalTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self

        return panGesture
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.scrollDirection = .vertical
        view.backgroundColor = .white
        self.view.addGestureRecognizer(self.scopeGesture)
        self.journalTableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.calendar.scope = .week
        addSubviews()
        calendar.allowsMultipleSelection = true
       
        updateViewConstraints()
        journalTableView.configure()
        
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    func addSubviews() {
        view.addSubview(calendar)
        view.addSubview(journalTableView)
        
    }
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeighConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
    
}

extension CalendarViewController : FSCalendarDataSource, FSCalendarDelegate {
    override func updateViewConstraints() {
        super.updateViewConstraints()
        calendarHeighConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeighConstraint)
        NSLayoutConstraint.activate([
            calendar.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            calendar.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 10),
            calendar.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -10),
            
            journalTableView.topAnchor
                .constraint(equalTo: calendar.bottomAnchor, constant: 0),
            journalTableView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 10),
            journalTableView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -10),
            journalTableView.bottomAnchor
                .constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
}
