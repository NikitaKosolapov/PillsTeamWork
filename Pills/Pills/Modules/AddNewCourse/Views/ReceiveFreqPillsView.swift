//
//  ReceiveFreqPillsView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 24.08.2021.
//

import UIKit

enum ReceiveFreqPills {
    case daysOfTheWeek([Date])
    case dailyXTimes(Int)
    case dailyEveryXHour(Int)
    case daysCycle((Int,Int))
}

protocol ReceiveFreqPillsDelegate: AnyObject {
    func frequencyDidChange() -> ReceiveFreqPills
    func certainDaysDidChange(on days: [String])
}

class ReceiveFreqPillsView: UIStackView {
    // MARK: - Properties
    var frequency: Frequency?
    weak var delegate: ReceiveFreqPillsDelegate?
    
    // MARK: - Subviews
     let certainDaysStackView: CertainDaysStackView = {
        let certainDaysStackView = CertainDaysStackView()
        certainDaysStackView.isHidden = true
        return certainDaysStackView
    }()
    
    private let dailyXTimesTextField: UITextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isHidden = true
        textField.centerStyleTextField(font: AppLayout.Fonts.normalRegular, text: "")
        textField.placeholder = Text.one
        textField.maxLength = AppLayout.AddCourse.textFieldsXDaysAndYDays
        textField.isNumeric = true
        return textField
    }()
    
    private let daysCycleStackView: DaysCycleStackView = {
        let daysCycleStackView = DaysCycleStackView()
        daysCycleStackView.isHidden = true
        return daysCycleStackView
    }()
    
    // MARK: - Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private properties
    private func configureUI() {
        configureStackView()
        configureEveryDayXTimesADayTextField()
        certainDaysStackView.delegate = self
    }
    
    private func configureStackView() {
        addArrangedSubviews(views: certainDaysStackView,
                            dailyXTimesTextField,
                            daysCycleStackView)
    }
    
    private func configureEveryDayXTimesADayTextField() {
        NSLayoutConstraint.activate([
            dailyXTimesTextField.heightAnchor.constraint(equalToConstant: AppLayout.AddCourse.heightTextField)
        ])
    }
    
    // MARK: - Public functions
    
    func showView(with frequency: Frequency) {
        self.frequency = frequency
        switch frequency {
        case .daysOfTheWeek:
            certainDaysStackView.isHidden = false
            dailyXTimesTextField.isHidden = true
            daysCycleStackView.isHidden = true
        case .dailyXTimes:
            certainDaysStackView.isHidden = true
            dailyXTimesTextField.isHidden = false
            daysCycleStackView.isHidden = true
        case .dailyEveryXHour:
            certainDaysStackView.isHidden = true
            dailyXTimesTextField.isHidden = true
            daysCycleStackView.isHidden = true
        case .daysCycle:
            certainDaysStackView.isHidden = true
            dailyXTimesTextField.isHidden = true
            daysCycleStackView.isHidden = false
        }
    }
    
    func getDataFreqOfTakingPills(with frequency: Frequency) -> ReceiveFreqPills? {
        switch frequency {
        case .daysOfTheWeek:
            let mock: [Date] = []
            return .daysOfTheWeek(mock)
        case .dailyXTimes:
            return .dailyXTimes(dailyXTimes())
        case .dailyEveryXHour:
            return .dailyEveryXHour(dailyXTimes())
        case .daysCycle:
            return .daysCycle(getDaysCycle())
        }
    }
    
    // MARK: - Private functions
    private func getCertainDays() -> [String] {
        return certainDaysStackView.getCertainDays()
    }
    
    private func dailyXTimes() -> Int {
        return Int(dailyXTimesTextField.text ?? "") ?? 0
    }
    
    private func getDaysCycle() -> (Int, Int) {
        return daysCycleStackView.getXDaysAndYDays()
    }
}

extension ReceiveFreqPillsView: CertainDaysStackViewDelegate {
    func certainDaysDidChange(on days: [String]) {
        delegate?.certainDaysDidChange(on: days)
    }
}
