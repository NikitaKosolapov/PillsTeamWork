//
//  AddNewCourseView.swift
//  Pills
//
//  Created by aprirez on 8/16/21.
//

import UIKit
import SnapKit

// swiftlint:disable file_length
// swiftlint:disable type_body_length

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
    
    // takePeriodInput is using in AddNewCourseView+PublicInterface
    public lazy var takePeriodInput = CustomTextFieldBuilder()
        .withPlaceholder(Text.takePeriodPlaceholder)
        .withImage(AppImages.Tools.calendar)
        .withType(.numeric)
        .withMaxLength(AppLayout.AddCourse.periodFieldMaxLength)
        .withEndEditProcessor { [weak self] text in
            self?.delegate?.onTakePeriodChanged(Int.init(text) ?? 1)
        }
        .clearOnFocus()
        .build()
    
    // takePeriodDatePickerInput is using in AddNewCourseView+PublicInterface
    public lazy var takePeriodDatePickerInput = CustomTextFieldBuilder()
        .withImage(AppImages.Tools.calendar)
        .withDatePicker(.date) { [weak self] tillDate in
            self?.delegate?.onTakePeriodTill(tillDate)
            return false
        }
        .build()

    // MARK: - Private Properties
    
    private let receiveFreqStackView = ReceiveFreqPillsView()
    private var activeView: UIView?
    private var keyboardHeight: CGFloat = 0.0
    
    // stackPillName
    private lazy var leftInsetNameView = ViewFabric.generateView()
    private lazy var pillNameLabel = LabelFabric.generateLabelWith(text: Text.name)
    private lazy var pillNameStackView = HorizontalStackViewFabric.generate(
        [leftInsetNameView, pillNameLabel],
        .fillProportionally,
        spacing: 0
    )
    
    public lazy var pillNameTF = CustomTextFieldBuilder()
        .withPlaceholder(Text.namePlaceholder)
        .withMaxLength(AppLayout.AddCourse.pillNameFieldMaxLength)
        .withEndEditProcessor { [weak self] text in
            self?.delegate?.onPillNameChanged(text)
        }
        .build()
    
    private lazy var stackPillName = VerticalStackViewFabric.generate([pillNameStackView, pillNameTF])
    
    // typeLabelAndStackTypeNameAndImage
    private lazy var leftInsetTypeView = ViewFabric.generateView()
    private lazy var pillTypeNameLabel = LabelFabric.generateLabelWith(text: Text.pillType)
    private lazy var pillTypeNameStackView = HorizontalStackViewFabric.generate(
        [leftInsetTypeView, pillTypeNameLabel],
        .fillProportionally,
        spacing: 0
    )
    
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
        pillTypeNameStackView,
        stackTypeNameAndImage
    ])
    
    // doseLabelStackView
    private lazy var leftInsetDoseUnitView = ViewFabric.generateView()
    private lazy var doseUnitLabel = LabelFabric.generateLabelWith(text: Text.unit)
    private lazy var doseUnitAndViewStackView = HorizontalStackViewFabric.generate([
        leftInsetDoseUnitView,
        doseUnitLabel
    ], .fillProportionally, spacing: 0)
    private lazy var leftInsetDoseView = ViewFabric.generateView()
    private lazy var doseLabel = LabelFabric.generateLabelWith(text: Text.dosePlaceholder)
    private lazy var doseLabelAndViewStackView = HorizontalStackViewFabric.generate([
        leftInsetDoseView,
        doseLabel
    ], .fillProportionally, spacing: 0)
    private lazy var doseLabelStackView = HorizontalStackViewFabric.generate([
        doseLabelAndViewStackView,
        doseUnitAndViewStackView
    ], .fillEqually, spacing: AppLayout.AddCourse.horizontalSpacing)
    
    // doseTFStackView
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
    
    // doseLabelStackView and doseTFStackView
    private lazy var doseLabelAndDoseInputStackView = VerticalStackViewFabric.generate([
        doseLabelStackView,
        doseInputStackView
    ])
    
    // takingDuration
    private lazy var leftInsetTakingDurationView = ViewFabric.generateView()
    private lazy var takingDurationLabel = LabelFabric.generateLabelWith(text: Text.takePeriod)
    private lazy var takingDurationLabelStackView = HorizontalStackViewFabric.generate([
        leftInsetTakingDurationView,
        takingDurationLabel
    ], .fillProportionally, spacing: 0)
    
    private lazy var takingDurationLabelAndTFStackView = VerticalStackViewFabric.generate([
        takingDurationLabelStackView,
        takePeriodInput
    ])
    
    // takingFrequencyLabelAndTFStackView
    private lazy var leftInseFrequencyView = ViewFabric.generateView()
    private lazy var takingFrequencyLabel = LabelFabric.generateLabelWith(text: Text.takingFrequencyTitle)
    private lazy var takingFrequencyStackView = HorizontalStackViewFabric.generate([
        leftInseFrequencyView,
        takingFrequencyLabel
    ], .fillProportionally, spacing: 0)
    
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

    private lazy var takingFrequencyLabelAndTFStackView = VerticalStackViewFabric.generate([
        takingFrequencyStackView,
        frequencyTF
    ])

    // timeLabelStackView
    private lazy var leftInsetStartTimeView = ViewFabric.generateView()
    private lazy var startTimeLabel = LabelFabric.generateLabelWith(text: Text.startFrom)
    private lazy var startTimeAndViewStackView = HorizontalStackViewFabric.generate([
        leftInsetStartTimeView,
        startTimeLabel
    ], .fillProportionally, spacing: 0)
    private lazy var leftInsetTimeView = ViewFabric.generateView()
    private lazy var timeLabel = LabelFabric.generateLabelWith(text: Text.takeAtTime)
    private lazy var timeAndViewStackView = HorizontalStackViewFabric.generate([
        leftInsetTimeView,
        timeLabel
    ], .fillProportionally, spacing: 0)
    private lazy var timeLabelStackView = HorizontalStackViewFabric.generate([
        startTimeAndViewStackView,
        timeAndViewStackView
    ], .fillEqually, spacing: AppLayout.AddCourse.horizontalSpacing)
    
    // startTimeTFStackView
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
    
    // timeLabelStackView and startTimeInputStackView
    private lazy var timeLabelAndStartTimeInputStackView = VerticalStackViewFabric.generate([
        timeLabelStackView,
        startTimeInputStackView
    ])
    
    // takeMedicineStackView
    private lazy var leftInsetTakeMedicineView = ViewFabric.generateView()
    private lazy var takeMedicineLabel = LabelFabric.generateLabelWith(text: Text.instruction)
    private lazy var takeMedicineLabelStackView = HorizontalStackViewFabric.generate(
        [leftInsetTakeMedicineView, takeMedicineLabel],
        .fillProportionally,
        spacing: 0
    )
    
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
    
    private lazy var takeMedicineStackView = VerticalStackViewFabric.generate(
        [takeMedicineLabelStackView, mealDependencyTF]
    )
    
    // noteStackView
    private lazy var leftInsetNoteView = ViewFabric.generateView()
    private lazy var noteLabel = LabelFabric.generateLabelWith(text: Text.notes)
    private lazy var noteLabelStackView = HorizontalStackViewFabric.generate(
        [leftInsetNoteView, noteLabel],
        .fillProportionally,
        spacing: 0
    )
    
    lazy var noteInput: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.font = AppLayout.Fonts.normalRegular
        textView.backgroundColor = AppColors.whiteAnthracite
        textView.layer.cornerRadius = AppLayout.CustomTextField.cornerRadius
        textView.textColor = AppColors.placeholderGray
        textView.text = Text.featuresOfTaking
        textView.delegate = self
        return textView
    }()
    
    private lazy var noteStackView = VerticalStackViewFabric.generate([noteLabelStackView, noteInput])
    
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
    private lazy var mainStackView = VerticalStackViewFabric.generate(
        spacing: AppLayout.AddCourse.vMainStackViewSpacing,
        [
            stackPillName,
            typeLabelAndStackTypeNameAndImage,
            doseLabelAndDoseInputStackView,
            timeLabelAndStartTimeInputStackView,
            takingDurationLabelAndTFStackView,
            takingFrequencyLabelAndTFStackView,
            takeMedicineStackView,
            noteStackView
        ]
    )
    
    // majorStackView
    private lazy var majorStackView = VerticalStackViewFabric.generate(
        spacing: AppLayout.AddCourse.horizontalSpacing,
        [scrollView]
    )
    
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
        addSubview(majorStackView)
        addSubview(saveButton)
        scrollView.addSubview(containerView)
        containerView.addSubview(mainStackView)
        typeImageHolder.addSubview(typeImage)
    }
    
    private func setupLayout() {
        // majorStackView layout
        majorStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
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
        
        // saveButton layout
        saveButton.snp.makeConstraints {
            $0.height.equalTo(AppLayout.Journal.heightAddButton)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(AppLayout.AddCourse.horizontalSpacing)
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
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
            majorStackView.snp.updateConstraints {
                $0.bottom.equalTo(-keyboardHeight - AppLayout.AddCourse.horizontalSpacing)
            }
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        majorStackView.snp.updateConstraints { $0.bottom.equalTo(-UIScreen.main.safeAreaBottom) }
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
