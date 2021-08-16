//
//  JournalViewController.swift
//  Pills
//
//  Created by Rayen on 22.07.2021.
//

import UIKit
import FSCalendar

class JournalViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var calendarHeighConstraint: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.scope = .week
        calendar.placeholderType = .none
        calendar.clipsToBounds = true
        calendar.appearance.headerDateFormat = "LLLL yyyy"
        return calendar
    }()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private var rounderСornersView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = AppColors.AidKit.shadowOfCell.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 3
        view.backgroundColor = AppColors.white
        view.layer.cornerRadius = 14
        return view
    }()
    
    private lazy var minusView: UIView =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.AidKit.shadowOfCell
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    let showHideButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        let panGesture = UIPanGestureRecognizer(target: calendar, action: #selector(calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        return panGesture
    }()
    
    private var journalTableView: JournalTableView = {
        let view = JournalTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var emptyTableStub: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var manImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.cellBackgroundColor
        return view
    }()
    
    private var manImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "man")
        return view
    }()
    
    private var manImageHintHeader: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = Text.takePillsInTime
        view.font = AppLayout.Fonts.bigSemibold
        view.textAlignment = .center
        return view
    }()
    
    private var manImageHintText: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = Text.justAddAnOrder
        view.font = AppLayout.Fonts.normalRegular
        view.textAlignment = .center
        return view
    }()
    
    @objc func onDebugSwitchView(sender: UIButton!) {
        emptyTableStub.isHidden = !emptyTableStub.isHidden
        journalTableView.isHidden = !journalTableView.isHidden
    }
    
    private lazy var addButton: AddButton = {
        let button = AddButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onDebugSwitchView), for: .touchUpInside)
        NSLayoutConstraint.activate(
            [button.heightAnchor.constraint(equalToConstant: AppLayout.Journal.heightAddButton)])
        return button
    }()
    
    private lazy var stackViewTableViewAndButton: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                journalTableView,
                emptyTableStub,
                addButton
            ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var testDatesWithEvent = ["2021-08-03", "2021-08-06", "2021-08-12", "2021-08-25"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        firstDayWeek()
        calendarDefaultUI()
        view.addGestureRecognizer(scopeGesture)
        journalTableView.panGestureRecognizer.require(toFail: scopeGesture)
        calendar.register(CalendarCell.self, forCellReuseIdentifier: "cell")
        journalTableView.configure()
        calendar.delegate = self
        calendar.dataSource = self
        
        // TODO: make visible when table has no data
        // - when mock data will be replaced with real one
        emptyTableStub.isHidden = true
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = journalTableView.contentOffset.y <= -journalTableView.contentInset.top
        if shouldBegin {
            let velocity = scopeGesture.velocity(in: view)
            switch calendar.scope {
            case .month:
                
                return velocity.y < 0
            case .week:
                
                return velocity.y > 0
            @unknown default:
                fatalError()
            }
            
        }
        return shouldBegin
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = dateFormatter.string(from: date)
        if self.testDatesWithEvent.contains(dateString) {
            return 1
        }
        return 0
    }
    
    private func firstDayWeek() {
        if calendar.locale.identifier == "ru_US" {
            calendar.firstWeekday = 2
        } else {
            calendar.firstWeekday = 1
        }
        
    }
    
    private func calendarDefaultUI() {
        calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
        calendar.appearance.weekdayTextColor = UIColor.weekdayTextColor()
        calendar.appearance.selectionColor = UIColor.selectionDefaultColor()
        calendar.appearance.todayColor = UIColor.todayDeafaultColor()
        calendar.appearance.titleTodayColor = UIColor.titleDefaultTodayColor()
        calendar.appearance.titleSelectionColor = UIColor.titleSelectionDefaultColor()
        calendar.appearance.eventDefaultColor = UIColor.eventDefaultColor()
        calendar.appearance.titleWeekendColor = UIColor.titleWeekendColor()
        calendar.appearance.titleFont = UIFont.SFPro17()
        calendar.appearance.weekdayFont = UIFont.SFPro10()
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerTitleColor = UIColor.headerTitleColor()
    }
    private func selectDay() {
        calendar.appearance.titleTodayColor = UIColor.titleTodayColor()
        calendar.appearance.todayColor = UIColor.todayColor()
        calendar.appearance.selectionColor = UIColor.selectionColor()
        calendar.appearance.titleSelectionColor = UIColor.titleSelectionColor()
        calendar.appearance.headerTitleColor = UIColor.headerTitleColor()
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeighConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func handlePan() {
        if scopeGesture.state == .changed {
            let velocity = scopeGesture.velocity(in: view)
            if  velocity.y < 0 {
                calendar.appearance.headerTitleColor = UIColor.headerTitleColor()
            } else if velocity.y > 0 {
                calendar.appearance.headerTitleColor = UIColor.headerTitleDefaultColor()
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.setScope(.week, animated: true)
        selectDay()
    }
    
    func addSubviews() {
        view.addSubview(calendar)
        view.addSubview(rounderСornersView)
        view.addSubview(minusView)
        view.addSubview(calendar)
        // TODO: make visible when table has no data
        // - when mock data will be replaced with real one
        view.addSubview(stackViewTableViewAndButton)
        emptyTableStub.addSubview(manImageContainer)
        emptyTableStub.addSubview(manImageHintHeader)
        emptyTableStub.addSubview(manImageHintText)
        manImageContainer.addSubview(manImageView)
    }
    
    override func viewDidLayoutSubviews() {
        manImageContainer.layer.cornerRadius = manImageContainer.frame.width / 2
        handlePan()
    }
}

// swiftlint:disable function_body_length
extension JournalViewController : FSCalendarDataSource, FSCalendarDelegate {
    override func updateViewConstraints() {
        super.updateViewConstraints()
        calendarHeighConstraint = NSLayoutConstraint(
            item: calendar,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 300
        )
        
        NSLayoutConstraint.activate([
            calendarHeighConstraint,
            
            calendar.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            calendar.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 10),
            calendar.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -10),
            
            rounderСornersView.topAnchor
                .constraint(equalTo: calendar.bottomAnchor, constant: 0),
            rounderСornersView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 0),
            rounderСornersView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: 0),
            rounderСornersView.bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            minusView.topAnchor
                .constraint(equalTo: rounderСornersView.topAnchor, constant: 6),
            minusView.centerXAnchor
                .constraint(equalTo: rounderСornersView.centerXAnchor),
            minusView.widthAnchor.constraint(equalToConstant: 35),
            minusView.heightAnchor.constraint(equalToConstant: 5),
            
            stackViewTableViewAndButton.topAnchor
                .constraint(equalTo: calendar.bottomAnchor, constant: 20),
            stackViewTableViewAndButton.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 10),
            stackViewTableViewAndButton.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -10),
            stackViewTableViewAndButton.bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            manImageContainer.topAnchor
                .constraint(equalTo: emptyTableStub.topAnchor, constant: 30),
            manImageContainer.centerXAnchor
                .constraint(equalTo: emptyTableStub.centerXAnchor),
            manImageContainer.widthAnchor
                .constraint(equalTo: emptyTableStub.widthAnchor, multiplier: 0.5),
            manImageContainer.heightAnchor
                .constraint(equalTo: emptyTableStub.widthAnchor, multiplier: 0.5),
            
            manImageView.widthAnchor
                .constraint(equalTo: manImageContainer.widthAnchor),
            manImageView.heightAnchor
                .constraint(equalTo: manImageContainer.heightAnchor),
            
            manImageHintHeader.topAnchor
                .constraint(equalTo: manImageContainer.bottomAnchor, constant: 16),
            manImageHintHeader.leadingAnchor
                .constraint(equalTo: emptyTableStub.leadingAnchor, constant: 16),
            manImageHintHeader.trailingAnchor
                .constraint(equalTo: emptyTableStub.trailingAnchor, constant: -16),
            
            manImageHintText.topAnchor
                .constraint(equalTo: manImageHintHeader.bottomAnchor, constant: 16),
            manImageHintText.leadingAnchor
                .constraint(equalTo: emptyTableStub.leadingAnchor, constant: 16),
            manImageHintText.trailingAnchor
                .constraint(equalTo: emptyTableStub.trailingAnchor, constant: -16)
        ])
    }
}
