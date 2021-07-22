//
//  passedDaysDosesView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 21.07.2021.
//

import UIKit

class PassedDaysDosesView: UIView {
// MARK: - Subviews
    let passedDaysLabel = UILabel()
    let daysLabel = UILabel()
    let passedDosesLabel = UILabel()
    let dosesLabel = UILabel()
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
        configureDaysLabel()
        configurePassedDaysLabel()
        configureDosesLabel()
        configurePassedDosesLabel()
        setupConstraints()
    }
    private func configureView() {
        backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 251/255, alpha: 1)
        backgroundColor = UIColor.lightGray
        layer.cornerRadius = 10.0
    }
    private func configurePassedDaysLabel() {
        passedDaysLabel.translatesAutoresizingMaskIntoConstraints = false
        passedDaysLabel.numberOfLines = 1
        passedDaysLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(passedDaysLabel)
    }
    private func configureDaysLabel() {
        daysLabel.translatesAutoresizingMaskIntoConstraints = false
        daysLabel.numberOfLines = 1
        daysLabel.font = UIFont.systemFont(ofSize: 11)
        addSubview(daysLabel)
    }
    private func configurePassedDosesLabel() {
        passedDosesLabel.translatesAutoresizingMaskIntoConstraints = false
        passedDosesLabel.numberOfLines = 1
        passedDosesLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(passedDosesLabel)
    }
    private func configureDosesLabel() {
        dosesLabel.translatesAutoresizingMaskIntoConstraints = false
        dosesLabel.numberOfLines = 1
        dosesLabel.font = UIFont.systemFont(ofSize: 11)
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
