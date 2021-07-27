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
        return calendar
    }()

    let showHideButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let idMedicationCell = "idMedicationCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        calendar.backgroundColor = .white
        calendar.appearance.todayColor = .blue
        calendar.appearance.selectionColor = .white
        calendar.appearance.titleSelectionColor = .blue
        calendar.allowsMultipleSelection = true

        calendar.delegate = self
        calendar.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TakingMedicationCell.self, forCellReuseIdentifier: idMedicationCell)
        calendar.scope = .week
//        calendar.scrollDirection = .vertical // bad
        setConstraints()
        swipeAction()

//        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)

    }
    @objc func showHideButtonTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            self.calendar.currentPage = Date()
            showHideButton.setTitle("roll up", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle("", for: .normal)
            self.calendar.currentPage = Date()
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
}
extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: idMedicationCell, for: indexPath) as? TakingMedicationCell {
            return cell}
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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

extension CalendarViewController : FSCalendarDataSource, FSCalendarDelegate {

        func setConstraints() {
            
            view.addSubview(calendar)
            calendarHeighConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
            calendar.addConstraint(calendarHeighConstraint)
            NSLayoutConstraint.activate([
                calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
                calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
            ])

//        view.addSubview(showHideButton)

//        NSLayoutConstraint.activate([
//            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
//            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            showHideButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            showHideButton.widthAnchor.constraint(equalToConstant: 100),
//            showHideButton.heightAnchor.constraint(equalToConstant: 20)
//        ])
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            
        ])

    }
}
