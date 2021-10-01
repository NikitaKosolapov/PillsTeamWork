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
    internal lazy var pillNameInput = CustomTextFieldBuilder()
        .withPlaceholder(Text.namePlaceholder)
        .withMaxLength(AppLayout.AddCourse.pillNameFieldMaxLength)
        .withEndEditProcessor { [weak self] text in
            self?.delegate?.onPillNameChanged(text)
        }
        .build()
    
    // MARK: - Type Input
    internal lazy var typeImageHolder: UIView = {
        let holder = UIView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.backgroundColor = AppColors.whiteAnthracite
        holder.layer.cornerRadius = AppLayout.CustomTextField.cornerRadius
        return holder
    }()
    
    internal lazy var typeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = PillType.tablets.image()
        return imageView
    }()
    
    internal lazy var pillTypeName: CustomTextField =
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
    
    // MARK: - Dose Unit
    internal lazy var doseUnitInput: CustomTextField = {
        let textField = CustomTextFieldBuilder()
            .withPlaceholder(Text.unit)
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
    internal lazy var frequencyInput: CustomTextField = {
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
    internal lazy var startInput =
    CustomTextFieldBuilder()
        .withPlaceholder(CustomTextField.dateFormatter.string(from: Date()))
        .withImage(AppImages.Tools.calendar)
        .withDatePicker(.date , { [weak self] date in
            self?.delegate?.onStartDateChanged(date)
            return true
        })
        .build()
    
    // MARK: - Start Time Input
    internal lazy var timeInput =
    CustomTextFieldBuilder()
        .withPlaceholder(CustomTextField.timeFormatter.string(from: Date()))
        .withDatePicker(.time , { [weak self] time in
            self?.delegate?.onStartTimeChanged(time)
            return true
        })
        .build()
    
    // MARK: - Period Input
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
    
    internal lazy var takePeriodDatePickerInput
    = CustomTextFieldBuilder()
        .withImage(AppImages.Tools.calendar)
        .withDatePicker(.date) { [weak self] tillDate in
            self?.delegate?.onTakePeriodTill(tillDate)
            return false
        }
        .build()
    
    // MARK: - Meal Dependency Input
    internal lazy var mealDependencyInput: CustomTextField = {
        let textField = CustomTextFieldBuilder()
            .withSimplePicker(options: []) { [weak self] option in
                self?.delegate?.onMealDependencyChanged(Text.Usage.init(rawValue: option) ?? .noMatter)
                return true
            }
            .build()
        textField.placeholder = Text.instruction
		textField.addNewCourseDelegate = self
        return textField
    }()
    
    // MARK: - Note Input
    internal lazy var noteInput: UITextView = {
        let textField = UITextView()
        textField.isEditable = true
        textField.font = AppLayout.Fonts.normalRegular
        textField.backgroundColor = AppColors.whiteAnthracite
        textField.layer.cornerRadius = AppLayout.CustomTextField.cornerRadius
        textField.delegate = self
        // onCommentChanged
        return textField
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = AppColors.lightBlueBlack
        return scrollView
    }()
    
    // MARK: - Continue Button
    
    internal lazy var doneButton: AddButton = {
        let button = AddButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Text.save, for: .normal)
        button.addTarget(
            self,
            action: #selector(doneButtonPressed),
            for: .touchUpInside
        )
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
    
    lazy var doseLabel = FieldHeaderFabric.generate(header: Text.dose)
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
    
    internal lazy var majorStackView: UIStackView = {
        let stackView = VStackViewFabric.generate([
            scrollView,
            doneButton
        ])
        stackView.spacing = AppLayout.AddCourse.horizontalSpacing
        return stackView
    }()
    internal var majorStackViewBottomAnchor: NSLayoutConstraint?
	var activeView: UIView?
	var keyboardHeight: CGFloat = 0.0

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
                .constraint(equalToConstant: AppLayout.Journal.pillImageSize.width),
            typeImage.heightAnchor
                .constraint(equalToConstant: AppLayout.Journal.pillImageSize.width),
            
            doneButton.heightAnchor.constraint(equalToConstant: AppLayout.Journal.heightAddButton)
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
    }
	func textViewDidBeginEditing(_ textView: UITextView) {
		activeView = textView
		setScrollViewOffset(for: activeView!)
	}
}

extension AddNewCourseView: AddNewCourceTextFieldDelegate {
	func textFieldStartEditing(_ textField: UITextField) {
		activeView = textField
		setScrollViewOffset(for: activeView!)
	}
}
