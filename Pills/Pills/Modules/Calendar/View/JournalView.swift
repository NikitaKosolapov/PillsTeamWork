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
final class JournalView: UIView, UIGestureRecognizerDelegate {
    
    // MARK: - Public Properties
    
    weak var delegate: JournalEventsDelegate?
    
    // MARK: - Private Properties
    
    private var calendarHeighConstraint: NSLayoutConstraint!
    
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
        view.layer.shadowColor = AppColors.semiGrayOnly.cgColor
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
        view.backgroundColor = AppColors.semiGrayOnly
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
    
    public var journalTableView: JournalTableView = {
        let view = JournalTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.white
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
        view.backgroundColor = AppColors.lightBlueSapphire
        return view
    }()
    
    private var manImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "man")
        return view
    }()
    
    private var manHintTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Text.takePillsInTime
        label.font = AppLayout.Fonts.bigSemibold
        label.textAlignment = .center
        label.textColor = AppColors.black
        return label
    }()
    
    private var manHintSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Text.justAddAnOrder
        label.font = AppLayout.Fonts.normalRegular
        label.textAlignment = .center
        label.textColor = AppColors.black
        return label
    }()
    
    private lazy var addButton: AddButton = {
        let button = AddButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(AppColors.whiteOnly, for: .normal)
        // Add onDebugSwitchView instead callAddNewPill for debugging
        button.addTarget(self, action: #selector(callAddNewPill), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: AppLayout.Journal.heightAddButton)
        ])
        button.backgroundColor = AppColors.blue
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
    
    private lazy var testDatesWithEvent = [
        "2021-08-03",
        "2021-08-06",
        "2021-08-12",
        "2021-08-25"
    ]
    
    // MARK: - Override Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        manImageContainer.layer.cornerRadius = manImageContainer.frame.width / 2
        handlePan()
    }
    
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
    
    // swiftlint:disable function_body_length
    override func updateConstraints() {
        backgroundColor = AppColors.white
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
            calendar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            calendar.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: AppLayout.Journal.Calendar.paddingLeft
            ),
            calendar.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -AppLayout.Journal.Calendar.paddingRight
            ),
            
            rounderСornersView.topAnchor.constraint(equalTo: calendar.bottomAnchor),
            rounderСornersView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rounderСornersView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rounderСornersView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            minusView.topAnchor.constraint(equalTo: rounderСornersView.topAnchor),
            minusView.centerXAnchor.constraint(equalTo: rounderСornersView.centerXAnchor),
            minusView.widthAnchor.constraint(equalToConstant: 35),
            minusView.heightAnchor.constraint(equalToConstant: 5),
            
            stackViewTableViewAndButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 16),
            stackViewTableViewAndButton.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: AppLayout.Journal.paddingLeft
            ),
            stackViewTableViewAndButton.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -AppLayout.Journal.paddingRight
            ),
            stackViewTableViewAndButton.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -AppLayout.Journal.paddingBottom
            ),
            
            manImageContainer.topAnchor.constraint(
                equalTo: emptyTableStub.topAnchor,
                constant: AppLayout.Journal.Stub.paddingTop
            ),
            manImageContainer.centerXAnchor.constraint(equalTo: emptyTableStub.centerXAnchor),
            manImageContainer.widthAnchor.constraint(equalTo: emptyTableStub.widthAnchor, multiplier: 0.5),
            manImageContainer.heightAnchor.constraint(equalTo: emptyTableStub.widthAnchor, multiplier: 0.5),
            
            manImageView.widthAnchor.constraint(equalTo: manImageContainer.widthAnchor),
            manImageView.heightAnchor.constraint(equalTo: manImageContainer.heightAnchor),
            
            manHintTitleLabel.topAnchor.constraint(
                equalTo: manImageContainer.bottomAnchor,
                constant: AppLayout.Journal.Stub.spacing
            ),
            manHintTitleLabel.leadingAnchor.constraint(
                equalTo: emptyTableStub.leadingAnchor,
                constant: AppLayout.Journal.Stub.spacing
            ),
            manHintTitleLabel.trailingAnchor.constraint(
                equalTo: emptyTableStub.trailingAnchor,
                constant: -AppLayout.Journal.Stub.spacing
            ),
            
            manHintSubtitleLabel.topAnchor.constraint(
                equalTo: manHintTitleLabel.bottomAnchor,
                constant: AppLayout.Journal.Stub.spacing
            ),
            manHintSubtitleLabel.leadingAnchor.constraint(
                equalTo: emptyTableStub.leadingAnchor,
                constant: AppLayout.Journal.Stub.spacing
            ),
            manHintSubtitleLabel.trailingAnchor.constraint(
                equalTo: emptyTableStub.trailingAnchor,
                constant: -AppLayout.Journal.Stub.spacing
            )
        ])
    }
    
    // MARK: - Public Methods
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = dateFormatter.string(from: date)
        if self.testDatesWithEvent.contains(dateString) {
            return 1
        }
        return 0
    }
    
    func handlePan() {
        if scopeGesture.state == .changed {
            let velocity = scopeGesture.velocity(in: self)
            if  velocity.y < 0 {
                calendar.appearance.headerTitleColor = AppColors.black
            } else if velocity.y > 0 {
                calendar.appearance.headerTitleColor = AppColors.black
            }
            if scopeGesture.state == .cancelled || scopeGesture.state == .failed {
                if calendar.scope == .month {
                    calendar.appearance.headerTitleColor = AppColors.black
                } else if calendar.scope == .week {
                    calendar.appearance.headerTitleColor = AppColors.black
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
    
    @objc func onDebugSwitchView(sender: UIButton!) {
        emptyTableStub.isHidden = !emptyTableStub.isHidden
        journalTableView.isHidden = !journalTableView.isHidden
    }
    
    // MARK: - Private Methods
    
    private func configureFirstDayOfWeek() {
        if calendar.locale.identifier == "ru_US" {
            calendar.firstWeekday = 2
        } else {
            calendar.firstWeekday = 1
        }
    }
    
    @objc private func callAddNewPill() {
        delegate?.addNewPill()
    }
    
    @objc private func showHideButtonTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            self.calendar.currentPage = Date()
        } else {
            calendar.setScope(.week, animated: true)
        }
    }
    
    private func configureCalendarDefaultUI() {
        calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
        calendar.appearance.headerTitleColor = AppColors.black
        calendar.appearance.weekdayTextColor = AppColors.black
        
        calendar.appearance.titleDefaultColor = AppColors.black
        calendar.appearance.selectionColor = AppColors.whiteOnly
        calendar.appearance.todayColor = AppColors.blue
        calendar.appearance.titleTodayColor = AppColors.white
        calendar.appearance.titleSelectionColor = AppColors.black
        calendar.appearance.eventDefaultColor = AppColors.semiBlack
        calendar.appearance.titleWeekendColor = AppColors.semiGrayOnly
        calendar.appearance.titleFont = UIFont.SFPro17()
        calendar.appearance.weekdayFont = UIFont.SFPro10()
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
    }
    
    private func selectDay() {
        calendar.appearance.titleTodayColor = AppColors.blue
        calendar.appearance.todayColor = AppColors.white
        calendar.appearance.selectionColor = AppColors.blue
        calendar.appearance.titleSelectionColor = AppColors.whiteOnly
        calendar.appearance.headerTitleColor = AppColors.black
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
        emptyTableStub.addSubview(manHintTitleLabel)
        emptyTableStub.addSubview(manHintSubtitleLabel)
        manImageContainer.addSubview(manImageView)
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
