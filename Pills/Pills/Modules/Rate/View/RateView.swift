//
//  RateView.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 09.08.2021.
//

import SnapKit
import UIKit

protocol RateViewDelegate: AnyObject {
    func badSmileButtonTouchUpInside()
    func normSmileButtonTouchUpInside()
    func bestSmileButtonTouchUpInside()
    func provideFeedbackButtonTouchUpInside()
    func noThanksButtonTouchUpInside()
}

final class RateView: AlertView {
    
    // MARK: - Public Properties
    
    public weak var rateViewDelegate: RateViewDelegate?
    
    // MARK: - Private Properties
    
    private let badSmileButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImages.Rate.badSmile, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(badSmileButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private let normSmileButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImages.Rate.normSmile, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(normSmileButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private let bestSmileButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImages.Rate.okSmile, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(bestSmileButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private let badLabel: UILabel = {
        let label = UILabel()
        label.centerStyleLabel(font: AppLayout.Fonts.smallRegular, text: Text.Rating.badRate)
        return label
    }()
    
    private let normLabel: UILabel = {
        let label = UILabel()
        label.centerStyleLabel(font: AppLayout.Fonts.smallRegular, text: Text.Rating.normRate)
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
    
    private lazy var badButtonLabelStackView = RateStackViewFactory.generate([badSmileButton, badLabel])
    private lazy var normButtonLabelStackView = RateStackViewFactory.generate([normSmileButton, normLabel])
    private lazy var bestButtonLabelStackView = RateStackViewFactory.generate([bestSmileButton, bestLabel])
    
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
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addBlur(style: .light, alpha: 0.7, cornerRadius: 0, zPosition: -1)
    }
    
    override func configureView() {
        configureHeight(height: AppLayout.Rate.heightView)
        additionalField = horizontalButtonsLabelsStackView
        configureText(title: Text.Rating.rateApp, agree: Text.Rating.provideFeedback, deny: Text.Rating.noThanks)
    }
    
    // MARK: - Actions
    
    @objc override func agreeButtonTouchUpInside() {
        rateViewDelegate?.provideFeedbackButtonTouchUpInside()
    }
    
    @objc override func denyButtonTouchUpInside() {
        rateViewDelegate?.noThanksButtonTouchUpInside()
    }
    
    @objc func badSmileButtonTouchUpInside() {
        rateViewDelegate?.badSmileButtonTouchUpInside()
    }
    
    @objc func normSmileButtonTouchUpInside() {
        rateViewDelegate?.normSmileButtonTouchUpInside()
    }
    
    @objc func bestSmileButtonTouchUpInside() {
        rateViewDelegate?.bestSmileButtonTouchUpInside()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = AppColors.semiWhiteDarkTheme
    }
    
    private func setupLayout() {
        badSmileButton.snp.makeConstraints { $0.height.equalTo(AppLayout.Rate.heightSmileImageView) }
        normSmileButton.snp.makeConstraints { $0.height.equalTo(AppLayout.Rate.heightSmileImageView) }
        bestSmileButton.snp.makeConstraints { $0.height.equalTo(AppLayout.Rate.heightSmileImageView) }
    }
    
}
