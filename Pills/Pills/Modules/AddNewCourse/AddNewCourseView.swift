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

/// View Events
protocol AddNewCourseDelegate: AnyObject {
    func onPillNameChanged(_ name: String)
    func onPillTypeChanged(_ type: PillType)
    func onPillDoseChanged(_ dose: Double)
    func onDoseUnitChanged(_ unit: Text.Unit)
    func onPillFreqChanged(_ freq: Text.Frequency)
    func onStartDateChanged(_ date: Date)
    func onStartTimeChanged(_ time: Date)
    func onTakePeriodChanged(_ days: Int)
    func onTakePeriodTill(_ tillDate: Date)
    func onMealDependencyChanged(_ usage: Text.Usage)
    func onCommentChanged(_ text: String)
    
    func onSubmit()
}

/// Data Source
protocol AddNewCourseDataSource: AnyObject {
    func pillTypeOptions() -> [String]
    func frequencyOptions() -> [String]
    func mealOptions() -> [String]
}

// swiftlint:disable type_body_length
class AddNewCourseView: UIView {

    public weak var delegate: AddNewCourseDelegate?
    public weak var dataSource: AddNewCourseDataSource? {
        willSet {
            pillTypeName.pickerOptions = newValue?.pillTypeOptions() ?? []
            frequencyInput.pickerOptions = newValue?.frequencyOptions() ?? []
            mealDependencyInput.pickerOptions = newValue?.mealOptions() ?? []
        }
    }

    // MARK: - Pill Name Input
    internal lazy var pillNameLabel =
        FieldHeaderFabric.generate(header: Text.name)
    internal lazy var pillNameInput =
        CustomTextFieldBuilder()
            .withPlaceholder(Text.namePlaceholder)
            .withMaxLength(AppLayout.AddCourse.pillNameFieldMaxLength)
            .withEndEditProcessor { [weak self] text in
                self?.delegate?.onPillNameChanged(text)
            }
            .build()
    internal lazy var stackPillName = VStackViewFabric.generate([pillNameLabel, pillNameInput])

    // MARK: - Type Input
    internal lazy var typeLabel = FieldHeaderFabric.generate(header: "")
    internal lazy var typeImageHolder: UIView = {
        let holder = UIView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.backgroundColor = AppColors.white
        holder.layer.cornerRadius = AppLayout.CustomTextField.cornerRadius
        holder.addSubview(typeImage)
        NSLayoutConstraint.activate([
            typeImage.topAnchor
                .constraint(equalTo: holder.topAnchor, constant: 1),
            typeImage.bottomAnchor
                .constraint(equalTo: holder.bottomAnchor, constant: -3),
            typeImage.centerXAnchor
                .constraint(equalTo: holder.centerXAnchor),
            typeImage.widthAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight - 4)
        ])
        return holder
    }()
    internal lazy var typeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    internal lazy var pillTypeNameLabel = FieldHeaderFabric.generate(header: Text.pillType)
    internal lazy var pillTypeName =
        CustomTextFieldBuilder()
            .withPlaceholder(Text.pillType)
            .withTextAlignment(.center)
            .withSimplePicker(options: []) { [weak self] (option) in
                    guard let self = self else {return true}
                    let type = PillType.init(rawValue: option) ?? .tablets
                    self.setPillType(type)
                    self.delegate?.onPillTypeChanged(type)
                    return true
                }
            .build()
    
    internal lazy var stackTypeImage = VStackViewFabric.generate([typeLabel, typeImageHolder])
    internal lazy var stackTypeName = VStackViewFabric.generate([pillTypeNameLabel, pillTypeName])

    internal lazy var stackTypeImageAndTypeName =
        HStackViewFabric.generate([stackTypeName, stackTypeImage], .fillEqually)
    
    // MARK: - Dose Input
    internal lazy var doseLabel = FieldHeaderFabric.generate(header: Text.dose)
    internal lazy var doseInput =
        CustomTextFieldBuilder()
            .withPlaceholder(Text.dosePlaceholder)
            .withType(.numeric)
            .withTextAlignment(.center)
            .withMaxLength(AppLayout.AddCourse.doseFieldMaxLength)
            .withEndEditProcessor { [weak self] text in
                self?.delegate?.onPillDoseChanged(Double.init(text) ?? 0.0)
            }
            .build()
    internal lazy var stackDose = VStackViewFabric.generate([doseLabel, doseInput])

    // MARK: - Dose Unit
    internal lazy var doseUnitLabel = FieldHeaderFabric.generate(header: Text.unit)
    internal lazy var doseUnitInput =
        CustomTextFieldBuilder()
            .withPlaceholder(Text.unit)
            .withSimplePicker(options: []) { [weak self] option in
                self?.delegate?.onDoseUnitChanged(Text.Unit.init(rawValue: option) ?? .pill)
                return true
            }
            .withTextAlignment(.center)
            .build()
    internal lazy var stackDoseUnit = VStackViewFabric.generate([doseUnitLabel, doseUnitInput])

    internal lazy var stackDoseAndUnit =
        HStackViewFabric.generate([stackDose, stackDoseUnit], .fillEqually)

    // MARK: - Frequency Input
    internal lazy var frequencyInput: CustomTextField = {
        let textField = CustomTextFieldBuilder()
            .withSimplePicker(
                options: Text.Frequency.all(), { [weak self] (option) in
                    guard let self = self else {return false}
                    let freq = Text.Frequency.init(rawValue: option) ?? .someDaysInAWeek
                    switch freq {
                    case Text.Frequency.someDaysInAWeek:
                        self.receiveFreqStackView.showView(typeView: .certainDays)
                    case Text.Frequency.severalTimesInADay:
                        self.receiveFreqStackView.showView(typeView: .everyDayXTimesADay)
                    case Text.Frequency.everyNHoursInADay:
                        self.receiveFreqStackView.showView(typeView: .everyDayEveryXHour)
                    case Text.Frequency.everyNDaysAfterMDays:
                        self.receiveFreqStackView.showView(typeView: .daysCycle)
                    }
                    self.delegate?.onPillFreqChanged(freq)
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
    internal lazy var startLabel = FieldHeaderFabric.generate(header: Text.startFrom)
    internal lazy var startInput =
        CustomTextFieldBuilder()
            .withPlaceholder(CustomTextField.dateFormatter.string(from: Date()))
            .withImage(AppImages.Tools.calendar)
            .withDatePicker(.date , { [weak self] date in
                self?.delegate?.onStartDateChanged(date)
                return true
            })
            .build()
    internal lazy var stackStart = VStackViewFabric.generate([startLabel, startInput])

    // MARK: - Start Time Input
    internal lazy var timeLabel = FieldHeaderFabric.generate(header: Text.takeAtTime)
    internal lazy var timeInput =
        CustomTextFieldBuilder()
            .withPlaceholder(CustomTextField.timeFormatter.string(from: Date()))
            .withDatePicker(.time , { [weak self] time in
                self?.delegate?.onStartTimeChanged(time)
                return true
            })
            .build()
    internal let timePicker = UIDatePicker()
    internal lazy var stackTime = VStackViewFabric.generate([timeLabel, timeInput])
    internal lazy var stackStartAndWhen =
        HStackViewFabric.generate([stackStart, stackTime], .fillEqually)

    // MARK: - Period Input
    // simple input
    internal lazy var takePeriodLabel = FieldHeaderFabric.generate(header: Text.takePeriod)
    internal lazy var takePeriodInput =
        CustomTextFieldBuilder()
            .withPlaceholder(Text.takePeriodPlaceholder)
            .withType(.numeric)
            .withMaxLength(AppLayout.AddCourse.periodFieldMaxLength)
            .withEndEditProcessor { [weak self] text in
                self?.delegate?.onTakePeriodChanged(Int.init(text) ?? 1)
            }
            .clearOnFocus()
            .build()
    internal lazy var stackTakePeriod = VStackViewFabric.generate([takePeriodLabel, takePeriodInput])

    // date picker
    internal lazy var takePeriodDatePickerLabel =
        FieldHeaderFabric.generate(header: "")
    internal lazy var takePeriodDatePickerInput
        = CustomTextFieldBuilder()
            .withImage(AppImages.Tools.calendar)
            .withDatePicker(.date) { [weak self] tillDate in
                self?.delegate?.onTakePeriodTill(tillDate)
                return false
            }
            .build()
    internal lazy var stackTakeDatePickerPeriod
        = VStackViewFabric.generate([takePeriodDatePickerLabel, takePeriodDatePickerInput])

    internal lazy var stackTakePeriodWithDropDown: UIStackView = {
        let stack = HStackViewFabric.generate([
            stackTakePeriod,
            stackTakeDatePickerPeriod],
            .fill)
        stack.spacing = -AppLayout.CustomTextField.cornerRadius
        return stack
    }()

    // MARK: - Meal Dependency Input
    internal lazy var mealDependencyLabel =
        FieldHeaderFabric.generate(header: Text.instruction)
    internal lazy var mealDependencyInput: CustomTextField = {
        let textField = CustomTextFieldBuilder()
            .withSimplePicker(options: []) { [weak self] option in
                self?.delegate?.onMealDependencyChanged(Text.Usage.init(rawValue: option) ?? .noMatter)
                return true
            }
            .build()
        textField.placeholder = Text.instruction
        return textField
    }()
    internal lazy var stackMealDependency = VStackViewFabric.generate([mealDependencyLabel, mealDependencyInput])

    // MARK: - Note Input
    internal lazy var noteLabel =
        FieldHeaderFabric.generate(header: Text.notes)
    internal lazy var noteInput: UITextView = {
        let textField = UITextView()
        textField.isEditable = true
        textField.font = AppLayout.Fonts.normalRegular
        textField.backgroundColor = AppColors.white
        textField.layer.cornerRadius = AppLayout.CustomTextField.cornerRadius
        textField.delegate = self
        // onCommentChanged
        return textField
    }()
    internal lazy var stackNote = VStackViewFabric.generate([noteLabel, noteInput])
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = AppColors.lightBlue
        return scrollView
    }()
    
    // MARK: - Continue Button
    internal lazy var doneButton: AddButton = {
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
        delegate?.onSubmit()
    }

    // MARK: - Major Stack View
    internal lazy var formStackView: UIStackView = {
        guard let receiveFreqStackView = receiveFreqStackView as? ReceiveFreqPillsView
        else {
            return UIStackView()
        }
        let stack = VStackViewFabric.generate([
            stackPillName,
            stackTypeImageAndTypeName,
            stackDoseAndUnit,
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

    internal lazy var majorStackView: UIStackView = {
        let stackView = VStackViewFabric.generate([
                scrollView,
                doneButton
            ])
        stackView.spacing = AppLayout.AddCourse.horizontalSpacing
        return stackView
    }()
    internal var majorStackViewBottomAnchor: NSLayoutConstraint?

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
            typeImageHolder.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),
            pillTypeName.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),

            frequencyInput.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),

            startInput.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),
            timeInput.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),

            takePeriodInput.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),
            takePeriodDatePickerInput.heightAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),
            takePeriodDatePickerInput.widthAnchor
                .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight),
            
            noteInput.heightAnchor
                .constraint(greaterThanOrEqualToConstant: AppLayout.AddCourse.noteInputHeight)
        ])
    }
    
    // MARK: - Class Methods
    public func setup() {
        addSubviews()
        backgroundColor = AppColors.lightBlue
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

    private func addSubviews() {
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
}

extension AddNewCourseView: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.onCommentChanged(textView.text)
    }
}
