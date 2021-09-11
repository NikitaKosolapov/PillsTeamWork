//
//  RateView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 09.08.2021.
//

import UIKit

protocol RateViewDelegate: AnyObject {
    func badSmileButtonTouchUpInside()
    func normSmileButtonTouchUpInside()
    func bestSmileButtonTouchUpInside()
    func provideFeedbackButtonTouchUpInside()
    func noThanksButtonTouchUpInside()
}

final class RateView: UIView {
    
    // MARK: - Public Properties
    
    weak var rateViewDelegate: RateViewDelegate?
    
    // MARK: - Private Properties
    
    private let rateView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = AppColors.lightBlueRateViewBG
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.centerStyleLabel(
            font: AppLayout.Fonts.normalSemibold,
            text: Text.Rating.rateApp
        )
        label.textColor = AppColors.blackRateViewTopLabel
        return label
    }()
    
    private let badSmileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(AppImages.Rate.badSmile, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(badSmileButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private let normSmileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(AppImages.Rate.normSmile, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(normSmileButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private let bestSmileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(AppImages.Rate.okSmile, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(bestSmileButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private let badLabel: UILabel = {
        let label = UILabel()
        label.centerStyleLabel(
            font: AppLayout.Fonts.smallRegular,
            text: Text.Rating.badRate
        )
        return label
    }()
    
    private let normLabel: UILabel = {
        let label = UILabel()
        label.centerStyleLabel(
            font: AppLayout.Fonts.smallRegular,
            text: Text.Rating.normRate
        )
        return label
    }()
    
    private let bestLabel: UILabel = {
        let label = UILabel()
        label.centerStyleLabel(
            font: AppLayout.Fonts.smallRegular,
            text: Text.Rating.bestRate
        )
        return label
    }()
    
    private let provideFeedbackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.rateStyleButton(
            backgroundColor: AppColors.blue,
            text: Text.Rating.provideFeedback
        )
        button.addTarget(
            self,
            action: #selector(provideFeedbackButtonTouchUpInside),
            for: .touchUpInside
        )
        return button
    }()
    
    private let noThanksButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.rateStyleButton(
            backgroundColor: AppColors.red,
            text: Text.Rating.noThanks
        )
        button.addTarget(
            self,
            action: #selector(noThanksButtonTouchUpInside),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews:[
                titleLabel,
                horizontalButtonsLabelsStackView,
                horizontalButtonsStackView
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    private lazy var horizontalButtonsLabelsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                badButtonLabelStackView,
                normButtonLabelStackView,
                bestButtonLabelStackView
            ]
        )
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var badButtonLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [badSmileButton, badLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var normButtonLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [normSmileButton, normLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var bestButtonLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bestSmileButton, bestLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var horizontalButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [provideFeedbackButton, noThanksButton])
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
    
    @objc internal func badSmileButtonTouchUpInside() {
        rateViewDelegate?.badSmileButtonTouchUpInside()
    }
    
    @objc internal func normSmileButtonTouchUpInside() {
        rateViewDelegate?.normSmileButtonTouchUpInside()
    }
    
    @objc internal func bestSmileButtonTouchUpInside() {
        rateViewDelegate?.bestSmileButtonTouchUpInside()
    }
    
    @objc internal func provideFeedbackButtonTouchUpInside() {
        rateViewDelegate?.provideFeedbackButtonTouchUpInside()
    }
    
    @objc internal func noThanksButtonTouchUpInside() {
        rateViewDelegate?.noThanksButtonTouchUpInside()
    }
    
    private func configureUI() {
        isOpaque = false
        backgroundColor = AppColors.semiWhiteRateVCBG
        configureButtons()
        configureRateView()
        configureStackView()
    }
    
    private func configureButtons() {
        NSLayoutConstraint.activate(
            [badSmileButton.widthAnchor.constraint(equalToConstant: AppLayout.Rate.widthSmileImageView),
             badSmileButton.heightAnchor.constraint(equalToConstant:
                                                        AppLayout.Rate.heightSmileImageView),
             normSmileButton.widthAnchor.constraint(equalToConstant: AppLayout.Rate.widthSmileImageView),
             normSmileButton.heightAnchor.constraint(equalToConstant:
                                                        AppLayout.Rate.heightSmileImageView),
             bestSmileButton.widthAnchor.constraint(equalToConstant: AppLayout.Rate.widthSmileImageView),
             bestSmileButton.heightAnchor.constraint(equalToConstant:
                                                        AppLayout.Rate.heightSmileImageView),
             provideFeedbackButton.widthAnchor.constraint(equalToConstant: AppLayout.Rate.widthRateButton),
             provideFeedbackButton.heightAnchor.constraint(equalToConstant:
                                                            AppLayout.Rate.heightRateButton),
             noThanksButton.widthAnchor.constraint(equalToConstant: AppLayout.Rate.widthRateButton),
             noThanksButton.heightAnchor.constraint(equalToConstant:
                                                        AppLayout.Rate.heightRateButton)])
    }
    
    private func configureRateView() {
        addSubview(rateView)
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            [rateView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                           constant: AppLayout.Rate.topRateView),
             rateView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: AppLayout.Rate.leadingRateView),
             rateView.widthAnchor.constraint( equalToConstant: AppLayout.Rate.widthRateView),
             rateView.heightAnchor.constraint(equalToConstant: AppLayout.Rate.heightRateView)])
    }
    
    private func configureStackView() {
        rateView.addSubview(stackView)
        let safeArea = rateView.safeAreaLayoutGuide
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
