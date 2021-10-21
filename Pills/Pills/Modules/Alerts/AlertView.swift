//
//  AlertView.swift
//  Pills
//
//  Created by Margarita Novokhatskaia on 15.09.2021.
//

import SnapKit
import UIKit

class AlertView: UIView {
    
    enum AlertType {
        case deletePill
        case rate
        case addPill
    }
    
    // MARK: - Public Properties
    
    public var additionalField = UIView()
    
    // MARK: - Private Properties
    
    private let alertViewContainer: UIView = {
        return UIView()
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.centerStyleLabel(
            font: AppLayout.Fonts.bigSemibold,
            text: "Заголовок"
        )
        label.textColor = AppColors.black
        return label
    }()
    
    private let agreeButton: AddButton = {
        let button = AddButton()
        button.setButtonStyle(
            backgroundColor: AppColors.blue,
            text: "Yes",
            font: AppLayout.Fonts.normalRegular
        )
        button.addTarget(
            self,
            action: #selector(agreeButtonTouchUpInside),
            for: .touchUpInside
        )
        return button
    }()
    
    private let denyButton: AddButton = {
        let button = AddButton()
        button.setButtonStyle(
            backgroundColor: AppColors.red,
            text: "No",
            font: AppLayout.Fonts.normalRegular
        )
        button.addTarget(
            self,
            action: #selector(denyButtonTouchUpInside),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, additionalField, horizontalButtonsStackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = AppLayout.Alert.spacingVertical
        return stackView
    }()
    
    private lazy var horizontalButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [agreeButton, denyButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = AppLayout.Alert.spacingHorizontal
        return stackView
    }()
    
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
    
    @objc func agreeButtonTouchUpInside() {}
    
    @objc func denyButtonTouchUpInside() {}
    
    // MARK: - Public Methods
    
    public func configureText(title: String, agree: String, deny: String) {
        titleLabel.text = title
        agreeButton.setTitle(agree, for: .normal)
        denyButton.setTitle(deny, for: .normal)
    }
    
    public func configureHeight(height: CGFloat) {
        addSubview(alertViewContainer)
        alertViewContainer.snp.makeConstraints {
            $0.center.centerY.equalToSuperview()
            $0.height.equalTo(height)
            $0.leading.equalToSuperview().inset(AppLayout.Alert.leadingMainStackView)
        }
    }
    
    public func configureView() {
        configureHeight(height: AppLayout.Alert.heightView)
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        isOpaque = false
        backgroundColor = AppColors.semiWhite
        alertViewContainer.backgroundColor = AppColors.lightBlueSapphire
        
        alertViewContainer.layer.cornerCurve = .continuous
        alertViewContainer.layer.cornerRadius = AppLayout.Alert.cornerRadius
        
        configureView()
    }
    
    private func addSubviews() {
        alertViewContainer.addSubview(stackView)
    }
    
    private func setupLayout() {
        agreeButton.snp.makeConstraints {
            $0.height.equalTo(AppLayout.Alert.heightButton)
        }
        
        denyButton.snp.makeConstraints {
            $0.height.equalTo(AppLayout.Alert.heightButton)
        }
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(AppLayout.Alert.topStackView)
            $0.leading.trailing.equalToSuperview().inset(AppLayout.Alert.leadingStackView)
        }
    }
    
}
