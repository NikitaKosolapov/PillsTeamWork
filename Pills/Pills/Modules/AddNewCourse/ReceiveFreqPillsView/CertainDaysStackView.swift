//
//  CertainDaysStackView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 24.08.2021.
//

import UIKit

class CertainDaysStackView: UIStackView {
    
    // MARK: - Properties
    private let dayOfWeekArray: [String] = [Text.Monday, Text.Tuesday,Text.Wednesday,
                                            Text.Thursday, Text.Friday, Text.Saturday, Text.Sunday]
    
    // MARK: - Subviews
    private lazy var dayOfWeekStackViewArray: [UIStackView] = {
        var stackViewArray: [UIStackView] = []
        for (index, day) in dayOfWeekArray.enumerated() {
            let stackView = UIStackView(arrangedSubviews: [dayOfWeekLabelArray[index], dayOfWeekButtonArray[index]])
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.alignment = .fill
            stackView.spacing = AppLayout.AddCourse.spaceCheckButtonAndLabel
            stackViewArray.append(stackView)
        }
        return stackViewArray
    }()
    
    private lazy var dayOfWeekLabelArray: [UILabel] = {
        var labelArray: [UILabel] = []
        dayOfWeekArray.forEach { (nameOfWeek) in
            let label = UILabel()
            label.centerStyleLabel(font: AppLayout.Fonts.smallRegular, text: nameOfWeek)
            labelArray.append(label)
        }
        return labelArray
    }()
    
    private lazy var dayOfWeekButtonArray: [UIButton] = {
        var buttonArray: [UIButton] = []
        dayOfWeekArray.forEach { _ in
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(AppImages.AddCourse.noCheck, for: .normal)
            button.setImage(AppImages.AddCourse.check, for: .selected)
            buttonArray.append(button)
            button.addTarget(self, action: #selector(dayOfWeekButtonTouchUpInside), for: .touchUpInside)
        }
        return buttonArray
    }()
    
    // MARK: - Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    func getCertainDays() -> [Bool] {
        var certainDays: [Bool] = []
        dayOfWeekButtonArray.forEach { (button) in
            if (button.isSelected) {
                certainDays.append(true)
            } else {
                certainDays.append(false)
            }
        }
        return certainDays
    }
    
    // MARK: - Private functions
    private func configureUI() {
        configureStackView()
        configureButtons()
        configureLabels()
    }
    
    private func configureStackView() {
        axis = .horizontal
        distribution = .fillEqually
        alignment = .fill
        dayOfWeekStackViewArray.forEach { (dayStackView) in
            addArrangedSubview(dayStackView)
        }
    }
    
    private func configureButtons() {
        dayOfWeekButtonArray.forEach { (button) in
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: AppLayout.AddCourse.heightCheckOfDay)
            ])
        }
    }
    
    private func configureLabels() {
        dayOfWeekLabelArray.forEach { (label) in
            NSLayoutConstraint.activate([
                label.heightAnchor.constraint(equalToConstant: AppLayout.AddCourse.heightLabel)
            ])
        }
    }
    
    // MARK: - Actions
    @objc private func dayOfWeekButtonTouchUpInside(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
}
