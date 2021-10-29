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
    func onDeletePillViewTapped()
}

final class DeletePillView: AlertView, UIGestureRecognizerDelegate {
    
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
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTapGestureOnView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupGestureRecognizer() -> UITapGestureRecognizer {
        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(onViewWithTapGestureTapped)
        )
        gestureRecognizer.delegate = self
        return gestureRecognizer
    }
    
    @objc private func onViewWithTapGestureTapped(sender: UITapGestureRecognizer) {
        deletePillViewDelegate?.onDeletePillViewTapped()
    }
    
    private func addTapGestureOnView() {
        self.addGestureRecognizer(setupGestureRecognizer())
    }
    
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
