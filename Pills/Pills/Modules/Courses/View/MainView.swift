//
//  MainView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 31.07.2021.
//

import UIKit

class MainView: UIView {
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
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = AppColors.AidKit.cellTextName
        return label
    }()
    
    private lazy var durationOfCourseLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = AppColors.AidKit.cellTextDuration
        return label
    }()
    
    private lazy var countPassedDaysLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 10)
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
    func configure(with model: CourseCellModel) {
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
        stackView.layoutMargins = UIEdgeInsets.zero
        stackView.addArrangedSubview(pillImage)
        stackView.addArrangedSubview(verticalStackView)
        addSubview(stackView)
        let marginGuide = layoutMarginsGuide
        NSLayoutConstraint.activate([
            pillImage.widthAnchor.constraint(equalToConstant: AppLayout.AidKit.widthPillsImageView),
            pillImage.heightAnchor.constraint(equalToConstant: AppLayout.AidKit.heightPillsImageView),
            stackView.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor)
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
