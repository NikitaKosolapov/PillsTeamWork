//
//  passedDaysDosesView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 21.07.2021.
//

import UIKit

class PassedDaysDosesView: UIView {
    // MARK: - Properties
    let insetOfLabel = CGFloat(5.0) //
    
    // MARK: - Subviews
    private lazy var countPassedDaysLabel: UILabel = {
        let passedDaysLabel = UILabel()
        passedDaysLabel.translatesAutoresizingMaskIntoConstraints = false
        passedDaysLabel.numberOfLines = 1
        passedDaysLabel.font = UIFont.systemFont(ofSize: 12)
        return passedDaysLabel
    }()
    
    private lazy var nameDaysLabel: UILabel = {
        let daysLabel = UILabel()
        daysLabel.translatesAutoresizingMaskIntoConstraints = false
        daysLabel.numberOfLines = 1
        daysLabel.font = UIFont.systemFont(ofSize: 11)
        return daysLabel
    }()
    
    private lazy var countPassedDosesLabel: UILabel = {
        let passedDosesLabel = UILabel()
        passedDosesLabel.translatesAutoresizingMaskIntoConstraints = false
        passedDosesLabel.numberOfLines = 1
        passedDosesLabel.font = UIFont.systemFont(ofSize: 12)
        return passedDosesLabel
    }()
    
    private lazy var typeDosesLabel: UILabel = {
        let dosesLabel = UILabel()
        dosesLabel.translatesAutoresizingMaskIntoConstraints = false
        dosesLabel.numberOfLines = 1
        dosesLabel.font = UIFont.systemFont(ofSize: 11)
        return dosesLabel
    }()
    
// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Public functions
    public func config (countPassedDays: String?, nameDays: String?, countPassedDoses: String?, typeDoses: String?) {
        countPassedDaysLabel.text = countPassedDays
        nameDaysLabel.text = nameDays
        countPassedDosesLabel.text = countPassedDoses
        typeDosesLabel.text = typeDoses
    }
    
// MARK: - ConfigureUI
    private func configureUI() {
        configureView()
        configPassedDaysLabel()
        configDaysLabel()
        configPassedDosesLabel()
        configDosesLabel()
    }
    
    private func configureView() {
        backgroundColor = AppColors.green
        layer.cornerRadius = 10.0
    }
    
    private func configPassedDaysLabel() {
        let safeArea = safeAreaLayoutGuide
        addSubview(countPassedDaysLabel)
        NSLayoutConstraint.activate([
            countPassedDaysLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: insetOfLabel),
            countPassedDaysLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: insetOfLabel)
        ])
    }
    
    private func configDaysLabel() {
        let safeArea = safeAreaLayoutGuide
        addSubview(nameDaysLabel)
        NSLayoutConstraint.activate([
            nameDaysLabel.topAnchor.constraint(equalTo: countPassedDaysLabel.bottomAnchor, constant: insetOfLabel),
            nameDaysLabel.leadingAnchor.constraint(equalTo: countPassedDaysLabel.leadingAnchor),
            nameDaysLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -1*insetOfLabel)
        ])
    }
    
    private func configPassedDosesLabel() {
        let safeArea = safeAreaLayoutGuide
        addSubview(countPassedDosesLabel)
        NSLayoutConstraint.activate([
            countPassedDosesLabel.topAnchor.constraint(equalTo: countPassedDaysLabel.topAnchor),
            countPassedDosesLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -1*insetOfLabel)
        ])
    }
    
    private func configDosesLabel() {
        let safeArea = safeAreaLayoutGuide
        addSubview(typeDosesLabel)
        NSLayoutConstraint.activate([
            typeDosesLabel.topAnchor.constraint(equalTo: countPassedDosesLabel.bottomAnchor, constant: insetOfLabel),
            typeDosesLabel.trailingAnchor.constraint(equalTo: countPassedDosesLabel.trailingAnchor),
            typeDosesLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -1*insetOfLabel)
        ])
    }
}
