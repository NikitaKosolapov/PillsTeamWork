//
//  CustomTextField.swift
//  Pills
//
//  Created by aprirez on 8/12/21.
//

import UIKit

class CustomTextFieldBuilder {
    
    enum InputType {
        case numeric
        case readOnly
        case any
    }

    private let builtObject = CustomTextField()
    
    func withImage(_ image: UIImage? = AppImages.Tools.downArrow)
    -> CustomTextFieldBuilder {
        builtObject.setImage(image: image ?? UIImage())
        return self
    }
    
    func withType(_ type: InputType) -> CustomTextFieldBuilder {
        builtObject.isNumeric = (type == InputType.numeric)
        builtObject.readOnly = (type == InputType.readOnly)
        return self
    }

    func withMaxLength(_ maxLength: Int) -> CustomTextFieldBuilder {
        builtObject.maxLength = maxLength
        return self
    }
    
    func withPlaceholder(_ placeholder: String) -> CustomTextFieldBuilder {
        builtObject.placeholder = placeholder
        builtObject.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor : AppColors.placeholderGray])
        return self
    }
    
    func withEndEditProcessor(
        _ processor: @escaping (_ value: String) -> Void
    ) -> CustomTextFieldBuilder {
        builtObject.endEditProcessor = processor
        return self
    }
    
    func withDatePicker(_ mode: UIDatePicker.Mode, _ onDatePicked: @escaping ((_ date: Date) -> Bool)
    ) -> CustomTextFieldBuilder {
        builtObject.onDatePicked = onDatePicked
        builtObject.setupDatePicker(mode)
        return self
    }
    
    func withSimplePicker(options: [String], _ onPicked: @escaping ((_ option: String) -> Bool)
    ) -> CustomTextFieldBuilder {
        builtObject.onPicked = onPicked
        builtObject.setupPicker(options)
        return self
    }
    
    func withTextAlignment(_ alignment: NSTextAlignment) -> CustomTextFieldBuilder {
        builtObject.textAlignment = alignment
        return self
    }
    
    func clearOnFocus() -> CustomTextFieldBuilder {
        builtObject.clearOnFocus = true
        return self
    }
    
    func build() -> CustomTextField {
        return builtObject
    }
}

// swiftlint:disable type_body_length
class CustomTextField: UITextField {
	weak var addNewCourceTextFieldDelegate: AddNewCourceTextFieldDelegate?
    
    private var padding = UIEdgeInsets(
        top: AppLayout.CustomTextField.paddingTop,
        left: AppLayout.CustomTextField.paddingLeft,
        bottom: AppLayout.CustomTextField.paddingBottom,
        right: AppLayout.CustomTextField.paddingRight
    )
    private var imageView: UIImageView?

    private var toolbar: UIToolbar?

    var datePicker: UIDatePicker?
    var onDatePicked: ((_ date: Date) -> Bool)?

    var picker: UIPickerView?
    public var pickerOptions: [String] = []
    var onPicked: ((_ option: String) -> Bool)?
    
    var clearOnFocus = false
    var isNumeric = false
    var readOnly = false
    var maxLength: Int = -1
    
    var endEditProcessor: ((_ text: String) -> Void)?

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }()
    
    static let dateOfWeekFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEEE"
        return formatter
    }()

    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }()

    public var date: Date? {
        get {
            guard let datePicker = datePicker else {return nil}
            return datePicker.date
        }
        set {
            guard let datePicker = datePicker else {return}
            datePicker.date = newValue ?? datePicker.date
        }
    }

    private var customOptionImage: UIImageView? {
        willSet {
            self.customOptionImage?.removeFromSuperview()
        }
        didSet {
            guard let textImage = self.customOptionImage else {return}
            textImage.contentMode = .scaleAspectFit
            textImage.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(textImage)

            NSLayoutConstraint.activate([
                textImage.topAnchor
                    .constraint(equalTo: self.topAnchor, constant: 1),
                textImage.bottomAnchor
                    .constraint(equalTo: self.bottomAnchor, constant: -3),
                textImage.centerXAnchor
                    .constraint(equalTo: self.centerXAnchor),
                textImage.widthAnchor
                    .constraint(equalToConstant: AppLayout.CustomTextField.standardHeight - 4)
            ])

            setupPadding()
            self.placeholder = ""
        }
    }

    fileprivate init() {
        super.init(frame: CGRect())

        self.font = AppLayout.Fonts.normalRegular
        self.backgroundColor = AppColors.whiteAnthracite
        self.layer.cornerRadius = AppLayout.CustomTextField.cornerRadius
        self.delegate = self
    }
    
    fileprivate override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder: NSCode) is not implemented!")
    }
    
    private func setupPadding() {
        let right: CGFloat = (imageView != nil)
            ? AppLayout.CustomTextField.standardHeight
            : AppLayout.CustomTextField.paddingRight - 4
        let left: CGFloat = AppLayout.CustomTextField.paddingLeft - 4
        self.padding = UIEdgeInsets(
            top: 0, left: left,
            bottom: 0, right: right
        )
    }

    fileprivate func setImage(image: UIImage) {
        imageView = UIImageView()
        guard let imageView = imageView else {return}
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        setupPadding()
        self.addSubview(imageView)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        guard let imageView = imageView else {return}
        NSLayoutConstraint.activate([
            imageView.topAnchor
                .constraint(
                    equalTo: self.topAnchor,
                    constant: AppLayout.CustomTextField.paddingTop
                ),
            imageView.bottomAnchor
                .constraint(
                    equalTo: self.bottomAnchor,
                    constant: -AppLayout.CustomTextField.paddingBottom
                ),
            imageView.trailingAnchor
                .constraint(
                    equalTo: self.trailingAnchor,
                    constant: -AppLayout.CustomTextField.paddingLeft
                ),
            imageView.widthAnchor
                .constraint(
                    equalTo: self.heightAnchor,
                    constant: -(
                        AppLayout.CustomTextField.paddingTop +
                            AppLayout.CustomTextField.paddingBottom
                    )
                )
        ])
    }
    
    fileprivate func setupDatePicker(_ mode: UIDatePicker.Mode) {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = mode
        datePicker?.preferredDatePickerStyle = .wheels
        datePicker?.minimumDate = Date()
        datePicker?.date = Date()
        self.inputView = datePicker

        setupDatePickerToolbar()
        self.inputAccessoryView = toolbar
    }

    fileprivate func setupPicker(_ options: [String]) {
        picker = UIPickerView()
        pickerOptions = options
        picker?.delegate = self
        picker?.dataSource = self
        self.inputView = picker

        setupSimplePickerToolbar()
        self.inputAccessoryView = toolbar
    }

    private func setupDatePickerToolbar() {
        if toolbar != nil { return }

        // dumb fix for constraints errors,
        // see https://stackoverflow.com/questions/61966816/constraints-error-when-using-a-uipickerview
        // still have constraint issue when picker gone, but didn't find a solution yet
        // see discussion: https://github.com/hackiftekhar/IQKeyboardManager/issues/1616
        // AFAIU, any numbers can be here
        toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100.0, height: 44.0))
        guard let toolbar = toolbar,
              let datePicker = datePicker
        else {return}

        let doneButton = UIBarButtonItem(
            title: Text.DatePickerButtons.done,
            style: .plain,
            target: self,
            action: #selector(doneWithPicker)
        )

        let nowButton = UIBarButtonItem(
            title: datePicker.datePickerMode == .time
                ? Text.DatePickerButtons.now
                : Text.DatePickerButtons.today,
            style: .plain,
            target: self,
            action: #selector(donePickerWithNow)
        )

        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil, action: nil
        )

        let cancelButton = UIBarButtonItem(
            title: Text.DatePickerButtons.cancel,
            style: .plain,
            target: self,
            action: #selector(cancelPicker)
        )

        toolbar.setItems([cancelButton, nowButton, spaceButton, doneButton], animated: false)
    }
    
    private func setupSimplePickerToolbar() {
        if toolbar != nil { return }

        toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100.0, height: 44.0))
        guard let toolbar = toolbar
        else {return}

        let doneButton = UIBarButtonItem(
            title: Text.DatePickerButtons.done,
            style: .plain,
            target: self,
            action: #selector(doneWithSimplePicker)
        )

        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil, action: nil
        )

        let cancelButton = UIBarButtonItem(
            title: Text.DatePickerButtons.cancel,
            style: .plain,
            target: self,
            action: #selector(cancelPicker)
        )

        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    }
    @objc private func donePickerWithNow() {
        guard let datePicker = datePicker else {return}
        datePicker.date = Date()
        doneWithPicker()
    }

    @objc private func doneWithSimplePicker() {
        guard let picker = picker else {return}
        let row = picker.selectedRow(inComponent: 0)
        if false == onPicked?(pickerOptions[row]) {
            self.endEditing(true)
            return
        }
        self.text = pickerOptions[row].localized()
        self.endEditing(true)
    }

    @objc private func doneWithPicker() {
        guard let datePicker = datePicker else {return}
        if false == onDatePicked?(datePicker.date) {
            self.endEditing(true)
            return
        }
        switch datePicker.datePickerMode {
        case .date:
            self.text = CustomTextField.dateFormatter.string(from: datePicker.date)
        case .time:
            self.text = CustomTextField.timeFormatter.string(from: datePicker.date)
        case .dateAndTime:
            print("ERROR: CustomTextField.doneWithPicker, dateAndTime is not implemented")
        case .countDownTimer:
            print("ERROR: CustomTextField.doneWithPicker, countDownTimer is not implemented")
        @unknown default:
            print("ERROR: CustomTextField.doneWithPicker, unknown case")
        }
        self.endEditing(true)
    }

    @objc private func cancelPicker() {
        self.endEditing(true)
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        if datePicker != nil {
            return CGRect()
        }
        return super.caretRect(for: position)
    }
}
