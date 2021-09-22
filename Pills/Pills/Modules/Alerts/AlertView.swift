//
//  AlertView.swift
//  Pills
//
//  Created by Margarita Novokhatskaia on 15.09.2021.
//

import UIKit

class AlertView: UIView {
    
    enum AlertType {
        case description
        case rate
        case pill
    }

    // MARK: - Private Properties
    
    private let alertViewContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = AppLayout.Alert.cornerRadius
        view.backgroundColor = AppColors.lightBlueSapphire
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.centerStyleLabel(
            font: AppLayout.Fonts.normalSemibold,
            text: "Заголовок"
        )
        label.textColor = AppColors.black
        return label
    }()
    
    private let agreeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonStyle(
            backgroundColor: AppColors.blue,
            text: "Yes",
            font: AppLayout.Fonts.rateButtonSmall
        )
        button.addTarget(
            self,
            action: #selector(agreeButtonTouchUpInside),
            for: .touchUpInside
        )
        return button
    }()
    
    private let denyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonStyle(
            backgroundColor: AppColors.red,
            text: "No",
            font: AppLayout.Fonts.rateButtonSmall
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        stackView.spacing = AppLayout.Alert.spasingHorizontal
        return stackView
    }()
    
    var additionalField = UIView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureAlert(alertType: .description, title: "", agree: "", deny: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc internal func agreeButtonTouchUpInside() {
    }
    
    @objc internal func denyButtonTouchUpInside() {
    }
    
    func configureText(title: String, agree: String, deny: String) {
        titleLabel.text = title
        agreeButton.setTitle(agree, for: .normal)
        denyButton.setTitle(deny, for: .normal)
    }
    
    func configureAlert(alertType: AlertType, title: String, agree: String, deny: String) {
        configureViewContainer(alertType: alertType)
        configureText(title: title, agree: agree, deny: deny)
    }
    
    private func configureViewContainer(alertType: AlertType) {
        addSubview(alertViewContainer)
        let safeArea = safeAreaLayoutGuide
        
        let height: CGFloat = {
            switch alertType {
            case .description:
                return AppLayout.Alert.heightView
            case .rate:
                return AppLayout.Rate.heightView
            case .pill:
                return AppLayout.Alert.heightView
            }
        }()
        
        NSLayoutConstraint.activate([
            alertViewContainer.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                           constant: AppLayout.Alert.topView),
             alertViewContainer.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: AppLayout.Alert.leadingView),
             alertViewContainer.widthAnchor.constraint( equalToConstant: AppLayout.Alert.widthView),
            alertViewContainer.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        isOpaque = false
        backgroundColor = AppColors.semiWhite
        configureButtons()
        configureStackView()
    }
    
    private func configureButtons() {
        NSLayoutConstraint.activate(
            [agreeButton.widthAnchor.constraint(equalToConstant: AppLayout.Alert.widthButton),
             agreeButton.heightAnchor.constraint(equalToConstant:
                                                            AppLayout.Alert.heightButton),
             denyButton.widthAnchor.constraint(equalToConstant: AppLayout.Alert.widthButton),
             denyButton.heightAnchor.constraint(equalToConstant:
                                                        AppLayout.Alert.heightButton)])
    }
    
    private func configureStackView() {
        alertViewContainer.addSubview(stackView)
        let safeArea = alertViewContainer.safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            [stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: AppLayout.Alert.topStackView),
             stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                constant: AppLayout.Alert.leadingStackView),
             stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                 constant: AppLayout.Alert.trailingStackView),
             stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                               constant: AppLayout.Alert.bottomStackView)])
    }
}
