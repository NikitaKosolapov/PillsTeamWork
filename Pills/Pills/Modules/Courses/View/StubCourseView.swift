//
//  StubCourseView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 01.08.2021.
//

import UIKit
import SnapKit

/// Class contains UI elements for StubView when there is no data
final class StubCourseView: UIView {
    
    // MARK: - Private Properties
    
    private lazy var stubImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = AppImages.AidKit.stubImage
        imageView.backgroundColor = AppColors.lightBlueSapphire
        imageView.layer.cornerRadius = AppLayout.AidKit.heightStubImage / 2
        return imageView
    }()
    
    private lazy var stubInfolabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Text.AidKit.stubText
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = AppLayout.Fonts.bigSemibold
        label.textColor = AppColors.black
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
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
        addSubview(stubImageView)
        addSubview(stubInfolabel)
    }
    
    private func setupLayout() {
        
        stubImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(AppLayout.AidKit.indentImageFromTop)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(AppLayout.AidKit.leadingStubImage)
            $0.width.equalTo(AppLayout.AidKit.widthStubImage)
            $0.height.equalTo(AppLayout.AidKit.heightStubImage)
        }
        
        stubInfolabel.snp.makeConstraints {
            $0.top.equalTo(stubImageView.snp.bottom).offset(AppLayout.AidKit.stubInfoLabelTopAnchor)
            $0.leading.equalTo(layoutMarginsGuide.snp.leading)
            $0.trailing.equalTo(layoutMarginsGuide.snp.trailing)
        }
    }
    
}
