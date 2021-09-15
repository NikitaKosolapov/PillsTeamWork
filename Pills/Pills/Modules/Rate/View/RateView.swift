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

final class RateView: AlertView {
    
    // MARK: - Public Properties
    
    weak var rateViewDelegate: RateViewDelegate?
    
    // MARK: - Private Properties
    
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
    
    // MARK: - Private Methods
    
    @objc internal override func agreeButtonTouchUpInside() {
        rateViewDelegate?.provideFeedbackButtonTouchUpInside()
    }
    
    @objc internal override func denyButtonTouchUpInside() {
        rateViewDelegate?.noThanksButtonTouchUpInside()
    }
    
    @objc internal func badSmileButtonTouchUpInside() {
        rateViewDelegate?.badSmileButtonTouchUpInside()
    }
    
    @objc internal func normSmileButtonTouchUpInside() {
        rateViewDelegate?.normSmileButtonTouchUpInside()
    }
    
    @objc internal func bestSmileButtonTouchUpInside() {
        rateViewDelegate?.bestSmileButtonTouchUpInside()
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
                                                        AppLayout.Rate.heightSmileImageView)])
    }
    
    override func configureView() {
        super.configureView()
        additionalField = horizontalButtonsLabelsStackView
        self.configureText(title: Text.Rating.rateApp, agree: Text.Rating.provideFeedback, deny: Text.Rating.noThanks)
    }

}
