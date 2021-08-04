//
//  JournalViewController.swift
//  Pills
//
//  Created by Rayen on 22.07.2021.
//

import UIKit
import FSCalendar

<<<<<<< HEAD:Pills/Pills/Modules/Calendar/CalendarViewController.swift
class CalendarViewController: UIViewController, UIGestureRecognizerDelegate {
=======
class JournalViewController: UIViewController {
>>>>>>> ac80c3cd9792d9ab10143830a54346901b45a93f:Pills/Pills/Modules/Calendar/JournalViewController.swift
    
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
    
<<<<<<< HEAD:Pills/Pills/Modules/Calendar/CalendarViewController.swift
=======
    @objc func onDebugSwitchView(sender: UIButton!) {
        emptyTableStub.isHidden = !emptyTableStub.isHidden
        journalTableView.isHidden = !journalTableView.isHidden
    }

    private lazy var addButton: AddButton = {
        let button = AddButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onDebugSwitchView), for: .touchUpInside)
        NSLayoutConstraint.activate(
            [button.heightAnchor.constraint(equalToConstant: AppLayout.heightAddButton)])
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
 
>>>>>>> ac80c3cd9792d9ab10143830a54346901b45a93f:Pills/Pills/Modules/Calendar/JournalViewController.swift
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        swipeAction()
        updateViewConstraints()
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
        view.addSubview(stackViewTableViewAndButton)
        emptyTableStub.addSubview(manImageContainer)
        emptyTableStub.addSubview(manImageHintHeader)
        emptyTableStub.addSubview(manImageHintText)
        manImageContainer.addSubview(manImageView)
    }
    
    override func viewDidLayoutSubviews() {
        manImageContainer.layer.cornerRadius = manImageContainer.frame.width / 2
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
<<<<<<< HEAD:Pills/Pills/Modules/Calendar/CalendarViewController.swift
            
            journalTableView.topAnchor
                .constraint(equalTo: calendar.bottomAnchor, constant: 0),
            journalTableView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 10),
            journalTableView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -10),
            journalTableView.bottomAnchor
                .constraint(equalTo: view.bottomAnchor, constant: -10),
            
            emptyTableStub.topAnchor
=======

            stackViewTableViewAndButton.topAnchor
>>>>>>> ac80c3cd9792d9ab10143830a54346901b45a93f:Pills/Pills/Modules/Calendar/JournalViewController.swift
                .constraint(equalTo: calendar.bottomAnchor, constant: 0),
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
