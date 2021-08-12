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
        calendar.allowsMultipleSelection = true
        return calendar
    }()
    
    private var rounderСornersView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var minusView: UIView =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.AidKit.shadowOfCell
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        swipeAction()
        shadowRounder()

        self.view.addGestureRecognizer(self.scopeGesture)
        self.journalTableView.panGestureRecognizer.require(toFail: self.scopeGesture)

        journalTableView.configure()
        
        calendar.delegate = self
        calendar.dataSource = self
        
        // TODO: make visible when table has no data
        // - when mock data will be replaced with real one
        emptyTableStub.isHidden = true
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.journalTableView.contentOffset.y <= -self.journalTableView.contentInset.top
        if shouldBegin {
            self.calendar.currentPage = Date()
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
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
    
    @objc func showHideButtonTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            self.calendar.currentPage = Date()
        } else {
            calendar.setScope(.week, animated: true)
        }
    }
    
    func shadowRounder() {
        rounderСornersView.layer.shadowColor = AppColors.AidKit.shadowOfCell.cgColor
        rounderСornersView.layer.shadowOpacity = 1
        rounderСornersView.layer.shadowOffset = .zero
        rounderСornersView.layer.shadowRadius = 3
        rounderСornersView.backgroundColor = AppColors.white
        rounderСornersView.translatesAutoresizingMaskIntoConstraints = false
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
        minusView.translatesAutoresizingMaskIntoConstraints = false
        minusView.backgroundColor = AppColors.AidKit.shadowOfCell
        manImageContainer.layer.cornerRadius = manImageContainer.frame.width / 2
        rounderСornersView.layer.cornerRadius = 14
        minusView.layer.cornerRadius = minusView.frame.height / 2
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
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
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

extension JournalViewController {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeighConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
}
