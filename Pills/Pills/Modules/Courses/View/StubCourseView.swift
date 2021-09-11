//
//  StubCourseView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 01.08.2021.
//

import UIKit

final class StubCourseView: UIView {
    
    // MARK: - Private Properties
    
    private lazy var stubImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = AppImages.AidKit.stubImage
        imageView.backgroundColor = AppColors.lightBlueStubImageViewBG
        imageView.layer.cornerRadius = AppLayout.AidKit.heightStubImage / 2
        return imageView
    }()
    
    private lazy var stubInfolabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Text.AidKit.stubText
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "SFCompactDisplay-Semibold", size: 20)
        label.textColor = AppColors.blackStubInfoLabel
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        backgroundColor = AppColors.whiteStubCoursesBG
        configureImageView()
        configureLabel()
    }
    
    private func configureImageView() {
        let safeArea = safeAreaLayoutGuide
        addSubview(stubImageView)
        
        NSLayoutConstraint.activate([
            stubImageView.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: AppLayout.AidKit.indentImageFromTop
            ),
            stubImageView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: AppLayout.AidKit.leadingStubImage
            ),
            stubImageView.widthAnchor.constraint(equalToConstant: AppLayout.AidKit.widthStubImage),
            stubImageView.heightAnchor.constraint(equalToConstant: AppLayout.AidKit.heightStubImage)
        ])
    }
    
    private func configureLabel() {
        let marginGuide = layoutMarginsGuide
        addSubview(stubInfolabel)
        
        NSLayoutConstraint.activate([
            stubInfolabel.topAnchor.constraint(equalTo: stubImageView.bottomAnchor, constant: 15.0
            ),
            stubInfolabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            stubInfolabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
        ])
    }
    
}
