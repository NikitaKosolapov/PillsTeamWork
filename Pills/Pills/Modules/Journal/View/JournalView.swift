//
//  JournalView.swift
//  Pills
//
//  Created by aprirez on 8/11/21.
//

import UIKit
import FSCalendar
import SnapKit

protocol JournalEventsDelegate: AnyObject {
    func addNewPill()
    func filterEventsByDate(date: Date)
}

// swiftlint:disable type_body_length
final class JournalView: UIView, UIGestureRecognizerDelegate {
    
    // MARK: - Public Properties
    weak var delegate: JournalEventsDelegate?
    var arrayOfEvents = [Date]()
    // MARK: - Private Properties
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.scope = .week
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
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
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
    
    private lazy var scopeGesture: UIPanGestureRecognizer = {
        let panGesture = UIPanGestureRecognizer(target: calendar, action: #selector(calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        return panGesture
    }()
    
    var journalTableView: JournalTableView = {
        let view = JournalTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.white
        return view
    }()
    
     var emptyTableStub: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
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
        button.backgroundColor = AppColors.blue
        return button
    }()
    
    private lazy var stackViewTableViewAndButton: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                journalTableView,
                emptyTableStub
            ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    // MARK: - Override Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        manImageContainer.layer.cornerRadius = manImageContainer.frame.width / 2
        handlePan()
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = journalTableView.contentOffset.y <= -journalTableView.contentInset.top
        
        if shouldBegin {
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
    
    override func updateConstraints() {
        super.updateConstraints()

        calendar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(AppLayout.Journal.Calendar.paddingLeft)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(AppLayout.Journal.Calendar.calendarHeight)
        }
        
        rounderСornersView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(calendar.snp.bottom)
        }
        
        minusView.snp.makeConstraints {
            $0.width.equalTo(AppLayout.Journal.minusViewWidth)
            $0.height.equalTo(AppLayout.Journal.minusViewHeight)
            $0.centerX.equalTo(rounderСornersView.snp.centerX)
            $0.top.equalTo(rounderСornersView.snp.top).offset(AppLayout.Journal.minusViewPaddingTop)
        }
        
        stackViewTableViewAndButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(AppLayout.Journal.paddingRight)
            $0.top.equalTo(calendar.snp.bottom).offset(AppLayout.Journal.stackViewTableViewAndButtonPaddingTop)
        }
        
        addButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(AppLayout.Journal.paddingRight)
            $0.height.equalTo(AppLayout.Journal.heightAddButton)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(AppLayout.Journal.addButtonPaddingBottom)
            $0.top.equalTo(stackViewTableViewAndButton.snp.bottom).offset(AppLayout.Journal.addButtonPaddingTop)
        }
        
        manImageContainer.snp.makeConstraints {
            $0.top.equalToSuperview().inset(AppLayout.Journal.Stub.paddingTop)
            $0.centerX.equalTo(emptyTableStub.snp.centerX)
            $0.size.equalTo(AppLayout.AidKit.widthStubImage)
        }
        
        manImageView.snp.makeConstraints {
            $0.size.equalToSuperview()
        }
        
        manHintTitleLabel.snp.makeConstraints {
            $0.top.equalTo(manImageContainer.snp.bottom).offset(AppLayout.Journal.Stub.spacing)
            $0.leading.trailing.equalToSuperview().inset(AppLayout.Journal.Stub.spacing)
        }
        
        manHintSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(manHintTitleLabel.snp.bottom).offset(AppLayout.Journal.Stub.spacing)
            $0.leading.trailing.equalToSuperview().inset(AppLayout.Journal.Stub.spacing)
        }
        
    }
    
    // MARK: - Public Methods
    
    func setCurrentDate(date: Date) {
        calendar.currentPage = Date()
    }

    func handlePan() {
        let translations = scopeGesture.translation(in: self)
        
        if translations.y <= -AppLayout.Journal.Calendar.headerLabelHeight {
            enabledScope()
        } else if translations.y >= AppLayout.Journal.Calendar.headerLabelHeight {
            enabledScope()
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
        setupView()
        
        // TODO: make visible when table has no data
        // - when mock data will be replaced with real one
    }
    
    @objc func onDebugSwitchView(sender: UIButton!) {
        emptyTableStub.isHidden = !emptyTableStub.isHidden
        journalTableView.isHidden = !journalTableView.isHidden
    }
    
    // MARK: - Private Methods
    
    private func configureFirstDayOfWeek() {
        if calendar.locale.identifier == "ru_US" {
            calendar.firstWeekday = 1
        } else {
            calendar.firstWeekday = 2
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
    
    private func enabledScope() {
        scopeGesture.isEnabled = false
        scopeGesture.isEnabled = true
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
        calendar.appearance.titleFont = AppLayout.Fonts.normalRegular
        calendar.appearance.weekdayFont = AppLayout.Fonts.verySmallRegular
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.titleWeekendColor = AppColors.black
    }
    
    private func selectDay() {
        calendar.appearance.titleTodayColor = AppColors.blue
        calendar.appearance.todayColor = AppColors.white
        calendar.appearance.selectionColor = AppColors.blue
        calendar.appearance.titleSelectionColor = AppColors.whiteOnly
        calendar.appearance.headerTitleColor = AppColors.black
    }
    
    private func setupView() {
        backgroundColor = AppColors.white
    }
    
    private func addSubviews() {
        addSubview(calendar)
        addSubview(rounderСornersView)
        addSubview(minusView)
        addSubview(calendar)
        // TODO: make visible when table has no data
        // - when mock data will be replaced with real one
        addSubview(stackViewTableViewAndButton)
        addSubview(addButton)
        emptyTableStub.addSubview(manImageContainer)
        emptyTableStub.addSubview(manHintTitleLabel)
        emptyTableStub.addSubview(manHintSubtitleLabel)
        manImageContainer.addSubview(manImageView)
    }
}

// MARK: - FSCalendarDelegate, FSCalendarDataSource

extension JournalView: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if arrayOfEvents.contains(date) {
            return 1
        }
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints {
                $0.height.equalTo(bounds.height)
        }
        layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectDay()
        delegate?.filterEventsByDate(date: date)
        calendar.collectionView.reloadItems(at: calendar.collectionView.indexPathsForVisibleItems)
        if journalTableView.visibleCells.isEmpty {
            journalTableView.isHidden = true
            emptyTableStub.isHidden = false
        } else {
            journalTableView.isHidden = false
            emptyTableStub.isHidden = true
        }
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell,
                  for date: Date, at monthPosition: FSCalendarMonthPosition) {
        cell.eventIndicator.color = AppColors.semiGrayOnly
        cell.eventIndicator.isHidden = false
    }
}
