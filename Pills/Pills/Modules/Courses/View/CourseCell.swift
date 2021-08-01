//
//  CoursesCell.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 21.07.2021.
//

import UIKit

class CourseCell: UITableViewCell {
    // MARK: - Subview
    private lazy var mainView: MainView = {
        let view = MainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var progressView: ProgressView = {
        let view = ProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Public Methods
    func configure(with model: CourseCellModel) {
        mainView.configure(with: model)
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
    override func prepareForReuse() {
        mainView.resetView()
        progressView.resetView()
    }
    
    private func configureUI () {
        backgroundColor = AppColors.AidKit.background
        configureContentView()
        configureProgressView()
        configureMainView()
    }
    
    private func configureContentView () {
        contentView.backgroundColor = AppColors.AidKit.background
        contentView.layoutMargins = UIEdgeInsets.zero
    }
    
    private func configureProgressView () {
        let safeArea = contentView.safeAreaLayoutGuide
        let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(progressView)
        NSLayoutConstraint.activate(
            [progressView.topAnchor.constraint(equalTo: marginGuide.topAnchor),
             progressView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             progressView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
             progressView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor)
            ])
        
    }
    
    private func configureMainView () {
        let safeArea = contentView.safeAreaLayoutGuide
        let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(mainView)
        NSLayoutConstraint.activate(
            [mainView.topAnchor.constraint(equalTo: marginGuide.topAnchor),
             mainView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             mainView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
             mainView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -10)
            ])
    }
}
