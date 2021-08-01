//
//  AddButton.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 27.07.2021.
//

import UIKit

class AddButton: UIButton {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = AppColors.AidKit.addButton
        layer.cornerRadius = 10
        setTitle(Text.add, for: .normal)
        setTitleColor(AppColors.AidKit.addButtonText, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    private func setupConstraint() {
        NSLayoutConstraint.activate(
            [widthAnchor.constraint(equalToConstant: AppLayout.widthAddButton),
             heightAnchor.constraint(equalToConstant: AppLayout.heightAddButton)])
    }
}
