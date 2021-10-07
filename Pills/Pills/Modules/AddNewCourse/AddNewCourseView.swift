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
    lazy var pillNameInput = CustomTextFieldBuilder()
        .withPlaceholder(Text.namePlaceholder)
        .withMaxLength(AppLayout.AddCourse.pillNameFieldMaxLength)
        .withEndEditProcessor { [weak self] text in
            self?.delegate?.onPillNameChanged(text)
        }
        .build()
    
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
        textField.addNewCourseDelegate = self
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
        textField.addNewCourseDelegate = self
        return textField
    }()
    
    let receiveFreqStackView = ReceiveFreqPillsView()
    
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
    
    // MARK: - Meal Dependency Input
    lazy var mealDependencyInput: CustomTextField = {
        let textField = CustomTextFieldBuilder()
            .withSimplePicker(options: []) { [weak self] option in
                self?.delegate?.onMealDependencyChanged(Text.Usage.init(rawValue: option) ?? .noMatter)
                return true
            }
            .withPlaceholder(Text.beforeMeal)
            .build()
        textField.addNewCourseDelegate = self
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
            stackMealDependency,
            stackNote
        ])
        stack.spacing = AppLayout.AddCourse.horizontalSpacing
        return stack
    }()
    
    lazy var majorStackView: UIStackView = {
        let stackView = VStackViewFabric.generate([
            scrollView,
            doneButton
        ])
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
        
        if majorStackViewBottomAnchor == nil {
            majorStackViewBottomAnchor = majorStackView.bottomAnchor
                .constraint(
                    equalTo: bottomAnchor,
                    constant: -UIScreen.main.safeAreaBottom
                )
        }
        
        typeImageHolder.addSubview(typeImage)
        
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
                .constraint(greaterThanOrEqualToConstant: AppLayout.AddCourse.noteInputHeight),
            
            typeImage.centerXAnchor
                .constraint(equalTo: typeImageHolder.centerXAnchor),
            typeImage.centerYAnchor
                .constraint(equalTo: typeImageHolder.centerYAnchor),
            typeImage.widthAnchor
                .constraint(equalToConstant: AppLayout.Journal.pillImageSize),
            typeImage.heightAnchor
                .constraint(equalToConstant: AppLayout.Journal.pillImageSize),
            
            doneButton.heightAnchor.constraint(equalToConstant: AppLayout.Journal.heightAddButton),
            
            pillNameInput.leadingAnchor.constraint(equalTo: stackPillName.leadingAnchor, constant: 0),
            pillNameInput.trailingAnchor.constraint(equalTo: stackPillName.trailingAnchor, constant: 0),
            pillNameInput.bottomAnchor.constraint(equalTo: stackPillName.bottomAnchor, constant: 0),
            pillNameLabel.leadingAnchor.constraint(equalTo: stackPillName.leadingAnchor, constant: 11),
            pillNameLabel.trailingAnchor.constraint(equalTo: stackPillName.trailingAnchor, constant: 0),
            pillNameLabel.topAnchor.constraint(equalTo: stackPillName.topAnchor, constant: 0),
            
            pillTypeNameLabel.leadingAnchor.constraint(equalTo: stackTypeName.leadingAnchor, constant: 11),
            pillTypeNameLabel.topAnchor.constraint(equalTo: stackTypeName.topAnchor, constant: 0),
            pillTypeNameLabel.trailingAnchor.constraint(equalTo: stackTypeName.trailingAnchor, constant: 0),
            pillTypeName.leadingAnchor.constraint(equalTo: stackTypeName.leadingAnchor, constant: 0),
            pillTypeName.trailingAnchor.constraint(equalTo: stackTypeName.trailingAnchor, constant: 0),
            pillTypeName.bottomAnchor.constraint(equalTo: stackTypeName.bottomAnchor, constant: 0),
            
            doseUnitLabel.leadingAnchor.constraint(equalTo: stackDoseUnit.leadingAnchor, constant: 11),
            doseUnitLabel.topAnchor.constraint(equalTo: stackDoseUnit.topAnchor, constant: 0),
            doseUnitLabel.trailingAnchor.constraint(equalTo: stackDoseUnit.trailingAnchor, constant: 0),
            doseUnitInput.leadingAnchor.constraint(equalTo: stackDoseUnit.leadingAnchor, constant: 0),
            doseUnitInput.trailingAnchor.constraint(equalTo: stackDoseUnit.trailingAnchor, constant: 0),
            doseUnitInput.bottomAnchor.constraint(equalTo: stackDoseUnit.bottomAnchor, constant: 0),
            
            doseLabel.leadingAnchor.constraint(equalTo: stackDose.leadingAnchor, constant: 11),
            doseLabel.topAnchor.constraint(equalTo: stackDose.topAnchor, constant: 0),
            doseLabel.trailingAnchor.constraint(equalTo: stackDose.trailingAnchor, constant: 0),
            doseInput.leadingAnchor.constraint(equalTo: stackDose.leadingAnchor, constant: 0),
            doseInput.trailingAnchor.constraint(equalTo: stackDose.trailingAnchor, constant: 0),
            doseInput.bottomAnchor.constraint(equalTo: stackDose.bottomAnchor, constant: 0),
            
            startLabel.leadingAnchor.constraint(equalTo: stackStart.leadingAnchor, constant: 11),
            startLabel.topAnchor.constraint(equalTo: stackStart.topAnchor, constant: 0),
            startLabel.trailingAnchor.constraint(equalTo: stackStart.trailingAnchor, constant: 0),
            startInput.leadingAnchor.constraint(equalTo: stackStart.leadingAnchor, constant: 0),
            startInput.trailingAnchor.constraint(equalTo: stackStart.trailingAnchor, constant: 0),
            startInput.bottomAnchor.constraint(equalTo: stackStart.bottomAnchor, constant: 0),
            
            timeLabel.leadingAnchor.constraint(equalTo: stackTime.leadingAnchor, constant: 11),
            timeLabel.topAnchor.constraint(equalTo: stackTime.topAnchor, constant: 0),
            timeLabel.trailingAnchor.constraint(equalTo: stackTime.trailingAnchor, constant: 0),
            timeInput.leadingAnchor.constraint(equalTo: stackTime.leadingAnchor, constant: 0),
            timeInput.trailingAnchor.constraint(equalTo: stackTime.trailingAnchor, constant: 0),
            timeInput.bottomAnchor.constraint(equalTo: stackTime.bottomAnchor, constant: 0),
            
            takePeriodLabel.leadingAnchor.constraint(equalTo: stackTakePeriod.leadingAnchor, constant: 11),
            takePeriodLabel.topAnchor.constraint(equalTo: stackTakePeriod.topAnchor, constant: 0),
            takePeriodLabel.trailingAnchor.constraint(equalTo: stackTakePeriod.trailingAnchor, constant: 0),
            takePeriodInput.leadingAnchor.constraint(equalTo: stackTakePeriod.leadingAnchor, constant: 0),
            takePeriodInput.trailingAnchor.constraint(equalTo: stackTakePeriod.trailingAnchor, constant: 0),
            takePeriodInput.bottomAnchor.constraint(equalTo: stackTakePeriod.bottomAnchor, constant: 0),
            
            mealDependencyLabel.leadingAnchor.constraint(equalTo: stackMealDependency.leadingAnchor, constant: 11),
            mealDependencyLabel.topAnchor.constraint(equalTo: stackMealDependency.topAnchor, constant: 0),
            mealDependencyLabel.trailingAnchor.constraint(equalTo: stackMealDependency.trailingAnchor, constant: 0),
            mealDependencyInput.leadingAnchor.constraint(equalTo: stackMealDependency.leadingAnchor, constant: 0),
            mealDependencyInput.trailingAnchor.constraint(equalTo: stackMealDependency.trailingAnchor, constant: 0),
            mealDependencyInput.bottomAnchor.constraint(equalTo: stackMealDependency.bottomAnchor, constant: 0),
            
            noteLabel.leadingAnchor.constraint(equalTo: stackNote.leadingAnchor, constant: 11),
            noteLabel.topAnchor.constraint(equalTo: stackNote.topAnchor, constant: 0),
            noteLabel.trailingAnchor.constraint(equalTo: stackNote.trailingAnchor, constant: 0),
            noteInput.leadingAnchor.constraint(equalTo: stackNote.leadingAnchor, constant: 0),
            noteInput.trailingAnchor.constraint(equalTo: stackNote.trailingAnchor, constant: 0),
            noteInput.bottomAnchor.constraint(equalTo: stackNote.bottomAnchor, constant: 0)
        ])
    }
    
    // MARK: - Public Methods
    
    public func setup() {
        addSubviews()
        backgroundColor = AppColors.lightBlueBlack
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
