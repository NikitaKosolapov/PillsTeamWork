//
//  ProgressView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 31.07.2021.
//

import UIKit

final class ProgressView: UIView {
    
    // MARK: - Private Properties
    
    private var progress: CGFloat = AppLayout.halfWidthScreen
    private var progressViewWidthConstraint: NSLayoutConstraint?
    
    private lazy var progressView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.blue
        view.layer.cornerRadius = 10.0
        return view
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
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
        NSLayoutConstraint.activate([
            progressView.widthAnchor.constraint(equalToConstant: CGFloat(0))
        ])
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        backgroundColor = AppColors.semiGrayProgressViewBG
        layer.cornerRadius = 10.0
        configureProgressView()
    }
    
    private func configureProgressView() {
        layoutMargins = UIEdgeInsets.zero
        let marginsGuide = layoutMarginsGuide
        addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: marginsGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            progressView.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor)
        ])
    }
    
}
