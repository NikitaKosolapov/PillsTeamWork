//
//  DaysCycleStackView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 25.08.2021.
//

import UIKit

class DaysCycleStackView: UIStackView {
    
    // MARK: - Subviews
    private lazy var xDaysStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [xDaysLabel, xDaysTextField])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = AppLayout.AddCourse.spaceTextFieldAndLabelForXDaysAndYDays
        return stackView
    }()
    
    private lazy var yDaysStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yDaysLabel, yDaysTextField])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = AppLayout.AddCourse.spaceTextFieldAndLabelForXDaysAndYDays
        return stackView
    }()
    
    private let xDaysLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftStyleLabel(font: AppLayout.Fonts.smallRegular, text: "X дней")
        return label
    }()
    
    private let xDaysTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerStyleTextField(font: AppLayout.Fonts.normalRegular, text: "1")
        return textField
    }()
    
    private let yDaysLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftStyleLabel(font: AppLayout.Fonts.smallRegular, text: "Y дней")
        return label
    }()
    
    private let yDaysTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerStyleTextField(font: AppLayout.Fonts.normalRegular, text: "1")
        return textField
    }()
    
    // MARK: - Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func configureUI() {
        configureStackView()
        configureXDaysLabel()
        configureYDaysLabel()
        configureXDaysTextField()
        configureYDaysTextField()
    }
    
    private func configureStackView() {
        axis = .horizontal
        distribution = .fillEqually
        alignment = .fill
        spacing = AppLayout.AddCourse.spaceTextFieldsXDaysAndYDays
        addArrangedSubviews(views: xDaysStackView, yDaysStackView)
    }
    
    private func configureXDaysLabel() {
        NSLayoutConstraint.activate([
            xDaysLabel.heightAnchor.constraint(equalToConstant: AppLayout.AddCourse.heightLabel)
        ])
    }
    
    private func configureYDaysLabel() {
        NSLayoutConstraint.activate([
            yDaysLabel.heightAnchor.constraint(equalToConstant: AppLayout.AddCourse.heightLabel)
        ])
    }
    
    private func configureXDaysTextField() {
        NSLayoutConstraint.activate([
            xDaysTextField.heightAnchor.constraint(equalToConstant: AppLayout.AddCourse.heightTextField)
        ])
    }
    
    private func configureYDaysTextField() {
        NSLayoutConstraint.activate([
            yDaysTextField.heightAnchor.constraint(equalToConstant: AppLayout.AddCourse.heightTextField)
        ])
    }
    
    // MARK: - Public functions
    func getXDaysAndYDays() -> (String, String) {
        guard let xText = xDaysTextField.text,
              let yText = yDaysTextField.text else {
            return ("","")
        }
        return (xText, yText)
    }
}
