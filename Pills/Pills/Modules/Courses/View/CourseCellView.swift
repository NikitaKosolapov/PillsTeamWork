//
//  CourseCellView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 31.07.2021.
//

import UIKit

class CourseCellView: UIView {
    // MARK: - Properties
    private var separatorFactoryAbstract = SeparatorFactory()
    
    // MARK: - SubView
    private lazy var pillImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var pillNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "SFCompactDisplay-Semibold", size: 17)
        label.textColor = AppColors.AidKit.cellTextName
        return label
    }()
    
    private lazy var durationOfCourseLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "SFCompactDisplay-Regular", size: 13)
        label.textColor = AppColors.AidKit.cellTextDuration
        return label
    }()
    
    private lazy var countPassedDaysLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont(name: "SFCompactDisplay-Regular", size: 10)
        label.textColor = AppColors.AidKit.cellTextDays
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
    
    // MARK: - ConfigureUI
    private func configureUI() {
        backgroundColor = AppColors.AidKit.cell
        layer.cornerRadius = 10
        configureStackView()
        configureVerticalStackView()
        configureDurationAndDaysStackView()
    }

    private func configureStackView () {
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 14, bottom: -20, right: -14)
        stackView.layoutMargins = UIEdgeInsets.zero
        stackView.addArrangedSubview(pillImage)
        stackView.addArrangedSubview(verticalStackView)
        addSubview(stackView)
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            pillImage.widthAnchor.constraint(equalToConstant: AppLayout.AidKit.widthPillsImageView),
            pillImage.heightAnchor.constraint(equalToConstant: AppLayout.AidKit.heightPillsImageView),
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: AppLayout.AidKit.topCourseCellView),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: AppLayout.AidKit.leadingCourseCellView),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                constant: AppLayout.AidKit.trailingCourseCellView),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                              constant: AppLayout.AidKit.bottomCourseCellView)
        ])
    }
    
    private func configureVerticalStackView () {
        verticalStackView.addArrangedSubview(pillNameLabel)
        verticalStackView.addArrangedSubview(durationAndDaysStackView)
    }
    
    private func configureDurationAndDaysStackView () {
        durationAndDaysStackView.addArrangedSubview(durationOfCourseLabel)
        durationAndDaysStackView.addArrangedSubview(countPassedDaysLabel)
    }
}
