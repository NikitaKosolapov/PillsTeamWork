//
//  JournalView.swift
//  Pills
//
//  Created by aprirez on 8/11/21.
//

import UIKit
import FSCalendar

protocol JournalEventsDelegate: AnyObject {
    func addNewPill()
}

// swiftlint:disable type_body_length
class JournalView: UIView, UIGestureRecognizerDelegate {

    private var calendarHeighConstraint: NSLayoutConstraint!
    weak var delegate: JournalEventsDelegate?
    
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.scope = .week
        calendar.placeholderType = .none
        calendar.clipsToBounds = true
        calendar.appearance.headerDateFormat = "LLLL yyyy"
        return calendar
    }()
    
    private lazy var dateFormatter: DateFormatter = {
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
    
    private let showHideButton : UIButton = {
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

    private lazy var addButton: AddButton = {
        let button = AddButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(callAddNewPill), for: .touchUpInside)
        NSLayoutConstraint.activate(
            [button.heightAnchor.constraint(equalToConstant: AppLayout.Journal.heightAddButton)])
        return button
    }()

    @objc func callAddNewPill() {
        delegate?.addNewPill()
    }

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

    private lazy var testDatesWithEvent = [
        "2021-08-03",
        "2021-08-06",
        "2021-08-12",
        "2021-08-25"
    ]

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {

        let shouldBegin = journalTableView.contentOffset.y <= -journalTableView.contentInset.top

        if shouldBegin {
            calendar.currentPage = Date()
            let velocity = scopeGesture.velocity(in: self)

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
    
    private func configureFirstDayOfWeek() {
        if calendar.locale.identifier == "ru_US" {
            calendar.firstWeekday = 2
        } else {
            calendar.firstWeekday = 1
        }
    }

    @objc func showHideButtonTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            self.calendar.currentPage = Date()
        } else {
            calendar.setScope(.week, animated: true)
        }
    }

    private func configureCalendarDefaultUI() {
        calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
        calendar.appearance.weekdayTextColor = AppColors.CalendarColor.weekdayTextColor
        calendar.appearance.selectionColor = AppColors.CalendarColor.selectionDefaultColor
        calendar.appearance.todayColor = AppColors.CalendarColor.todayDeafaultColor
        calendar.appearance.titleTodayColor = AppColors.CalendarColor.titleDefaultTodayColor
        calendar.appearance.titleSelectionColor = AppColors.CalendarColor.titleSelectionDefaultColor
        calendar.appearance.eventDefaultColor = AppColors.CalendarColor.eventDefaultColor
        calendar.appearance.titleWeekendColor = AppColors.CalendarColor.titleWeekendColor
        calendar.appearance.titleFont = UIFont.SFPro17()
        calendar.appearance.weekdayFont = UIFont.SFPro10()
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerTitleColor = AppColors.CalendarColor.headerTitleColor
    }

    private func selectDay() {
        calendar.appearance.titleTodayColor = AppColors.CalendarColor.titleTodayColor
        calendar.appearance.todayColor = AppColors.CalendarColor.todayColor
        calendar.appearance.selectionColor = AppColors.CalendarColor.selectionColor
        calendar.appearance.titleSelectionColor = AppColors.CalendarColor.titleSelectionColor
        calendar.appearance.headerTitleColor = AppColors.CalendarColor.headerTitleColor
    }
 
    func handlePan() {
        if scopeGesture.state == .changed {
            let velocity = scopeGesture.velocity(in: self)
            if  velocity.y < 0 {
                calendar.appearance.headerTitleColor = AppColors.CalendarColor.headerTitleColor
            } else if velocity.y > 0 {
                calendar.appearance.headerTitleColor = AppColors.CalendarColor.headerTitleDefaultColor
            }
            if scopeGesture.state == .cancelled || scopeGesture.state == .failed {
                if calendar.scope == .month {
                    calendar.appearance.headerTitleColor = AppColors.CalendarColor.headerTitleColor
                } else if calendar.scope == .week {
                    calendar.appearance.headerTitleColor = AppColors.CalendarColor.headerTitleDefaultColor
                }
            }
        }
    }

    func configure(tableDataSource: UITableViewDataSource) {
        addGestureRecognizer(scopeGesture)
        journalTableView.panGestureRecognizer.require(toFail: scopeGesture)
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.register(CalendarCell.self, forCellReuseIdentifier: "cell")
        
        configureCalendarDefaultUI()
        configureFirstDayOfWeek()

        journalTableView.configure()
        journalTableView.dataSource = tableDataSource

        addSubviews()

        // TODO: make visible when table has no data
        // - when mock data will be replaced with real one
        emptyTableStub.isHidden = true
    }

    // swiftlint:disable function_body_length
    override func updateConstraints() {
        super.updateConstraints()
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
                .constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            calendar.leadingAnchor
                .constraint(
                    equalTo: self.leadingAnchor,
                    constant: AppLayout.Journal.Calendar.paddingLeft
                ),
            calendar.trailingAnchor
                .constraint(
                    equalTo: self.trailingAnchor,
                    constant: -AppLayout.Journal.Calendar.paddingRight
                ),

            rounderСornersView.topAnchor
                .constraint(equalTo: calendar.bottomAnchor),
            rounderСornersView.leadingAnchor
                .constraint(equalTo: leadingAnchor),
            rounderСornersView.trailingAnchor
                .constraint(equalTo: trailingAnchor),
            rounderСornersView.bottomAnchor
                .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            minusView.topAnchor
                .constraint(equalTo: rounderСornersView.topAnchor),
            minusView.centerXAnchor
                .constraint(equalTo: rounderСornersView.centerXAnchor),
            minusView.widthAnchor.constraint(equalToConstant: 35),
            minusView.heightAnchor.constraint(equalToConstant: 5),

            stackViewTableViewAndButton.topAnchor
                .constraint(equalTo: calendar.bottomAnchor, constant: 16),
            stackViewTableViewAndButton.leadingAnchor
                .constraint(
                    equalTo: self.leadingAnchor,
                    constant: AppLayout.Journal.paddingLeft
                ),
            stackViewTableViewAndButton.trailingAnchor
                .constraint(
                    equalTo: self.trailingAnchor,
                    constant: -AppLayout.Journal.paddingRight
                ),
            stackViewTableViewAndButton.bottomAnchor
                .constraint(
                    equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                    constant: -AppLayout.Journal.paddingBottom
                ),
            
            manImageContainer.topAnchor
                .constraint(
                    equalTo: emptyTableStub.topAnchor,
                    constant: AppLayout.Journal.Stub.paddingTop
                ),
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
                .constraint(
                    equalTo: manImageContainer.bottomAnchor,
                    constant: AppLayout.Journal.Stub.spacing
                ),
            manImageHintHeader.leadingAnchor
                .constraint(
                    equalTo: emptyTableStub.leadingAnchor,
                    constant: AppLayout.Journal.Stub.spacing
                ),
            manImageHintHeader.trailingAnchor
                .constraint(
                    equalTo: emptyTableStub.trailingAnchor,
                    constant: -AppLayout.Journal.Stub.spacing
                ),
            
            manImageHintText.topAnchor
                .constraint(
                    equalTo: manImageHintHeader.bottomAnchor,
                    constant: AppLayout.Journal.Stub.spacing
                ),
            manImageHintText.leadingAnchor
                .constraint(
                    equalTo: emptyTableStub.leadingAnchor,
                    constant: AppLayout.Journal.Stub.spacing
                ),
            manImageHintText.trailingAnchor
                .constraint(
                    equalTo: emptyTableStub.trailingAnchor,
                    constant: -AppLayout.Journal.Stub.spacing
                )
        ])
    }

    func onDebugSwitchView(sender: UIButton!) {
        emptyTableStub.isHidden = !emptyTableStub.isHidden
        journalTableView.isHidden = !journalTableView.isHidden
    }
    
    private func addSubviews() {
        addSubview(calendar)
        addSubview(rounderСornersView)
        addSubview(minusView)
        addSubview(calendar)
        // TODO: make visible when table has no data
        // - when mock data will be replaced with real one
        addSubview(stackViewTableViewAndButton)
        emptyTableStub.addSubview(manImageContainer)
        emptyTableStub.addSubview(manImageHintHeader)
        emptyTableStub.addSubview(manImageHintText)
        manImageContainer.addSubview(manImageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        manImageContainer.layer.cornerRadius = manImageContainer.frame.width / 2
        handlePan()
    }
}

extension JournalView: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeighConstraint.constant = bounds.height
        layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.setScope(.week, animated: true)
        selectDay()
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
}
