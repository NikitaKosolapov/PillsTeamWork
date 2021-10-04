//
//  CourseCellView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 31.07.2021.
//

import UIKit
import SnapKit

/// Class contains UI elements for CourseCellView
final class CourseCellView: UIView {
    
    // MARK: - Private Properties
    
    private lazy var pillImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var pillTypeImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.whiteOnly
        view.layer.cornerRadius = AppLayout.AidKit.pillImageContainerRadius
        return view
    }()
    
    private lazy var pillNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = AppLayout.Fonts.normalSemibold
        label.textColor = AppColors.black
        return label
    }()
    
    private lazy var durationOfCourseLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = AppLayout.Fonts.smallRegular
        label.textColor = AppColors.black
        return label
    }()
    
    private lazy var countPassedDaysLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = AppLayout.Fonts.verySmallRegular
        label.textColor = AppColors.semiGrayFont
        return label
    }()
    
    private lazy var durationAndDaysStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [durationOfCourseLabel, countPassedDaysLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = AppLayout.AidKit.durationAndDaysStackViewSpacing
        return stackView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pillNameLabel, durationAndDaysStackView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pillTypeImageContainer, verticalStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = AppLayout.AidKit.mainCoursesCellStackViewSpacing
        return stackView
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
    
    // MARK: - Public Methods
    
    public func configure(with model: CourseViewModel) {
        pillImage.image = model.imagePill
        pillNameLabel.text = model.namePill
        durationOfCourseLabel.text = model.durationOfCourseString
        countPassedDaysLabel.text = model.countPassedDaysString
    }
    
    public func resetView() {
        pillImage.image = nil
        pillNameLabel.text = nil
        durationOfCourseLabel.text = nil
        countPassedDaysLabel.text = nil
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = AppColors.lightGray
        layer.cornerRadius = 10
    }
    
    private func addSubviews() {
        addSubview(mainStackView)
        pillTypeImageContainer.addSubview(pillImage)
    }
    
    private func setupLayout() {
        
        pillImage.snp.makeConstraints {
            $0.width.equalTo(AppLayout.AidKit.pillImageSize.width)
            $0.height.equalTo(AppLayout.AidKit.pillImageSize.height)
            $0.centerX.equalTo(pillTypeImageContainer.snp.centerX)
            $0.centerY.equalTo(pillTypeImageContainer.snp.centerY)
        }
        
        pillTypeImageContainer.snp.makeConstraints {
            $0.width.equalTo(AppLayout.AidKit.pillImageContainerSize.width)
            $0.height.equalTo(AppLayout.AidKit.pillImageContainerSize.height)
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(AppLayout.AidKit.topCourseCellView)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(AppLayout.AidKit.leadingCourseCellView)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(AppLayout.AidKit.trailingCourseCellView)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(AppLayout.AidKit.bottomCourseCellView)
        }
    }
    
}
