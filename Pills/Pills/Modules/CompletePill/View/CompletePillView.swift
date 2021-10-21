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
}

final class CompletePillView: AlertView {
    
    weak var completePillViewDelegate: CompletePillViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBlur(style: .light, alpha: 0.7, cornerRadius: 0, zPosition: -1)
    }
    
    // MARK: - Private Properties
    
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
