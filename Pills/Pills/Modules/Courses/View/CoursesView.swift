//
//  CoursesView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 19.07.2021.
//

import UIKit

class CoursesView: UIView {
    // MARK: - Subviews
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = AppLayout.AidKit.tableEstimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.contentInset = AppLayout.AidKit.tableContentInset
        tableView.backgroundColor = AppColors.AidKit.background
        tableView.isHidden = false
        return tableView
    }()
    
    let stubView: StubCourseView = {
        let view = StubCourseView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = false
        return view
    }()
    
    let addButton: AddButton = {
        let button = AddButton()
        button.setTitleColor(AppColors.AidKit.addButtonText, for: .normal)
        button.backgroundColor = AppColors.AidKit.addButton
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        backgroundColor = AppColors.AidKit.background
        configureTableView()
        configureStubView()
        configureAddButton()
    }
    
    private func configureTableView() {
        addSubview(tableView)
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: AppLayout.AidKit.leadingTableView),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: AppLayout.AidKit.trailingTableView),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,constant: -AppLayout.heightAddButton - AppLayout.AidKit.indentFromBottomAddButton)
        ])
    }
    
    private func configureStubView() {
        addSubview(stubView)
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stubView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stubView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: AppLayout.AidKit.leadingStubView),
            stubView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: AppLayout.AidKit.trailingStubView),
            stubView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,constant: -AppLayout.heightAddButton - AppLayout.AidKit.indentFromBottomAddButton)
        ])
    }
    
    private func configureAddButton() {
        addSubview(addButton)
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: AppLayout.AidKit.leadingAddButtonView),
            addButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: AppLayout.AidKit.trailingAddButtonView),
            addButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -AppLayout.AidKit.indentFromBottomAddButton)
        ])
    }
}
