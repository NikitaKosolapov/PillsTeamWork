//
//  AddButton.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 27.07.2021.
//

import UIKit

class AddButton: UIButton {
    
    override var isEnabled: Bool {
        willSet {
            super.isEnabled = newValue
            backgroundColor =
                AppColors.blue.withAlphaComponent(
                    newValue ? 1 : 0.5
                )
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = AppColors.blue
        layer.cornerRadius = 10
        setTitle(Text.add, for: .normal)
        setTitleColor(AppColors.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }

    private func setupConstraint() {
        
    }
}
