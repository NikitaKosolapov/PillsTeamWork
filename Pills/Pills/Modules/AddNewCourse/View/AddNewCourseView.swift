//
//  AddNewCourseView.swift
//  Pills
//
//  Created by aprirez on 8/16/21.
//

import UIKit
import SnapKit

final class AddNewCourseView: UIView {
    
    // MARK: - Public Properties
    
    public weak var delegate: AddNewCourseDelegate?
    public weak var dataSource: AddNewCourseDataSourceProtocol? {
        willSet {
            pillTypeNameTF.pickerOptions = newValue?.pillTypeOptions() ?? []
            frequencyTF.pickerOptions = newValue?.frequencyOptions() ?? []
            mealDependencyTF.pickerOptions = newValue?.mealOptions() ?? []
        }
    }

    // MARK: - Private Properties
    
    private let receiveFreqStackView = ReceiveFreqPillsView()
    
    // stackPillName
    private lazy var pillNameLabel = LabelFabric.generateLabelWith(text: Text.name)
    
    public lazy var pillNameTF = CustomTextFieldBuilder()
        .withPlaceholder(Text.namePlaceholder)
        .withMaxLength(AppLayout.AddCourse.pillNameFieldMaxLength)
        .withEndEditProcessor { [weak self] text in
            self?.delegate?.onPillNameChanged(text)
        }
        .build()
    
    private lazy var stackPillName = VerticalStackViewFabric.generate([pillNameLabel, pillNameTF])
    
    // typeLabelAndStackTypeNameAndImage
    private lazy var pillTypeNameLabel = LabelFabric.generateLabelWith(text: Text.pillType)
    
    lazy var pillTypeNameTF: CustomTextField = CustomTextFieldBuilder()
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

    lazy var typeImageHolder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.whiteAnthracite
        view.layer.cornerRadius = AppLayout.CustomTextField.cornerRadius
        return view
    }()
    
    lazy var typeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = PillType.tablets.image()
        imageView.snp.makeConstraints {
            $0.size.equalTo(AppLayout.AddCourse.pillImageSize)
        }
        return imageView
    }()
    
    private lazy var stackTypeNameAndImage = HorizontalStackViewFabric.generate([pillTypeNameTF, typeImageHolder])
    private lazy var typeLabelAndStackTypeNameAndImage = VerticalStackViewFabric.generate([
        pillTypeNameLabel,
        stackTypeNameAndImage
    ])
    
    // doseLabelStackView
    private lazy var doseUnitLabel = LabelFabric.generateLabelWith(text: Text.unit)
    private lazy var doseLabel = LabelFabric.generateLabelWith(text: Text.dosePlaceholder)
    private lazy var doseLabelStackView = HorizontalStackViewFabric.generate([doseLabel, doseUnitLabel])
    
    // doseInputStackView
    lazy var doseInputTF = CustomTextFieldBuilder()
        .withPlaceholder(Text.singleDoseByNumber)
        .withType(.numeric)
        .withTextAlignment(.center)
        .withMaxLength(AppLayout.AddCourse.doseFieldMaxLength)
        .withEndEditProcessor { [weak self] text in
            self?.delegate?.onPillDoseChanged(Double.init(text) ?? 0.0)
        }
        .build()
    
    lazy var doseUnitTF: CustomTextField = {
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
    
    private lazy var doseInputStackView = HorizontalStackViewFabric.generate([doseInputTF, doseUnitTF])
    
    // frequencyTF
    lazy var frequencyTF: CustomTextField = {
        let textField = CustomTextFieldBuilder()
            .withSimplePicker(options: Frequency.all(), { [weak self] (option) in
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

    var certainDays: [String] = []
    var daysButtons: [UIButton] = []

    // timeLabelStackView
    private lazy var startTimeLabel = LabelFabric.generateLabelWith(text: Text.startFrom)
    private lazy var timeLabel = LabelFabric.generateLabelWith(text: Text.takeAtTime)
    private lazy var timeLabelStackView = HorizontalStackViewFabric.generate([startTimeLabel, timeLabel])
    
    // startTimeInputStackView
    lazy var startTF = CustomTextFieldBuilder()
        .withPlaceholder(CustomTextField.dateFormatter.string(from: Date()))
        .withImage(AppImages.Tools.calendar)
        .withDatePicker(.date , { [weak self] date in
            self?.delegate?.onStartDateChanged(date)
            return true
        })
        .build()
    
    lazy var timeTF = CustomTextFieldBuilder()
        .withPlaceholder(CustomTextField.timeFormatter.string(from: Date()))
        .withDatePicker(.time , { [weak self] time in
            self?.delegate?.onStartTimeChanged(time)
            return true
        })
        .build()

    var datesPeriod: [Date] = []
    var periodWeekDays: [String] = []

    private lazy var startTimeInputStackView = HorizontalStackViewFabric.generate([startTF, timeTF])
    
    // takeMedicineStackView
    private lazy var takeMedicineLabel = LabelFabric.generateLabelWith(text: Text.instruction)
    
    lazy var mealDependencyTF: CustomTextField = {
        let textField = CustomTextFieldBuilder()
            .withSimplePicker(options: []) { [weak self] option in
                self?.delegate?.onMealDependencyChanged(Text.Usage.init(rawValue: option) ?? .noMatter)
                return true
            }
            .withPlaceholder(Text.beforeMeal)
            .build()
        textField.placeholder = Text.instruction
        textField.addNewCourseDelegate = self
        return textField
    }()
    
    private lazy var takeMedicineStackView = VerticalStackViewFabric.generate([takeMedicineLabel, mealDependencyTF])
    
    // noteStackView
    private lazy var noteLabel = LabelFabric.generateLabelWith(text: Text.notes)
    
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
    
    private lazy var noteStackView = VerticalStackViewFabric.generate([noteLabel, noteInput])
    
    // saveButton
    lazy var saveButton: AddButton = {
        let button = AddButton()
        button.setTitle(Text.save, for: .normal)
        button.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()

    // scrollView
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = AppColors.lightBlueBlack
        return scrollView
    }()

    // containerView is a subView of scrollView and contains all UI elements
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = AppColors.lightBlueBlack
        return containerView
    }()
    
    // mainStackView
    private lazy var mainStackView = VerticalStackViewFabric.generate([
        stackPillName,
        typeLabelAndStackTypeNameAndImage,
        doseLabelStackView,
        doseInputStackView,
        frequencyTF,
        timeLabelStackView,
        startTimeInputStackView,
        takeMedicineStackView,
        noteStackView,
        saveButton
    ])
    
    // takePeriodInput
    lazy var takePeriodInput = CustomTextFieldBuilder()
        .withPlaceholder(Text.takePeriodPlaceholder)
        .withType(.numeric)
        .withMaxLength(AppLayout.AddCourse.periodFieldMaxLength)
        .withEndEditProcessor { [weak self] text in
            self?.delegate?.onTakePeriodChanged(Int.init(text) ?? 1)
        }
        .clearOnFocus()
        .build()
    
    // takePeriodDatePickerInput
    lazy var takePeriodDatePickerInput = CustomTextFieldBuilder()
        .withImage(AppImages.Tools.calendar)
        .withDatePicker(.date) { [weak self] tillDate in
            self?.delegate?.onTakePeriodTill(tillDate)
            return false
        }
        .build()

    lazy var majorStackView: UIStackView = {
        let stackView = VerticalStackViewFabric.generate([])
        stackView.spacing = AppLayout.AddCourse.horizontalSpacing
        return stackView
    }()
    var majorStackViewBottomAnchor: NSLayoutConstraint?
    var activeView: UIView?
    var keyboardHeight: CGFloat = 0.0
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func doneButtonPressed() {
        delegate?.onSubmit()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = AppColors.lightBlueBlack
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(mainStackView)
        typeImageHolder.addSubview(typeImage)
    }
    
    private func setupLayout() {
        // scrollView layout
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // containerView layout
        containerView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        // typeImage layout
        typeImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        // noteInput height
        noteInput.snp.makeConstraints {
            $0.height.equalTo(AppLayout.AddCourse.noteInputHeight)
        }
        
        // saveButton height
        saveButton.snp.makeConstraints {
            $0.height.equalTo(AppLayout.Journal.heightAddButton)
        }
        
        // mainStackView layout
        mainStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(AppLayout.AddCourse.horizontalSpacing)
            $0.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Public Methods
    
    public func setup() {
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
            majorStackViewBottomAnchor = majorStackView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -keyboardHeight - AppLayout.AddCourse.horizontalSpacing
            )
            majorStackViewBottomAnchor?.isActive = true
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        majorStackViewBottomAnchor?.isActive = false
        majorStackViewBottomAnchor = majorStackView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -UIScreen.main.safeAreaBottom
        )
        majorStackViewBottomAnchor?.isActive = true
    }
    
    func addEventToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        mainStackView.addGestureRecognizer(tapGesture)
        majorStackView.addGestureRecognizer(tapGesture)
        self.addGestureRecognizer(tapGesture)
    }
    
    func setScrollViewOffset(for textField: UIView) {
        let coveringContent = keyboardHeight + saveButton.frame.height + 2 * AppLayout.AddCourse.horizontalSpacing
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
                let coveringContent = keyboardHeight + 2 * AppLayout.AddCourse.horizontalSpacing
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

extension AddNewCourseView: AddNewCourseTextFieldDelegate {
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
