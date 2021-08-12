//
//  RateView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 09.08.2021.
//

import UIKit

class RateView: UIView {
    // MARK: Subviews
    private let rateView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.Rate.backgroundRateView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = Text.Rating.rateApp
        label.font = AppLayout.Fonts.normalSemibold
        label.textColor = AppColors.black
        return label
    }()
    
    let badSmileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(AppImages.Rate.badSmile, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let normSmileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(AppImages.Rate.normSmile, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let bestSmileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(AppImages.Rate.okSmile, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let badLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = Text.Rating.badRate
        label.font = AppLayout.Fonts.smallRegular
        label.textColor = AppColors.black
        return label
    }()
    
    private let normLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = Text.Rating.normRate
        label.font = AppLayout.Fonts.smallRegular
        label.textColor = AppColors.black
        return label
    }()
    
    private let bestLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = Text.Rating.bestRate
        label.font = AppLayout.Fonts.smallRegular
        label.textColor = AppColors.black
        return label
    }()
    
    let provideFeedbackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AppColors.Rate.provideFeedbackButton
        button.layer.cornerRadius = 10
        button.setTitle(Text.Rating.provideFeedback, for: .normal)
        button.setTitleColor(AppColors.white, for: .normal)
        button.titleLabel?.font = AppLayout.Fonts.verySmallRegular
        return button
    }()
    
    let noThanksButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AppColors.Rate.noThanksButton
        button.layer.cornerRadius = 10
        button.setTitle(Text.Rating.noThanks, for: .normal)
        button.setTitleColor(AppColors.white, for: .normal)
        button.titleLabel?.font = AppLayout.Fonts.verySmallRegular
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let horizontalButtonsLabelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private let badButtonLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let normButtonLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let bestButtonLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let horizontalButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    // MARK: - Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private configure
    private func configureUI() {
        isOpaque = false
        backgroundColor = AppColors.Rate.backgroundTransparentRateView
        configureButtons()
        configureRateView()
        configureStackView()
        configureHorizontalImagesLabelsStackView()
        configureBadImageLabelStackView()
        configureNormImageLabelStackView()
        configureOkImageLabelStackView()
        configureHorizontalButtonsStackView()
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
        stackView.addArrangedSubviews(views: titleLabel,
                                      horizontalButtonsLabelsStackView,
                                      horizontalButtonsStackView)
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
    
    private func configureHorizontalImagesLabelsStackView() {
        horizontalButtonsLabelsStackView.addArrangedSubviews(views:
                                                                badButtonLabelStackView,
                                                             normButtonLabelStackView,
                                                             bestButtonLabelStackView)
    }
    
    private func configureBadImageLabelStackView() {
        badButtonLabelStackView.addArrangedSubviews(views: badSmileButton,badLabel)
    }
    
    private func configureNormImageLabelStackView() {
        normButtonLabelStackView.addArrangedSubviews(views: normSmileButton,normLabel)
    }
    
    private func configureOkImageLabelStackView() {
        bestButtonLabelStackView.addArrangedSubviews(views: bestSmileButton,bestLabel)
    }
    
    private func configureHorizontalButtonsStackView() {
        horizontalButtonsStackView.addArrangedSubviews(views: makeTranslucent(width: 0),
                                                       provideFeedbackButton,
                                                       noThanksButton,
                                                       makeTranslucent(width: 0))
    }
    
}
