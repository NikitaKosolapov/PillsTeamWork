//
//  CoursesCell.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 21.07.2021.
//

import UIKit

class CourseCell: UITableViewCell {
    // MARK: - Subview
    private lazy var courseCellView: CourseCellView = {
        let view = CourseCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var progressView: ProgressView = {
        let view = ProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Public Methods
    func configure(with model: CourseViewModel) {
        courseCellView.configure(with: model)
        progressView.configure(with: model)
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureUI
    private func configureUI () {
        backgroundColor = AppColors.white
        configureContentView()
        configureProgressView()
        configureMainView()
    }
    
    private func configureContentView () {
        contentView.backgroundColor = AppColors.white
    }
    
    private func configureProgressView () {
        let safeArea = contentView.safeAreaLayoutGuide
        contentView.addSubview(progressView)
        NSLayoutConstraint.activate(
            [progressView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                               constant: AppLayout.AidKit.widthIndentBetweenCells +
                                                AppLayout.AidKit.heightVisiblePartOfProgressView),
             progressView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             progressView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
             progressView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            ])
    }
    
    private func configureMainView () {
        let safeArea = contentView.safeAreaLayoutGuide
        contentView.addSubview(courseCellView)
        NSLayoutConstraint.activate(
            [courseCellView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                                 constant: AppLayout.AidKit.widthIndentBetweenCells),
             courseCellView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             courseCellView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
             courseCellView.bottomAnchor.constraint(equalTo: progressView.safeAreaLayoutGuide.bottomAnchor,
                                              constant: -AppLayout.AidKit.heightVisiblePartOfProgressView)
            ])
    }
}
