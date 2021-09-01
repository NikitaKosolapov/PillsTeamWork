//
//  StubCourseView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 01.08.2021.
//

import UIKit

class StubCourseView: UIView {
    // MARK: - Subviews
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = AppImages.AidKit.stubImage
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Text.AidKit.stubText
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "SFCompactDisplay-Semibold", size: 20)
        label.textColor = AppColors.AidKit.stubText
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private public
    private func configureUI() {
        backgroundColor = AppColors.white
        configureImageView()
        configureLabel()
    }
    
    private func configureImageView() {
        let safeArea = safeAreaLayoutGuide
        addSubview(imageView)
        NSLayoutConstraint.activate(
            [imageView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                            constant: AppLayout.AidKit.indentImageFromTop),
             imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                constant: AppLayout.AidKit.leadingStubImage),
             imageView.widthAnchor.constraint(equalToConstant: AppLayout.AidKit.widthStubImage),
             imageView.heightAnchor.constraint(equalToConstant: AppLayout.AidKit.heightStubImage)
            ])
    }
    
    private func configureLabel() {
        let marginGuide = layoutMarginsGuide
        addSubview(label)
        NSLayoutConstraint.activate(
            [label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15.0),
             label.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
             label.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)])
    }
    
}
