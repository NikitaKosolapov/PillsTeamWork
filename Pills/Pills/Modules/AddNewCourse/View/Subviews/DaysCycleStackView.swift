//
//  DaysCycleStackView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 25.08.2021.
//

import SnapKit
import UIKit

protocol DaysCycleStackViewDelegate: AnyObject {
    func didEndEditing()
}

final class DaysCycleStackView: UIStackView {
    
    // MARK: - Public Properties
    
    public weak var delegate: DaysCycleStackViewDelegate?
    
    // MARK: - Private Properties
    
    private let xDaysLabelInsetView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let xDaysLabel: UILabel = {
        let label = UILabel()
        label.leftStyleLabel(font: AppLayout.Fonts.smallRegular, text: Text.xDays)
        return label
    }()
    
    private lazy var xDaysLabelStackView = HorizontalStackViewFactory.generate(
        [xDaysLabelInsetView, xDaysLabel],
        .fillProportionally,
        spacing: 0
    )
    
    private let xDaysTextField: UITextField = {
        let textField = CustomTextField()
        textField.centerStyleTextField(font: AppLayout.Fonts.normalRegular, text: "")
        textField.placeholder = ""
        textField.maxLength = AppLayout.AddCourse.textFieldsXDaysAndYDays
        textField.isNumeric = true
        return textField
    }()
    
    private lazy var xDaysStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [xDaysLabelStackView, xDaysTextField])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = AppLayout.AddCourse.vStackViewSpacing
        return stackView
    }()
    
    private let yDaysLabelInsetView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let yDaysLabel: UILabel = {
        let label = UILabel()
        label.leftStyleLabel(font: AppLayout.Fonts.smallRegular, text: Text.yDays)
        return label
    }()
    
    private lazy var yDaysLabelStackView = HorizontalStackViewFactory.generate(
        [yDaysLabelInsetView, yDaysLabel],
        .fillProportionally,
        spacing: 0
    )
    private let yDaysTextField: UITextField = {
        let textField = CustomTextField()
        textField.centerStyleTextField(font: AppLayout.Fonts.normalRegular, text: "")
        textField.placeholder = ""
        textField.maxLength = AppLayout.AddCourse.textFieldsXDaysAndYDays
        textField.isNumeric = true
        return textField
    }()
    
    private lazy var yDaysStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yDaysLabelStackView, yDaysTextField])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = AppLayout.AddCourse.vStackViewSpacing
        return stackView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureStackView()
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func getXDaysAndYDays() -> (Int, Int) {
        guard let xText = xDaysTextField.text,
              let yText = yDaysTextField.text
        else {
            return (0, 0)
        }
        return (Int(xText) ?? 0, Int(yText) ?? 0)
    }
    
    // MARK: - Private Methods
    
    private func configureStackView() {
        addArrangedSubviews(views: xDaysStackView, yDaysStackView)
        axis = .horizontal
        distribution = .fillEqually
        spacing = AppLayout.AddCourse.horizontalSpacing
    }
    
    private func setupLayout() {
        xDaysLabelInsetView.snp.makeConstraints { $0.width.equalTo(AppLayout.AddCourse.insetViewSize) }
        yDaysLabelInsetView.snp.makeConstraints { $0.width.equalTo(AppLayout.AddCourse.insetViewSize) }
    }
    
}
