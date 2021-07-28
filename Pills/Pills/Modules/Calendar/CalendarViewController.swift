//
//  CalendarViewController.swift
//  Pills
//
//  Created by Rayen on 22.07.2021.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    
    var calendarHeighConstraint: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.scope = .week
        calendar.allowsMultipleSelection = true
        return calendar
    }()
    
    let showHideButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var journalTableView: JournalTableView = {
        let view = JournalTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        swipeAction()
        updateViewConstraints()
        journalTableView.configure()
        
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    @objc func showHideButtonTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            self.calendar.currentPage = Date() 
        } else {
            calendar.setScope(.week, animated: true)
        }
    }
    func swipeAction() {
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
        
    }
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case .up:
            showHideButtonTapped()
        case .down:
            showHideButtonTapped()
        default:
            break
        }
    }
    
    func addSubviews() {
        view.addSubview(calendar)
        view.addSubview(journalTableView)
        
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

extension CalendarViewController {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeighConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
}
