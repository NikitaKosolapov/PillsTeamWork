//
//  CoursesCell.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 21.07.2021.
//

import UIKit

class CourseCell: UICollectionViewCell {
    // MARK: - SubView
    private lazy var pillImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        imageView.frame.size.height = 20
        imageView.frame.size.width = 20
        return imageView
    }()
    
    private lazy var pillNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var durationOfCourseLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var passedDaysDoseView: PassedDaysDosesView = {
        let view = PassedDaysDosesView()
        return view
    }()
    
    // MARK: - Public Methods
    func configure(with model: CourseCellModel) {
        pillImage.image = model.imagePill
        pillNameLabel.text = model.namePill
        durationOfCourseLabel.text = model.durationOfCourse
        passedDaysDoseView.config(countPassedDays: model.passedDaysLabel,
                                  nameDays: "Day",
                                  countPassedDoses: model.passedDosesLabel,
                                  typeDoses: model.typeOfDose)
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureUI
    override func prepareForReuse() {
        pillImage.image = nil
        pillNameLabel.text = nil
        durationOfCourseLabel.text = nil
        passedDaysDoseView.config(countPassedDays: nil,
                                  nameDays: nil,
                                  countPassedDoses: nil,
                                  typeDoses: nil)
    }
    
    private func configureUI () {
        configContentView()
        configStackView()
    }
    
    private func configContentView () {
        contentView.backgroundColor = AppColors.red
        contentView.layer.cornerRadius = 20
    }
    
    private func configStackView () {
        let stackView = UIStackView(arrangedSubviews: [pillImage, pillNameLabel, durationOfCourseLabel, passedDaysDoseView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.spacing = 5.0
        contentView.addSubview(stackView)
        
        let marginGuide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 2),
            stackView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 2),
            stackView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -2),
            stackView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -2)
        ])
    }
}
