//
//  ReceiveFreqPillsView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 24.08.2021.
//

import UIKit

enum TypeOfReceiveFreqPills {
    case certainDays
    case everyDayXTimesADay
    case everyDayEveryXHour
    case daysCycle
    case nothing
}

enum ReceiveFreqPills {
    case certainDays([Bool])
    case everyDayXTimesADay(String)
    case everyDayEveryXHour(String)
    case daysCycle((String,String))
}

protocol ReceiveFreqPillsViewAbstract {
    var typeOfFreqOfTakingPills: TypeOfReceiveFreqPills? { get }
    func showView (typeView: TypeOfReceiveFreqPills)
    func getDataFreqOfTakingPills() -> ReceiveFreqPills?
}

class ReceiveFreqPillsView: UIStackView, ReceiveFreqPillsViewAbstract {
    // MARK: - Properties
    var typeOfFreqOfTakingPills: TypeOfReceiveFreqPills?
    
    // MARK: - Subviews
    private let certainDaysStackView: CertainDaysStackView = {
        let certainDaysStackView = CertainDaysStackView()
        certainDaysStackView.isHidden = true
        return certainDaysStackView
    }()
    
    private let everyDayXTimesADayTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isHidden = true
        textField.centerStyleTextField(font: AppLayout.Fonts.normalRegular, text: "1")
        return textField
    }()
    
    private let everyDayEveryXHourTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isHidden = true
        textField.centerStyleTextField(font: AppLayout.Fonts.normalRegular, text: "1")
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
        configureEveryDayEveryXHourTextField()
    }
    
    private func configureStackView() {
        axis = .vertical
        distribution = .fillEqually
        alignment = .fill
        spacing = 5
        addArrangedSubviews(views: certainDaysStackView, everyDayXTimesADayTextField,
                            everyDayEveryXHourTextField, daysCycleStackView)
    }
    
    private func configureEveryDayXTimesADayTextField() {
        NSLayoutConstraint.activate([
            everyDayXTimesADayTextField.heightAnchor.constraint(equalToConstant: AppLayout.AddCourse.heightTextField)
        ])
    }
    
    private func configureEveryDayEveryXHourTextField() {
        NSLayoutConstraint.activate([
            everyDayEveryXHourTextField.heightAnchor.constraint(equalToConstant: AppLayout.AddCourse.heightTextField)
        ])
    }
    
    // MARK: - Public functions
    
    func showView (typeView: TypeOfReceiveFreqPills) {
        typeOfFreqOfTakingPills = typeView
        switch typeView {
        case .certainDays:
            certainDaysStackView.isHidden = false
            everyDayXTimesADayTextField.isHidden = true
            everyDayEveryXHourTextField.isHidden = true
            daysCycleStackView.isHidden = true
        case .everyDayXTimesADay:
            certainDaysStackView.isHidden = true
            everyDayXTimesADayTextField.isHidden = false
            everyDayEveryXHourTextField.isHidden = true
            daysCycleStackView.isHidden = true
        case .everyDayEveryXHour:
            certainDaysStackView.isHidden = true
            everyDayXTimesADayTextField.isHidden = true
            everyDayEveryXHourTextField.isHidden = false
            daysCycleStackView.isHidden = true
        case .daysCycle:
            certainDaysStackView.isHidden = true
            everyDayXTimesADayTextField.isHidden = true
            everyDayEveryXHourTextField.isHidden = true
            daysCycleStackView.isHidden = false
        case .nothing:
            certainDaysStackView.isHidden = true
            everyDayXTimesADayTextField.isHidden = true
            everyDayEveryXHourTextField.isHidden = true
            daysCycleStackView.isHidden = true
        }
    }
    
    func getDataFreqOfTakingPills() -> ReceiveFreqPills? {
        switch typeOfFreqOfTakingPills {
        case .certainDays:
            return .certainDays(getCertainDays())
        case .everyDayXTimesADay:
            return  .everyDayXTimesADay(getXTimesADay())
        case .everyDayEveryXHour:
            return .everyDayEveryXHour(getEveryXHour())
        case .daysCycle:
            return .daysCycle(getDaysCycle())
        case .nothing:
            return nil
        case .none:
            return nil
        }
    }
    
    // MARK: - Private functions
    private func getCertainDays() -> [Bool] {
        return certainDaysStackView.getCertainDays()
    }
    
    private func getXTimesADay() -> String {
        guard let xTimes = everyDayXTimesADayTextField.text else {
            return ""
        }
        return xTimes
    }
    
    private func getEveryXHour() -> String {
        guard let xHour = everyDayEveryXHourTextField.text else {
            return ""
        }
        return xHour
    }
    
    private func getDaysCycle() -> (String, String) {
        return daysCycleStackView.getXDaysAndYDays()
    }
}
