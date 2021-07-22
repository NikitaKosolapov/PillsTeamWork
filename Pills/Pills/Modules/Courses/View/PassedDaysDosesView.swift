//
//  passedDaysDosesView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 21.07.2021.
//

import UIKit

class PassedDaysDosesView: UIView {
    // MARK: - Subviews
    let passedDaysLabel: UILabel = {
        let passedDaysLabel = UILabel()
        passedDaysLabel.translatesAutoresizingMaskIntoConstraints = false
        passedDaysLabel.numberOfLines = 1
        passedDaysLabel.font = UIFont.systemFont(ofSize: 12)
        return passedDaysLabel
    }()
    
    let daysLabel: UILabel = {
        let daysLabel = UILabel()
        daysLabel.translatesAutoresizingMaskIntoConstraints = false
        daysLabel.numberOfLines = 1
        daysLabel.font = UIFont.systemFont(ofSize: 11)
        return daysLabel
    }()
    
    let passedDosesLabel: UILabel = {
        let passedDosesLabel = UILabel()
        passedDosesLabel.translatesAutoresizingMaskIntoConstraints = false
        passedDosesLabel.numberOfLines = 1
        passedDosesLabel.font = UIFont.systemFont(ofSize: 12)
        return passedDosesLabel
    }()
    
    let dosesLabel: UILabel = {
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
    
// MARK: - ConfigureUI
    private func configureUI() {
        configureView()
        addSubViews()
        setupConstraints()
    }
    
    private func configureView() {
        backgroundColor = AppColors.green
        layer.cornerRadius = 10.0
    }
    
    private func addSubViews() {
        addSubview(passedDaysLabel)
        addSubview(daysLabel)
        addSubview(passedDosesLabel)
        addSubview(dosesLabel)
    }
    
    private func setupConstraints() {
        let safeArea = safeAreaLayoutGuide
        let insetOfLabel = CGFloat(5.0)
        NSLayoutConstraint.activate([
            passedDaysLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: insetOfLabel),
            passedDaysLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: insetOfLabel),
            daysLabel.topAnchor.constraint(equalTo: passedDaysLabel.bottomAnchor, constant: insetOfLabel),
            daysLabel.leadingAnchor.constraint(equalTo: passedDaysLabel.leadingAnchor),
            daysLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -1*insetOfLabel),
            passedDosesLabel.topAnchor.constraint(equalTo: passedDaysLabel.topAnchor),
            passedDosesLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -1*insetOfLabel),
            dosesLabel.topAnchor.constraint(equalTo: passedDosesLabel.bottomAnchor, constant: insetOfLabel),
            dosesLabel.trailingAnchor.constraint(equalTo: passedDosesLabel.trailingAnchor),
            dosesLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -1*insetOfLabel)
        ])
    }
}
