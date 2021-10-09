//
//  AddNewCourseView.swift
//  Pills
//
//  Created by aprirez on 8/16/21.
//

import UIKit
import SnapKit

fileprivate final class VStackViewFabric {
    static func generate(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = AppLayout.AddCourse.vStackViewSpacing
        return stackView
    }
}

fileprivate final class HStackViewFabric {
    static func generate(_ views: [UIView],
                         _ distribution: UIStackView.Distribution = .fillEqually,
                         spacing: CGFloat = AppLayout.AddCourse.horizontalSpacing) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.distribution = distribution
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = spacing
        return stackView
    }
}

fileprivate final class FieldHeaderFabric {
    static func generate(header: String = "") -> UILabel {
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
    func onPillFreqTypeChanged(_ freq: Frequency)
    func onStartDateChanged(_ date: Date)
    func onStartTimeChanged(_ time: Date)
    func onTakePeriodChanged(_ days: Int)
    func onTakePeriodTill(_ tillDate: Date)
    func onMealDependencyChanged(_ usage: Text.Usage)
    func onCommentChanged(_ text: String)
    func onFrequencyDateChanged(_ frequency: ReceiveFreqPills)
    func onSubmit()
}

protocol AddNewCourceTextFieldDelegate: AnyObject {
    func textFieldStartEditing(_ textField: UITextField)
}

/// Data Source
protocol AddNewCourseDataSource: AnyObject {
    func pillTypeOptions() -> [String]
    func frequencyOptions() -> [String]
    func mealOptions() -> [String]
}

// swiftlint:disable type_body_length
// swiftlint:disable file_length
final class AddNewCourseView: UIView {
    
    public weak var delegate: AddNewCourseDelegate?
    public weak var dataSource: AddNewCourseDataSource? {
        willSet {
            pillTypeName.pickerOptions = newValue?.pillTypeOptions() ?? []
            frequencyInput.pickerOptions = newValue?.frequencyOptions() ?? []
            mealDependencyInput.pickerOptions = newValue?.mealOptions() ?? []
        }
    }
    
    // MARK: - Pill Name Input
    internal lazy var pillNameInput: CustomTextField = {
        let textField = CustomTextFieldBuilder()
            .withPlaceholder(Text.namePlaceholder)
            .withMaxLength(AppLayout.AddCourse.pillNameFieldMaxLength)
            .withEndEditProcessor { [weak self] text in
                self?.delegate?.onPillNameChanged(text)
            }
            .build()
        textField.addNewCourceTextFieldDelegate = self
        return textField
    }()
    
    // MARK: - Type Input
    lazy var typeImageHolder: UIView = {
        let holder = UIView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.backgroundColor = AppColors.whiteAnthracite
        holder.layer.cornerRadius = AppLayout.CustomTextField.cornerRadius
        return holder
    }()
    
    lazy var typeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = PillType.tablets.image()
        return imageView
    }()
    
    lazy var pillTypeName: CustomTextField =
        CustomTextFieldBuilder()
        .withPlaceholder(Text.Pills.tablets.rawValue.localized())
        .withTextAlignment(.center)
        .withSimplePicker(options: []) { [weak self] (option) in
            
            guard let self = self else {return true}
            let type = PillType.init(rawValue: option) ?? .tablets
            
            self.setPillType(type)
            self.delegate?.onPillTypeChanged(type)
            return true
        }
        .build()
    
    // MARK: - Dose Input
    lazy var doseInput =
        CustomTextFieldBuilder()
        .withPlaceholder(Text.singleDoseByNumber)
        .withType(.numeric)
        .withTextAlignment(.center)
        .withMaxLength(AppLayout.AddCourse.doseFieldMaxLength)
        .withEndEditProcessor { [weak self] text in
            self?.delegate?.onPillDoseChanged(Double.init(text) ?? 0.0)
        }
        .build()
    
    // MARK: - Dose Unit
    lazy var doseUnitInput: CustomTextField = {
        let textField = CustomTextFieldBuilder()
            .withPlaceholder(Text.mg)
            .withSimplePicker(options: []) { [weak self] option in
                self?.delegate?.onDoseUnitChanged(Text.Unit.init(rawValue: option) ?? .pill)
                return true
            }
            .withTextAlignment(.center)
            .build()
        textField.isUserInteractionEnabled = false
        textField.addNewCourceTextFieldDelegate = self
        return textField
    }()
    
    // MARK: - Frequency Input
    lazy var frequencyInput: CustomTextField = {
        let textField = CustomTextFieldBuilder()
            .withSimplePicker(
                options: Frequency.all(), { [weak self] (option) in
                    guard let self = self else {return false}
                    let freq = Frequency.init(rawValue: option) ?? .daysOfTheWeek
                    self.receiveFreqStackView.showView(with: freq)
                    self.delegate?.onPillFreqTypeChanged(freq)
                    return true
                })
            .withPlaceholder(Text.takingFrequency)
            .build()
        textField.addNewCourceTextFieldDelegate = self
        return textField
    }()
    
    let receiveFreqStackView = ReceiveFreqPillsView()
    var certainDays: [String] = []
    var daysButtons: [UIButton] = []
    
    // MARK: - Start Date Input
    lazy var startInput =
        CustomTextFieldBuilder()
        .withPlaceholder(CustomTextField.dateFormatter.string(from: Date()))
        .withImage(AppImages.Tools.calendar)
        .withDatePicker(.date , { [weak self] date in
            self?.delegate?.onStartDateChanged(date)
            return true
        })
        .build()
    
    // MARK: - Start Time Input
    lazy var timeInput =
        CustomTextFieldBuilder()
        .withPlaceholder(CustomTextField.timeFormatter.string(from: Date()))
        .withDatePicker(.time , { [weak self] time in
            self?.delegate?.onStartTimeChanged(time)
            return true
        })
        .build()
    
    // MARK: - Period Input
    lazy var takePeriodInput =
        CustomTextFieldBuilder()
        .withPlaceholder(Text.takePeriodPlaceholder)
        .withType(.numeric)
        .withMaxLength(AppLayout.AddCourse.periodFieldMaxLength)
        .withEndEditProcessor { [weak self] text in
            self?.delegate?.onTakePeriodChanged(Int.init(text) ?? 1)
        }
        .clearOnFocus()
        .build()
    
    lazy var takePeriodDatePickerInput
        = CustomTextFieldBuilder()
        .withImage(AppImages.Tools.calendar)
        .withDatePicker(.date) { [weak self] tillDate in
            self?.delegate?.onTakePeriodTill(tillDate)
            return false
        }
        .build()
    
    var datesPeriod: [Date] = []
    var periodWeekDays: [String] = []
    // MARK: - Meal Dependency Input
    lazy var mealDependencyInput: CustomTextField = {
        let textField = CustomTextFieldBuilder()
            .withSimplePicker(options: []) { [weak self] option in
                self?.delegate?.onMealDependencyChanged(Text.Usage.init(rawValue: option) ?? .noMatter)
                return true
            }
            .withPlaceholder(Text.beforeMeal)
            .build()
        textField.placeholder = Text.instruction
        textField.addNewCourceTextFieldDelegate = self
        return textField
    }()
    
    // MARK: - Note Input
    lazy var noteInput: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.font = AppLayout.Fonts.normalRegular
        textView.backgroundColor = AppColors.whiteAnthracite
        textView.layer.cornerRadius = AppLayout.CustomTextField.cornerRadius
        textView.textColor = AppColors.placeholderGray
        textView.text = Text.featuresOfTaking
        textView.delegate = self
        // onCommentChanged
        return textView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = AppColors.lightBlueBlack
        return scrollView
    }()
    
    // MARK: - Continue Button
    
    lazy var doneButton: AddButton = {
        let button = AddButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Text.save, for: .normal)
        button.addTarget(
            self,
            action: #selector(doneButtonPressed),
            for: .touchUpInside
        )
        button.isEnabled = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: AppLayout.Journal.heightAddButton)
        ])
        return button
    }()
    
    lazy var pillNameLabel = FieldHeaderFabric.generate(header: Text.name)
    lazy var stackPillName = VStackViewFabric.generate([pillNameLabel, pillNameInput])
    lazy var typeLabel = FieldHeaderFabric.generate()
    lazy var stackTypeImage = VStackViewFabric.generate([typeLabel, typeImageHolder])
    lazy var pillTypeNameLabel = FieldHeaderFabric.generate(header: Text.pillType)
    lazy var stackTypeName = VStackViewFabric.generate([pillTypeNameLabel, pillTypeName])
    lazy var stackTypeImageAndTypeName = HStackViewFabric.generate([stackTypeName, stackTypeImage])
    lazy var doseUnitLabel = FieldHeaderFabric.generate(header: Text.unit)
    lazy var stackDoseUnit = VStackViewFabric.generate([doseUnitLabel, doseUnitInput])
    lazy var doseLabel = FieldHeaderFabric.generate(header: Text.dosePlaceholder)
    lazy var stackDose = VStackViewFabric.generate([doseLabel, doseInput])
    lazy var stackDoseAndUnit = HStackViewFabric.generate([stackDose, stackDoseUnit])
    lazy var startLabel = FieldHeaderFabric.generate(header: Text.startFrom)
    lazy var stackStart = VStackViewFabric.generate([startLabel, startInput])
    lazy var timeLabel = FieldHeaderFabric.generate(header: Text.takeAtTime)
    lazy var stackTime = VStackViewFabric.generate([timeLabel, timeInput])
    lazy var stackStartAndWhen = HStackViewFabric.generate([stackStart, stackTime])
    lazy var takePeriodDatePickerLabel = FieldHeaderFabric.generate()
    lazy var stackTakeDatePickerPeriod = VStackViewFabric.generate([takePeriodDatePickerLabel,
                                                                    takePeriodDatePickerInput])
    lazy var takePeriodLabel = FieldHeaderFabric.generate(header: Text.takePeriod)
    lazy var stackTakePeriod = VStackViewFabric.generate([takePeriodLabel, takePeriodInput])
    lazy var mealDependencyLabel = FieldHeaderFabric.generate(header: Text.instruction)
    lazy var stackMealDependency = VStackViewFabric.generate([mealDependencyLabel, mealDependencyInput])
    lazy var noteLabel = FieldHeaderFabric.generate(header: Text.notes)
    lazy var stackNote = VStackViewFabric.generate([noteLabel, noteInput])
    
    lazy var stackTakePeriodWithDropDown = HStackViewFabric.generate(
        [stackTakePeriod, stackTakeDatePickerPeriod],
        .fill,
        spacing: -AppLayout.CustomTextField.cornerRadius * 2)
    
    @objc func doneButtonPressed() {
        delegate?.onSubmit()
    }
    
    // MARK: - Major Stack View
    lazy var formStackView: UIStackView = {
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
    
    lazy var majorStackView: UIStackView = {
        let stackView = VStackViewFabric.generate([scrollView, doneButton])
        stackView.spacing = AppLayout.AddCourse.horizontalSpacing
        return stackView
    }()
    var majorStackViewBottomAnchor: NSLayoutConstraint?
    var activeView: UIView?
    var keyboardHeight: CGFloat = 0.0
    
    // MARK: - Constraints
    // swiftlint:disable function_body_length
    override func updateConstraints() {
        super.updateConstraints()
        
        majorStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(AppLayout.AddCourse.horizontalSpacing)
        }
        
        formStackView.snp.makeConstraints {
            $0.top.leading.width.equalToSuperview()
        }
        
        pillNameInput.snp.makeConstraints {
            $0.height.equalTo(AppLayout.CustomTextField.standardHeight)
        }
        
        doseInput.snp.makeConstraints {
            $0.height.equalTo(AppLayout.CustomTextField.standardHeight)
        }
        
        doseUnitInput.snp.makeConstraints {
            $0.height.equalTo(AppLayout.CustomTextField.standardHeight)
        }
        
        typeImageHolder.snp.makeConstraints {
            $0.height.equalTo(AppLayout.CustomTextField.standardHeight)
        }
        
        pillTypeName.snp.makeConstraints {
            $0.height.equalTo(AppLayout.CustomTextField.standardHeight)
        }
        
        frequencyInput.snp.makeConstraints {
            $0.height.equalTo(AppLayout.CustomTextField.standardHeight)
        }
        
        startInput.snp.makeConstraints {
            $0.height.equalTo(AppLayout.CustomTextField.standardHeight)
        }
        
        timeInput.snp.makeConstraints {
            $0.height.equalTo(AppLayout.CustomTextField.standardHeight)
        }
        
        takePeriodInput.snp.makeConstraints {
            $0.height.equalTo(AppLayout.CustomTextField.standardHeight)
        }
        
        takePeriodDatePickerInput.snp.makeConstraints {
            $0.height.width.equalTo(AppLayout.CustomTextField.standardHeight)
        }
        
        noteInput.snp.makeConstraints {
            $0.height.width.equalTo(AppLayout.AddCourse.noteInputHeight)
        }
        
        typeImage.snp.makeConstraints {
            $0.size.equalTo(AppLayout.Journal.pillImageSize)
            $0.centerX.centerY.equalToSuperview()
        }
        
        doneButton.snp.makeConstraints {
            $0.height.equalTo(AppLayout.Journal.heightAddButton)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        pillNameInput.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        pillNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(AppLayout.Journal.pillNameLabelPaddingLeft)
        }
        
        pillTypeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(AppLayout.Journal.pillNameLabelPaddingLeft)
        }
        
        pillTypeName.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        doseUnitLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(AppLayout.Journal.pillNameLabelPaddingLeft)
        }
        
        doseUnitInput.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        doseLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(AppLayout.Journal.pillNameLabelPaddingLeft)
        }
        
        doseInput.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        startLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(AppLayout.Journal.pillNameLabelPaddingLeft)
        }
        
        startInput.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(AppLayout.Journal.pillNameLabelPaddingLeft)
        }
        
        timeInput.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        takePeriodLabel.snp.makeConstraints {
            $0.top.equalTo(stackTakePeriod.snp.top)
            $0.trailing.equalTo(stackTakePeriod.snp.trailing)
            $0.leading.equalTo(stackTakePeriod.snp.leading).inset(AppLayout.Journal.pillNameLabelPaddingLeft)
        }
        
        takePeriodInput.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        mealDependencyLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(AppLayout.Journal.pillNameLabelPaddingLeft)
        }
        
        mealDependencyInput.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        noteLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(AppLayout.Journal.pillNameLabelPaddingLeft)
        }
        
        noteInput.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Public Methods
    
    public func setup() {
        addSubviews()
        backgroundColor = AppColors.lightBlueBlack
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
            
            majorStackViewBottomAnchor?.isActive = false
            majorStackViewBottomAnchor = majorStackView.bottomAnchor
                .constraint(
                    equalTo: bottomAnchor,
                    constant: -keyboardHeight - AppLayout.AddCourse.horizontalSpacing
                )
            majorStackViewBottomAnchor?.isActive = true
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        majorStackViewBottomAnchor?.isActive = false
        majorStackViewBottomAnchor = majorStackView.bottomAnchor
            .constraint(
                equalTo: bottomAnchor,
                constant: -UIScreen.main.safeAreaBottom
            )
        majorStackViewBottomAnchor?.isActive = true
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        typeImageHolder.addSubview(typeImage)
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
    
    func addEventToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        formStackView.addGestureRecognizer(tapGesture)
        majorStackView.addGestureRecognizer(tapGesture)
        self.addGestureRecognizer(tapGesture)
    }
    
    func setScrollViewOffset(for textField: UIView) {
        let coveringContent = keyboardHeight + doneButton.frame.height + 2 * AppLayout.AddCourse.horizontalSpacing
        let visibleContent = self.frame.height - coveringContent
        var contentOffset = CGPoint(x: 0, y: 0)
        
        let middleOfVisibleArea = visibleContent / 2
        let middleOfField = textField.convert(textField.bounds, to: self).midY
        
        if middleOfField <= middleOfVisibleArea {
            contentOffset = CGPoint(x: 0, y: 0)
        } else {
            contentOffset =  CGPoint(x: 0, y: middleOfField - middleOfVisibleArea)
            var actualContentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y + contentOffset.y)
            if actualContentOffset.y > visibleContent {
                actualContentOffset = CGPoint(x: 0, y: visibleContent)
            }
            scrollView.setContentOffset(actualContentOffset, animated: true)
        }
    }
    
    func createScheduleDays(from certainDays: [String], from period: [Date]) {
        guard !certainDays.isEmpty && !period.isEmpty else { return }
        
        let scheduleDates = period
            .filter { certainDays.contains(CustomTextField.dateOfWeekFormatter.string(from: $0)) }
            .sorted()        
        delegate?.onFrequencyDateChanged(ReceiveFreqPills.daysOfTheWeek(scheduleDates))
    }
    
    func disableWrongButtons(for buttons: [UIButton], on dates: [Date]) {
        
        if dates.count < Text.DaysOfAWeek.allCases.count {
            periodWeekDays = []
            let weekDays = Text.DaysOfAWeek.all()
            
            dates.forEach { periodWeekDays.append(CustomTextField.dateOfWeekFormatter.string(from: $0).lowercased()) }
            
            for (index, weekDay) in weekDays.enumerated() {
                if !periodWeekDays.contains(weekDay.lowercased()) {
                    receiveFreqStackView.certainDaysStackView.dayOfWeekButtonArray[index].isSelected = false
                    receiveFreqStackView.certainDaysStackView.dayOfWeekButtonArray[index]
                        .setImage(AppImages.AddCourse.notEnable, for: .normal)
                    receiveFreqStackView.certainDaysStackView.dayOfWeekButtonArray[index].isEnabled = false
                } else {
                    receiveFreqStackView.certainDaysStackView.dayOfWeekButtonArray[index]
                        .setImage(AppImages.AddCourse.noCheck, for: .normal)
                    receiveFreqStackView.certainDaysStackView.dayOfWeekButtonArray[index].isEnabled = true
                }
            }
            
            func setScrollViewOffset(for textField: UIView) {
                let coveringContent = keyboardHeight + doneButton.frame.height + 2 * AppLayout.AddCourse.horizontalSpacing
                let visibleContent = self.frame.height - coveringContent
                var contentOffset = CGPoint(x: 0, y: 0)
                
                let middleOfVisibleArea = visibleContent / 2
                let middleOfField = textField.convert(textField.bounds, to: self).midY
                
                if middleOfField <= middleOfVisibleArea {
                    contentOffset = CGPoint(x: 0, y: 0)
                } else {
                    receiveFreqStackView.certainDaysStackView.dayOfWeekButtonArray.forEach { button in
                        button.setImage(AppImages.AddCourse.noCheck, for: .normal)
                        button.isEnabled = true
                    }
                }
            }
        }
    }
}

extension AddNewCourseView: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        activeView = nil
        delegate?.onCommentChanged(textView.text)
        
        if textView.text.isEmpty {
            textView.text = Text.featuresOfTaking
            textView.textColor = AppColors.placeholderGray
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        activeView = textView
        setScrollViewOffset(for: activeView!)
        
        if textView.textColor == AppColors.placeholderGray {
            textView.text = nil
            textView.textColor = AppColors.black
        }
    }
}

extension AddNewCourseView: AddNewCourceTextFieldDelegate {
    func textFieldStartEditing(_ textField: UITextField) {
        activeView = textField
        setScrollViewOffset(for: activeView!)
    }
}

extension AddNewCourseView: ReceiveFreqPillsDelegate {
    func frequencyDidChange() -> ReceiveFreqPills {
        let mock: [Date] = []
        return ReceiveFreqPills.daysOfTheWeek(mock)
    }
    
    func certainDaysDidChange(on days: [String]) {
        certainDays = days
        createScheduleDays(from: certainDays, from: datesPeriod)
    }
}
