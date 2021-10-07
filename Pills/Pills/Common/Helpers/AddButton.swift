//
//  AddButton.swift
//  Pills
//
//  Created by Alexandr Evtodiy on 27.07.2021.
//

import UIKit

/// Класс отвечает за настройку кнопки типа Add
final class AddButton: UIButton {
    
    override var isEnabled: Bool {
        willSet {
            backgroundColor = AppColors.blue.withAlphaComponent(newValue ? 1 : 0.5)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if titleLabel?.text == "No, thanks" ||
                titleLabel?.text == "Нет, спасибо" ||
                titleLabel?.text == "Skip" ||
                titleLabel?.text == "Пропустить" {
                backgroundColor = isHighlighted ? AppColors.selectedRed : AppColors.red
            } else {
                backgroundColor = isHighlighted ? AppColors.selectedBlue : AppColors.blue
            }
            
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = AppColors.blue
        layer.cornerRadius = 10
        setTitle(Text.add, for: .normal)
        setTitleColor(AppColors.whiteOnly, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    private func setupConstraint() {}
}
