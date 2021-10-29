//
//  CompletePillView.swift
//  Pills
//
//  Created by Mac on 20.10.2021.
//

import UIKit

protocol CompletePillViewDelegate: AnyObject {
    func yesButtonTouchUpInside()
    func noButtonTouchUpInside()
    func onCompletePillViewTapped()
}

final class CompletePillView: AlertView, UIGestureRecognizerDelegate {
    
    weak var completePillViewDelegate: CompletePillViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBlur(style: .light, alpha: 0.7, cornerRadius: 0, zPosition: -1)
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTapGestureOnView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Properties
    
    private func setupGestureRecognizer() -> UITapGestureRecognizer {
        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(onViewWithTapGestureTapped)
        )
        gestureRecognizer.delegate = self
        return gestureRecognizer
    }
    
    @objc private func onViewWithTapGestureTapped(sender: UITapGestureRecognizer) {
        completePillViewDelegate?.onCompletePillViewTapped()
    }
    
    private func addTapGestureOnView() {
        self.addGestureRecognizer(setupGestureRecognizer())
    }
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.centerStyleLabel(
            font: AppLayout.Fonts.smallRegular,
            text: Text.areYouSure
        )
        return label
    }()
    
    // MARK: - Private Methods
    
    override func agreeButtonTouchUpInside() {
        completePillViewDelegate?.yesButtonTouchUpInside()
    }
    
    override func denyButtonTouchUpInside() {
        completePillViewDelegate?.noButtonTouchUpInside()
    }
    
    override func configureView() {
        configureHeight(height: AppLayout.DeletePill.heightView)
        additionalField = descriptionLabel
        configureText(title: Text.complete, agree: Text.yes, deny: Text.no)
    }
}
