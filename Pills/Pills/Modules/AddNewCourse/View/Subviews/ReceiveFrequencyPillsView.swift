//
//  ReceiveFreqPillsView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 24.08.2021.
//

import SnapKit
import UIKit

enum ReceiveFreqPills {
    case daysOfTheWeek([Date])
    case dailyXTimes([Date])
    case dailyEveryXHour(Int)
    case daysCycle((Int,Int))
}

protocol ReceiveFreqPillsDelegate: AnyObject {
    func frequencyDidChange() -> ReceiveFreqPills
    func certainDaysDidChange(on days: [String])
    func xDaysDidChange(on hour: String)
}

/// Class contains elements that show up when we tap on frequencyTextField
final class ReceiveFrequencyPillsView: UIStackView {
    
    // MARK: - Public Properties
    
    public var frequency: Frequency?
    public weak var delegate: ReceiveFreqPillsDelegate?
    
    // MARK: - Private Properties

    // MARK: - Subviews
     let certainDaysStackView: CertainDaysStackView = {
        let certainDaysStackView = CertainDaysStackView()
        certainDaysStackView.isHidden = true
        return certainDaysStackView
    }()
    
    let dailyXTimesTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.isHidden = true
        textField.centerStyleTextField(font: AppLayout.Fonts.normalRegular, text: "")
        textField.placeholder = Text.one
        textField.maxLength = AppLayout.AddCourse.textFieldsXDaysAndYDays
        textField.isNumeric = true
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(xTimesDidChange(_:)), for: .editingDidEnd)
        return textField
    }()
    
    private let daysCycleStackView: DaysCycleStackView = {
        let daysCycleStackView = DaysCycleStackView()
        daysCycleStackView.isHidden = true
        return daysCycleStackView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureStackView()
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
        certainDaysStackView.delegate = self
    }
    
    private func configureEveryDayXTimesADayTextField() {
        NSLayoutConstraint.activate([
            dailyXTimesTextField.heightAnchor.constraint(equalToConstant: AppLayout.AddCourse.heightTextField)
        ])
    }
    
    @objc private func xTimesDidChange(_ sender: UITextField) {
        delegate?.xDaysDidChange(on: sender.text ?? "")
    }
    
    // MARK: - Public functions
    
    public func showView(with frequency: Frequency) {
        self.frequency = frequency
        switch frequency {
        case .daysOfTheWeek:
            certainDaysStackView.isHidden = false
            dailyXTimesTextField.isHidden = true
            daysCycleStackView.isHidden = true
            dailyXTimesTextField.snp.updateConstraints { $0.height.equalTo(AppLayout.AddCourse.heightTextField) }
        case .dailyXTimes:
            certainDaysStackView.isHidden = true
            dailyXTimesTextField.isHidden = false
            daysCycleStackView.isHidden = true
            dailyXTimesTextField.snp.updateConstraints { $0.height.equalTo(AppLayout.AddCourse.heightTextField) }
        case .dailyEveryXHour:
            certainDaysStackView.isHidden = true
            dailyXTimesTextField.isHidden = false
            daysCycleStackView.isHidden = true
            dailyXTimesTextField.snp.updateConstraints { $0.height.equalTo(AppLayout.AddCourse.heightTextField) }
        case .daysCycle:
            certainDaysStackView.isHidden = true
            dailyXTimesTextField.isHidden = true
            daysCycleStackView.isHidden = false
            dailyXTimesTextField.snp.updateConstraints { $0.height.equalTo(AppLayout.AddCourse.daysCycleStackHeight) }
        }
    }
    
    public func getDataFrequencyOfTakingPills(with frequency: Frequency) -> ReceiveFreqPills? {
        switch frequency {
        case .daysOfTheWeek:
            let mock: [Date] = []
            return .daysOfTheWeek(mock)
        case .dailyXTimes:
            let mock: [Date] = []
            return .dailyXTimes(mock)
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
        Int(dailyXTimesTextField.text ?? "") ?? 0
    }
    
    private func getDaysCycle() -> (Int, Int) {
        daysCycleStackView.getXDaysAndYDays()
    }
    
}

extension ReceiveFrequencyPillsView: CertainDaysStackViewDelegate {
    func certainDaysDidChange(on days: [String]) {
        delegate?.certainDaysDidChange(on: days)
    }
}
