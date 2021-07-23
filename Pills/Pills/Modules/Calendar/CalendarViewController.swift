//
//  CalendarViewController.swift
//  Pills
//
//  Created by Rayen on 22.07.2021.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addSubviews()

        journalTableView.configure()
    }

    func addSubviews() {
        view.addSubview(calendar)
        view.addSubview(journalTableView)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        NSLayoutConstraint.activate([
            calendar.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            calendar.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 10),
            calendar.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -10),
            calendar.bottomAnchor
                .constraint(equalTo: view.bottomAnchor, constant: -10),

            journalTableView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            journalTableView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 10),
            journalTableView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -10),
            journalTableView.bottomAnchor
                .constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }

}
    
