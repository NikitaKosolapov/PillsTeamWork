//
//  CoursesView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 19.07.2021.
//

import UIKit

class CoursesView: UIView {
    // MARK: Properties
    private var separatorFactory = SeparatorFactory()
    
    // MARK: - Subviews
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [Text.AidKit.active, Text.AidKit.completed])
        segmentedControl.selectedSegmentTintColor = AppColors.blue
        segmentedControl.backgroundColor = AppColors.lightGrayOnly
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: AppColors.whiteOnly],
            for: .selected)
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: AppColors.semiGrayOnly],
            for: .normal)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = AppLayout.AidKit.tableEstimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets.zero
        tableView.backgroundColor = AppColors.white
        tableView.isHidden = false
        return tableView
    }()
    
    let stubView: StubCourseView = {
        let view = StubCourseView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let addButton: AddButton = {
        let button = AddButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(AppColors.whiteOnly, for: .normal)
        button.backgroundColor = AppColors.blue
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 0
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureUI
    private func configureUI() {
        backgroundColor = AppColors.white
        configureSegmentedControl()
        configureAddButton()
        configureStackView()
    }
    
    private func configureSegmentedControl() {
        NSLayoutConstraint.activate(
            [segmentedControl.heightAnchor.constraint(equalToConstant: AppLayout.AidKit.heightSegmentControl)])
    }
    
    private func configureAddButton() {
        NSLayoutConstraint.activate(
            [addButton.heightAnchor.constraint(equalToConstant: AppLayout.AidKit.heightAddButton)])
    }
    
    private func configureStackView() {
        stackView.addArrangedSubviews(views: segmentedControl,
                                      stubView,
                                      tableView,
                                      addButton)
        addSubview(stackView)
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 19.0),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: AppLayout.AidKit.leadingStackView),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                constant: AppLayout.AidKit.trailingStackView),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                              constant: -AppLayout.AidKit.indentFromBottomAddButton)
        ])
    }
}
