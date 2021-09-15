//
//  AlertView.swift
//  Pills
//
//  Created by Margarita Novokhatskaia on 15.09.2021.
//

import UIKit

class AlertView: UIView {
    
    // MARK: - Private Properties
    
    private let alertView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = AppColors.lightBlueSapphire
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.centerStyleLabel(
            font: AppLayout.Fonts.normalSemibold,
            text: "Какой-то текст"
        )
        label.textColor = AppColors.black
        return label
    }()
    
    private var additionalField = UIView()
    
    private let agreeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.rateStyleButton(
            backgroundColor: AppColors.blue,
            text: Text.Rating.provideFeedback
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
        button.rateStyleButton(
            backgroundColor: AppColors.red,
            text: Text.Rating.noThanks
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
        stackView.spacing = 15
        return stackView
    }()
    
    private lazy var horizontalButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [agreeButton, denyButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    @objc internal func agreeButtonTouchUpInside() {
    }
    
    @objc internal func denyButtonTouchUpInside() {
    }
    
    private func configureUI() {
        isOpaque = false
        backgroundColor = AppColors.semiWhite
        configureButtons()
        configureAlertView()
        configureStackView()
    }
    
    private func configureButtons() {
        NSLayoutConstraint.activate(
            [agreeButton.widthAnchor.constraint(equalToConstant: AppLayout.Rate.widthRateButton),
             agreeButton.heightAnchor.constraint(equalToConstant:
                                                            AppLayout.Rate.heightRateButton),
             denyButton.widthAnchor.constraint(equalToConstant: AppLayout.Rate.widthRateButton),
             denyButton.heightAnchor.constraint(equalToConstant:
                                                        AppLayout.Rate.heightRateButton)])
    }
    
    private func configureAlertView() {
        addSubview(alertView)
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            [alertView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                           constant: AppLayout.Rate.topRateView),
             alertView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: AppLayout.Rate.leadingRateView),
             alertView.widthAnchor.constraint( equalToConstant: AppLayout.Rate.widthRateView),
             alertView.heightAnchor.constraint(equalToConstant: 156)])
    }
    
    private func configureStackView() {
        alertView.addSubview(stackView)
        let safeArea = alertView.safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            [stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: AppLayout.Rate.topStackView),
             stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                constant: AppLayout.Rate.leadingStackView),
             stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                 constant: AppLayout.Rate.trailingStackView),
             stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                               constant: AppLayout.Rate.bottomStackView)])
    }
}
