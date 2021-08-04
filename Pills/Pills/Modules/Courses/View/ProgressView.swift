//
//  ProgressView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 31.07.2021.
//

import UIKit

class ProgressView: UIView {
    // MARK: - Properties
    private var progress: CGFloat = UIScreen.main.bounds.width/2
    private var progressViewWidthConstraint: NSLayoutConstraint?
    
    // MARK: - Subviews
    private lazy var progressView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.AidKit.progress
        view.layer.cornerRadius = 10.0
        return view
    }()
    // MARK: - Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    func configure(with model: CourseViewModel) {
        if let progressViewWidthConstraint = self.progressViewWidthConstraint {
            NSLayoutConstraint.deactivate([progressViewWidthConstraint])
        }

        self.progressViewWidthConstraint = progressView.widthAnchor.constraint(equalToConstant: model.widthProgress)

        if let progressViewWidthConstraint = self.progressViewWidthConstraint {
            NSLayoutConstraint.activate([progressViewWidthConstraint])
        }
    }
    
    func resetView() {
        NSLayoutConstraint.activate(
            [progressView.widthAnchor.constraint(equalToConstant: CGFloat(0))])
    }
    
    // MARK: - Configure
    private func configureUI() {
        backgroundColor = AppColors.AidKit.shadowOfCell
        layer.cornerRadius = 10.0
        configureProgressView()
    }
    
    private func configureProgressView() {
        layoutMargins = UIEdgeInsets.zero
        let marginsGuide = layoutMarginsGuide
        addSubview(progressView)
        NSLayoutConstraint.activate(
            [progressView.topAnchor.constraint(equalTo: marginsGuide.topAnchor),
             progressView.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
             progressView.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor)
            ])
    }
}
