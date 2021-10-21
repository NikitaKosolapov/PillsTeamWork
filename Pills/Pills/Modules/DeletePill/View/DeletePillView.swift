//
//  DeletePillView.swift
//  Pills
//
//  Created by Margarita Novokhatskaia on 22.09.2021.
//

import UIKit

protocol DeletePillViewDelegate: AnyObject {
    func deleteButtonTouchUpInside()
    func cancelButtonTouchUpInside()
}

final class DeletePillView: AlertView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBlur(style: .light, alpha: 0.7, cornerRadius: 0, zPosition: -1)
    }
    
    weak var deletePillViewDelegate: DeletePillViewDelegate?
    
    // MARK: - Private Properties
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.centerStyleLabel(
            font: AppLayout.Fonts.smallRegular,
            text: Text.deletePillDescription
        )
        return label
    }()

    // MARK: - Private Methods
    
    override func agreeButtonTouchUpInside() {
        deletePillViewDelegate?.cancelButtonTouchUpInside()
    }
    
    override func denyButtonTouchUpInside() {
        deletePillViewDelegate?.deleteButtonTouchUpInside()
    }
    
    override func configureView() {
        configureHeight(height: AppLayout.DeletePill.heightView)
        additionalField = descriptionLabel
        configureText(title: Text.delete, agree: Text.cancellation, deny: Text.delete)
    }
}
