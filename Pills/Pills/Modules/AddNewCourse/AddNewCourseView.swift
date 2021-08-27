//
//  AddNewCourseView.swift
//  Pills
//
//  Created by aprirez on 8/16/21.
//

import UIKit

fileprivate final class VStackViewFabric {
    static func generate(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }
}

fileprivate final class HStackViewFabric {
    static func generate(_ views: [UIView], _ distribution: UIStackView.Distribution = .fillEqually) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.distribution = distribution
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = AppLayout.AddCourse.horizontalSpacing
        return stackView
    }
}

fileprivate final class FieldHeaderFabric {
    static func generate(header: String) -> UILabel {
        let view = UILabel()
        view.text = header
        view.font = AppLayout.Fonts.smallRegular
        view.textAlignment = .left
        return view
    }
}

// swiftlint:disable type_body_length
class AddNewCourseView: UIView {
    // MARK: - Pill Name Input
    private lazy var pillNameLabel =
        FieldHeaderFabric.generate(header: Text.name)
    private lazy var pillNameInput =
        CustomTextFieldBuilder()
            .withPlaceholder(Text.namePlaceholder)
            .withMaxLength(AppLayout.AddCourse.pillNameFieldMaxLength)
            .build()
    private lazy var stackPillName = VStackViewFabric.generate([pillNameLabel, pillNameInput])

    // MARK: - Dose Input
    private lazy var doseLabel = FieldHeaderFabric.generate(header: Text.dose)
    private lazy var doseInput =
        CustomTextFieldBuilder()
            .withPlaceholder(Text.dosePlaceholder)
            .withType(.numeric)
            .withTextAlignment(.center)
            .withMaxLength(AppLayout.AddCourse.doseFieldMaxLength)
            .build()
    private lazy var stackDose = VStackViewFabric.generate([doseLabel, doseInput])

    // MARK: - Dose Unit
    private lazy var doseUnitLabel = FieldHeaderFabric.generate(header: Text.unit)
    private lazy var doseUnitInput =
        CustomTextFieldBuilder()
            .withPlaceholder(Text.unit)
            .withSimplePicker(options: [], {_ in return true})
            .withTextAlignment(.center)
            .build()
    private lazy var stackDoseType = VStackViewFabric.generate([doseUnitLabel, doseUnitInput])

    // MARK: - Type Input
    private lazy var typeLabel = FieldHeaderFabric.generate(header: Text.pillType)
    private lazy var typeInput =
        CustomTextFieldBuilder()
            .withPlaceholder(Text.pillType)
            .dropDown()
            .withImage()
            .withDropDownProcessor({ [weak self] (_, index) in
                guard let self = self else {return true}
                self.typeNameOfDef.text = PillType.allCases[index].rawValue.localized()
                self.doseUnitInput.pickerOptions =
                    PillType.allCases[index].units().map { $0 }
                self.doseUnitInput.text = PillType.allCases[index].units()[0]
                return true // continue default processing
            })
            .withItems(PillType.allCases.map {($0.image(), "")})
            .build()
    private lazy var typeNameLabel = FieldHeaderFabric.generate(header: "")
    
    private lazy var typeNameOfDef =
        CustomTextFieldBuilder()
            .withType(.readOnly)
            .withTextAlignment(.center)
            .build()
    
    private lazy var stackTypeImage = VStackViewFabric.generate([typeLabel, typeInput])
    private lazy var stackTypeName = VStackViewFabric.generate([typeNameLabel, typeNameOfDef])

    private lazy var stackTypeImageAndTypeName =
        HStackViewFabric.generate([stackTypeImage, stackTypeName], .fillEqually)
    
    private lazy var stackDoseAndType =
        HStackViewFabric.generate([stackDose, stackDoseType], .fillEqually)

    // MARK: - Frequency Input
    private lazy var frequencyInput: CustomTextField = {
        let textField = CustomTextFieldBuilder()
            .withSimplePicker(
                options: Text.Frequency.all(), { [weak self] (option) in
                    guard let self = self else {return false}
                    // Alexander, please open additional view here:
                    debugPrint("\(option)")
                    return true
                })
            .build()
        textField.text = Text.takingFrequency
        return textField
    }()
    
    private(set) lazy var receiveFreqStackView: ReceiveFreqPillsViewAbstract = {
        let receiveFreqStackView = ReceiveFreqPillsView()
        return receiveFreqStackView
    }()

    // MARK: - Start Date Input
    private lazy var startLabel = FieldHeaderFabric.generate(header: Text.startFrom)
    private lazy var startInput =
        CustomTextFieldBuilder()
            .withPlaceholder(CustomTextField.dateFormatter.string(from: Date()))
            .withImage(AppImages.Tools.calendar)
            .withDatePicker(.date , {date in
                if let tillDate = self.takePeriodDatePickerInput.date {
                    self.setTakePeriodText(fromDate: date, tillDate: tillDate)
                }
                return true
            })
            .build()
    private lazy var stackStart = VStackViewFabric.generate([startLabel, startInput])

    // MARK: - Start Time Input
    private lazy var timeLabel = FieldHeaderFabric.generate(header: Text.takeAtTime)
    private lazy var timeInput =
        CustomTextFieldBuilder()
            .withPlaceholder(CustomTextField.timeFormatter.string(from: Date()))
            .withDatePicker(.time , {_ in
                return true
            })
            .build()
    private let timePicker = UIDatePicker()
    private lazy var stackTime = VStackViewFabric.generate([timeLabel, timeInput])

    private lazy var stackStartAndWhen = HStackViewFabric.generate([stackStart, stackTime], .fillEqually)

    // MARK: - Period Input
    // simple input
    private lazy var takePeriodLabel = FieldHeaderFabric.generate(header: Text.takePeriod)
    private lazy var takePeriodInput =
        CustomTextFieldBuilder()
            .withPlaceholder(Text.takePeriodPlaceholder)
            .withType(.numeric)
            .withMaxLength(AppLayout.AddCourse.periodFieldMaxLength)
            .withEndEditProcessor(self.processTakePeriodInput)
            .clearOnFocus()
            .build()
    private lazy var stackTakePeriod = VStackViewFabric.generate([takePeriodLabel, takePeriodInput])

    // drop down
    private lazy var takePeriodDropDownLabel = FieldHeaderFabric.generate(header: "")
    private lazy var takePeriodDropDownInput
        = CustomTextFieldBuilder()
            .dropDown(width: AppLayout.AddCourse.periodDropDownWidth)
            .withImage()
            .withDropDownProcessor(self.processTakePeriodDropDownSelect)
            .withItems(Text.Period.all().map { (nil, $0) })
            .build()
    private lazy var stackTakePeriodDropDown =
        VStackViewFabric.generate([takePeriodDropDownLabel, takePeriodDropDownInput])

    // date picker
    private lazy var takePeriodDatePickerLabel =
        FieldHeaderFabric.generate(header: "")
    private lazy var takePeriodDatePickerInput
        = CustomTextFieldBuilder()
            .withImage(AppImages.Tools.calendar)
            .withDatePicker(.date, {date in
                self.setTakePeriodText(
                    fromDate: self.getStartDate(),
                    tillDate: date)
                return false
            })
            .build()
    private lazy var stackTakeDatePickerPeriod
        = VStackViewFabric.generate([takePeriodDatePickerLabel, takePeriodDatePickerInput])

    private lazy var stackTakePeriodWithDropDown: UIStackView = {
        let stack = HStackViewFabric.generate([
            stackTakePeriod,
            stackTakePeriodDropDown,
            stackTakeDatePickerPeriod],
            .fill)
        stack.spacing = -AppLayout.CustomTextField.cornerRadius
        return stack
    }()

    // MARK: - Frequency Input
    private lazy var mealDependencyLabel =
        FieldHeaderFabric.generate(header: Text.instruction)
    private lazy var mealDependencyInput: CustomTextField = {
        let textField = CustomTextFieldBuilder()
            .withSimplePicker(
                options: Text.Usage.all(), { [weak self] (option) in
                    guard let self = self else {return false}
                    debugPrint("\(option)")
                    return true
                })
            .build()
        textField.placeholder = Text.instruction
        return textField
    }()
    private lazy var stackMealDependency = VStackViewFabric.generate([mealDependencyLabel, mealDependencyInput])

    // MARK: - Note Input
    private lazy var noteLabel =
        FieldHeaderFabric.generate(header: Text.notes)
    private lazy var noteInput: UITextView = {
        let textField = UITextView()
        textField.isEditable = true
        textField.font = AppLayout.Fonts.normalRegular
        textField.backgroundColor = .white
        textField.layer.cornerRadius = AppLayout.CustomTextField.cornerRadius
        return textField
    }()
    private lazy var stackNote = VStackViewFabric.generate([noteLabel, noteInput])
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = AppColors.addNewCourseBackgroundColor
        return scrollView
    }()
    
    // MARK: - Continue Button
    private lazy var doneButton: AddButton = {
        let button = AddButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Text.save, for: .normal)
        button.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        button.isEnabled = false
        NSLayoutConstraint.activate(
            [button.heightAnchor.constraint(equalToConstant: AppLayout.Journal.heightAddButton)])
        return button
    }()

    @objc func doneButtonPressed() {
        // dummy
    }

    // MARK: - Major Stack View
    private lazy var formStackView: UIStackView = {
        guard let receiveFreqStackView = receiveFreqStackView as? ReceiveFreqPillsView
        else {
            return UIStackView()
        }
        let stack = VStackViewFabric.generate([
            stackPillName,
            stackTypeImageAndTypeName,
            stackDoseAndType,
            frequencyInput,
            receiveFreqStackView,
            stackStartAndWhen,
            stackTakePeriodWithDropDown,
            stackMealDependency,
            stackNote
        ])
        stack.spacing = AppLayout.AddCourse.horizontalSpacing
        return stack
    }()

    private lazy var majorStackView: UIStackView = {
        let stackView = VStackViewFabric.generate([
                scrollView,
                doneButton
            ])
        stackView.spacing = AppLayout.AddCourse.horizontalSpacing
        return stackView
    }()
    private var majorStackViewBottomAnchor: NSLayoutConstraint?

    // MARK: - Constraints
    // swiftlint:disable function_body_length
    override func updateConstraints() {
        super.updateConstraints()

        if majorStackViewBottomAnchor == nil {
            majorStackViewBottomAnchor = majorStackView.bottomAnchor
                .constraint(
                    equalTo: safeAreaLayoutGuide.bottomAnchor,
                    constant: -AppLayout.AddCourse.horizontalSpacing
                )
        }

        NSLayoutConstraint.activate([
            majorStackView.topAnchor
                .constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            majorStackView.leadingAnchor
                .constraint(
                    equalTo: leadingAnchor,
                    constant: AppLayout.AddCourse.horizontalSpacing
                ),
            majorStackView.trailingAnchor
                .constraint(
                    equalTo: trailingAnchor,
                    constant: -AppLayout.AddCourse.horizontalSpacing
                ),
            majorStackViewBottomAnchor!,

            formStackView.topAnchor
                .constraint(equalTo: scrollView.topAnchor),
            formStackView.leadingAnchor
                .constraint(equalTo: scrollView.leadingAnchor),
            formStackView.widthAnchor
                .constraint(equalTo: scrollView.widthAnchor),

            pillNameInput.heightAnchor.constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),

            doseInput.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),
            doseUnitInput.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),
            typeInput.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),

            frequencyInput.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),

            startInput.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),
            timeInput.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),

            takePeriodInput.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),
            takePeriodDropDownInput.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),
            takePeriodDatePickerInput.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),

            takePeriodDropDownInput.widthAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),
            takePeriodDatePickerInput.widthAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),
            
            noteInput.heightAnchor
                .constraint(greaterThanOrEqualToConstant: AppLayout.AddCourse.noteInputHeight)
        ])
    }
    
    // MARK: - Class Methods
    func setup() {
        addSubviews()
        backgroundColor = AppColors.addNewCourseBackgroundColor
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(keyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil)
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(keyboardWillHide),
                name: UIResponder.keyboardWillHideNotification,
                object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            majorStackViewBottomAnchor?.isActive = false
            majorStackViewBottomAnchor = majorStackView.bottomAnchor
                .constraint(
                    equalTo: self.bottomAnchor,
                    constant: -keyboardHeight - AppLayout.AddCourse.horizontalSpacing
                )
            majorStackViewBottomAnchor?.isActive = true
        }
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        majorStackViewBottomAnchor?.isActive = false
        majorStackViewBottomAnchor = majorStackView.bottomAnchor
            .constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -AppLayout.AddCourse.horizontalSpacing
            )
        majorStackViewBottomAnchor?.isActive = true
    }

    func addSubviews() {
        scrollView.addSubview(formStackView)
        addSubview(majorStackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.contentSize = CGSize(
            width: scrollView.contentSize.width,
            height: stackNote.frame.maxY
        )
    }

    func getStartDate() -> Date {
        if let date = startInput.date {
            return date
        }
        return Date()
    }
    
    func processTakePeriodDropDownSelect(items: [DropDownItem], index: Int) -> Bool {
        var date: Date?

        let period = Text.Period.allCases[index]
        switch period {
        case .week:
            date = Calendar.current.date(byAdding: .day, value: 7, to: getStartDate())
        case .month:
            date = Calendar.current.date(byAdding: .month, value: 1, to: getStartDate())
        case .halfYear:
            date = Calendar.current.date(byAdding: .month, value: 6, to: getStartDate())
        case .year:
            date = Calendar.current.date(byAdding: .year, value: 1, to: getStartDate())
        }

        setTakePeriodText(fromDate: getStartDate(), tillDate: date ?? getStartDate())
        return false // don't do default processing
    }
    
    func setTakePeriodText(fromDate: Date, tillDate: Date) {
        if (tillDate <= fromDate) {
            self.takePeriodInput.placeholder = Text.periodExpired
            self.takePeriodInput.text = ""
            return
        }
        let calendar = Calendar.current
        let dateStart = calendar.startOfDay(for: fromDate)
        let dateEnd = calendar.startOfDay(for: tillDate)

        guard let days =
            calendar.dateComponents(
                [Calendar.Component.day],
                from: dateStart,
                to: dateEnd).day
        else {return}

        let dateString = CustomTextField.dateFormatter.string(from: dateEnd)
        self.takePeriodInput.text =
            "\(days) \(days.days()), \(Text.till) \(dateString)"
        self.takePeriodDatePickerInput.date = dateEnd
    }

    func processTakePeriodInput() {
        guard let days = Int(self.takePeriodInput.text ?? "0") else {return}
        let date = Calendar.current.date(byAdding: .day, value: days, to: getStartDate())
        setTakePeriodText(fromDate: getStartDate(), tillDate: date ?? getStartDate())
    }
    
}
