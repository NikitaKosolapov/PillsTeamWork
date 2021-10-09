//
//  AddNewCourseViewController.swift
//  Pills
//
//  Created by aprirez on 8/4/21.
//

import UIKit
import RealmSwift

class AddNewCourseViewController: BaseViewController<AddNewCourseView> {
    
    private var startDate = Date()
    private let newCourse = RealmMedKitEntry()
    private let realm = RealmService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.dataSource = self
        rootView.delegate = self
        rootView.setup()
		rootView.addEventToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTabBarHidden(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = AppColors.lightBlueSapphire
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.title = "\(Text.newPill)"
        navigationController?.navigationItem.largeTitleDisplayMode = .never
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setTabBarHidden(false)
    }

    func onValidate(_ valid: Bool) {
        rootView.setDoneButtonEnabled(valid)
    }
}

extension AddNewCourseViewController: AddNewCourseDataSource {
    func pillTypeOptions() -> [String] {
        return PillType.allCases.map {$0.rawValue}
    }
    
    func frequencyOptions() -> [String] {
        return Frequency.allCases.map {$0.rawValue}
    }
    
    func mealOptions() -> [String] {
        return Text.Usage.allCases.map {$0.rawValue}
    }
}

extension AddNewCourseViewController: AddNewCourseDelegate {
    func onFrequencyDateChanged(_ frequency: ReceiveFreqPills) {
        let schedule = getSchedule(with: frequency)
        newCourse.schedule = schedule
        onValidate(newCourse.validate())
    }

    func onPillNameChanged(_ name: String) {
        newCourse.name = name
        onValidate(newCourse.validate())
    }
    
    func onPillTypeChanged(_ type: PillType) {
        let unit = Text.Unit.init(rawValue: type.units()[0]) ?? .pill

        rootView.setDoseUnit(unit)
        rootView.setDoseUnitOptions(type.units().map { $0 })

        newCourse.unitString = type.units().first ?? ""
        newCourse.pillType = type
        onValidate(newCourse.validate())
    }
    
    func onPillDoseChanged(_ dose: Double) {
        newCourse.singleDose = dose
        onValidate(newCourse.validate())
    }
    
    func onDoseUnitChanged(_ unit: Text.Unit) {
        newCourse.unitString = unit.rawValue
        onValidate(newCourse.validate())
    }
    
    func onPillFreqTypeChanged(_ freq: Frequency) {
        newCourse.freqString = freq.rawValue
        onValidate(newCourse.validate())
    }
    
    func onStartDateChanged(_ date: Date) {
        startDate = date
        rootView.setStartDate(date)
        newCourse.startDate = date
        onValidate(newCourse.validate())
    }
    
    func onStartTimeChanged(_ time: Date) {
        newCourse.takeAtTime = time
        onValidate(newCourse.validate())
    }
    
    func onTakePeriodChanged(_ days: Int) {
        rootView.setTakePeriod(days, fromDate: startDate)
        let date =
            Calendar.current.date(byAdding: .day, value: days, to: startDate)
                ?? Date.distantPast
        newCourse.endDate = date
        onValidate(newCourse.validate())
    }

    func onTakePeriodTill(_ tillDate: Date) {
        rootView.updateTakePeriodText(fromDate: startDate, tillDate: tillDate)
        newCourse.endDate = tillDate
        onValidate(newCourse.validate())
    }

    func onMealDependencyChanged(_ usage: Text.Usage) {
        newCourse.usageString = usage.rawValue
        onValidate(newCourse.validate())
    }
    
    func onCommentChanged(_ text: String) {
        newCourse.note = text
    }
    
    func onSubmit() {
        realm.create(newCourse) {
            self.navigationController?.popViewController(animated: true)
        }
    }

    func getSchedule(with frequency: ReceiveFreqPills) -> List<RealmTimePoint> {
        let schedule = List<RealmTimePoint>()
        switch frequency {
        case .daysOfTheWeek(let days):
            days.forEach { day in
                let realmTimeObject = RealmTimePoint()
                realmTimeObject.time = day
                schedule.append(realmTimeObject)
            }
            return schedule
        case .dailyEveryXHour(let xHour):
            break
        case .dailyXTimes(let xTimes):
            break
        case .daysCycle(let cycle):
            break
        default:
            break
        }

        return List<RealmTimePoint>()
    }
}
