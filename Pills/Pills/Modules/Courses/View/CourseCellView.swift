//
//  CourseCellView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 31.07.2021.
//

import UIKit

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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var durationAndDaysStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
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
        pillImage.image = model.imagePill
        pillNameLabel.text = model.namePill
        durationOfCourseLabel.text = model.durationOfCourseString
        countPassedDaysLabel.text = model.countPassedDaysString
    }
    
    func resetView() {
        pillImage.image = nil
        pillNameLabel.text = nil
        durationOfCourseLabel.text = nil
        countPassedDaysLabel.text = nil
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        backgroundColor = AppColors.lightGray
        layer.cornerRadius = 10
        configureStackView()
        configureVerticalStackView()
        configureDurationAndDaysStackView()
    }
    
    private func configureStackView () {
        pillTypeImageContainer.addSubview(pillImage)
        stackView.addArrangedSubviews(views: pillTypeImageContainer, verticalStackView)
        addSubview(stackView)
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            pillImage.widthAnchor.constraint(equalToConstant: AppLayout.AidKit.pillImageSize.width),
            pillImage.heightAnchor.constraint(equalToConstant: AppLayout.AidKit.pillImageSize.height),
            pillImage.centerXAnchor.constraint(equalTo: pillTypeImageContainer.centerXAnchor),
            pillImage.centerYAnchor.constraint(equalTo: pillTypeImageContainer.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pillTypeImageContainer.widthAnchor.constraint(
                equalToConstant: AppLayout.AidKit.pillImageContainerSize.width
            ),
            pillTypeImageContainer.heightAnchor.constraint(
                equalToConstant: AppLayout.AidKit.pillImageContainerSize.height
            )
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: AppLayout.AidKit.topCourseCellView
            ),
            stackView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: AppLayout.AidKit.leadingCourseCellView
            ),
            stackView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: AppLayout.AidKit.trailingCourseCellView
            ),
            stackView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: AppLayout.AidKit.bottomCourseCellView
            )
        ])
    }
    
    private func configureVerticalStackView () {
        verticalStackView.addArrangedSubviews(views: pillNameLabel, durationAndDaysStackView)
    }
    
    private func configureDurationAndDaysStackView () {
        durationAndDaysStackView.addArrangedSubviews(views: durationOfCourseLabel, countPassedDaysLabel)
    }
    
}
