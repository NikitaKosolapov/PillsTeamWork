//
//  CoursesView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 19.07.2021.
//

import UIKit
import SnapKit

/// Class contains Ui elements for CoursesViewController
final class CoursesView: UIView {
    
    // MARK: - Public Methods
    
    public let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [Text.AidKit.active, Text.AidKit.completed])
        segmentedControl.setBackgroundImage(UIImage(color: AppColors.whiteOnly), for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(UIImage(color: AppColors.blue), for: .selected, barMetrics: .default)
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = AppColors.semiGrayOnly.cgColor
        segmentedControl.setDividerImage(
            UIImage(color: AppColors.semiGrayOnly),
            forLeftSegmentState: .selected,
            rightSegmentState: .normal,
            barMetrics: .default
        )
        segmentedControl.setDividerImage(
            UIImage(color: AppColors.semiGrayOnly),
            forLeftSegmentState: .normal,
            rightSegmentState: .selected,
            barMetrics: .default
        )
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: AppColors.whiteOnly],
            for: .selected
        )
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: AppColors.semiGrayOnly],
            for: .normal
        )
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    public let coursesTableView: UITableView = {
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
    
    public let coursesStubView: StubCourseView = {
        let view = StubCourseView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    public let addButton: AddButton = {
        let button = AddButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(AppColors.whiteOnly, for: .normal)
        button.backgroundColor = AppColors.blue
        return button
    }()
    
    // MARK: - Private Properties
    
    private var separatorFactory = SeparatorFactory()
    
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            segmentedControl,
            coursesStubView,
            coursesTableView,
            addButton
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = AppLayout.AidKit.mainStackViewSpacing
        return view
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = AppColors.white
    }
    
    private func addSubviews() {
        addSubview(mainStackView)
    }
    
    private func setupLayout() {
        
        segmentedControl.snp.makeConstraints {
            $0.height.equalTo(AppLayout.AidKit.heightSegmentControl)
        }
        
        addButton.snp.makeConstraints {
            $0.height.equalTo(AppLayout.AidKit.heightAddButton)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(AppLayout.AidKit.topInsetStackView)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(AppLayout.AidKit.bottomInsetStackView)
            $0.leading.trailing.equalToSuperview().inset(AppLayout.AidKit.leadingCourseCellView)
        }
    }
    
}
