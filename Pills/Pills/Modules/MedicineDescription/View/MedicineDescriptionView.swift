//
//  MedicineDescriptionView.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 14.09.2021.
//

import UIKit

protocol MedicineDescriptionViewDelegate: AnyObject {
    func acceptButtonTapped()
    func skipButtonTapped()
}

/// Class provides UI elements for MedicineDescriptionVC
final class MedicineDescriptionView: UIView {
    
    // MARK: - Public Properties
    
    weak var medicineDescriptionDelegate: MedicineDescriptionViewDelegate?
    
    // MARK: - Private Properties
    
    private let descriptionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = AppColors.lightBlueSapphire
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var pillImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.whiteOnly
        view.layer.cornerRadius = AppLayout.MedicineDescription.pillImageContainerRadius
        return view
    }()
    
    private var pillTypeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "tablets")
        return imageView
    }()
    
    private let pillNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.black
        label.font = AppLayout.MedicineDescription.pillNameFont
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pillsQuantityLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.black
        label.font = AppLayout.MedicineDescription.pillsQuantityFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let usageLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.black
        label.font = AppLayout.MedicineDescription.instructionFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.blackOnly
        label.font = AppLayout.MedicineDescription.timeFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.backgroundColor = AppColors.whiteOnly.cgColor
        label.layer.cornerRadius = 4
        return label
    }()
    
    private let pillInstructionLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.black
        label.font = AppLayout.MedicineDescription.pillInstructionFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let acceptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.rateStyleButton(
            backgroundColor: AppColors.blue,
            text: Text.MedicineDescription.accept
        )
        return button
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.rateStyleButton(
            backgroundColor: AppColors.red,
            text: Text.MedicineDescription.skip
        )
        return button
    }()
    
    private let horizontalButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var stackViewNameAndTime: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = AppLayout.MedicineDescription.defaultStackViewSpacing
        return stackView
    }()
    
    private lazy var stackViewQuantityAndUsage: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = AppLayout.MedicineDescription.defaultStackViewSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var stackViewVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var stackViewHorizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = AppLayout.MedicineDescription.defaultStackViewSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addSubview()
        setupConstraints()
        addButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func addButtonAction() {
        [
            acceptButton,
            skipButton
        ].forEach {
            $0.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        }
    }
    
    @objc private func buttonAction(sender: UIButton) {
        switch sender {
        case acceptButton:
            medicineDescriptionDelegate?.acceptButtonTapped()
        case skipButton:
            medicineDescriptionDelegate?.skipButtonTapped()
        default:
            return
        }
    }
    
    private func setupView() {
        backgroundColor = AppColors.semiWhite
    }
    
    private func addSubview() {
        addSubview(descriptionView)
        addSubview(pillInstructionLabel)
        descriptionView.addSubview(stackViewHorizontal)
        pillImageContainer.addSubview(pillTypeImage)
        
        stackViewNameAndTime.addArrangedSubview(pillNameLabel)
        stackViewNameAndTime.addArrangedSubview(timeLabel)
        
        stackViewQuantityAndUsage.addArrangedSubview(pillsQuantityLabel)
        stackViewQuantityAndUsage.addArrangedSubview(usageLabel)
        
        stackViewVertical.addArrangedSubview(stackViewNameAndTime)
        stackViewVertical.addArrangedSubview(stackViewQuantityAndUsage)
        
        stackViewHorizontal.addArrangedSubview(pillImageContainer)
        stackViewHorizontal.addArrangedSubview(stackViewVertical)
        
        horizontalButtonStackView.addArrangedSubview(acceptButton)
        horizontalButtonStackView.addArrangedSubview(skipButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionView.widthAnchor.constraint(equalToConstant: 200),
            descriptionView.heightAnchor.constraint(equalToConstant: 200)
            
//            descriptionView.topAnchor.constraint(
//                equalTo: safeAreaLayoutGuide.topAnchor,
//                constant: AppLayout.MedicineDescription.topDescriptionView
//            ),
//            descriptionView.leadingAnchor.constraint(
//                equalTo: safeAreaLayoutGuide.leadingAnchor,
//                constant: AppLayout.MedicineDescription.descriptionViewLeading
//            ),
//            descriptionView.trailingAnchor.constraint(
//                equalTo: safeAreaLayoutGuide.leadingAnchor,
//                constant: AppLayout.MedicineDescription.descriptionViewtrailing
//            ),
//            descriptionView.heightAnchor.constraint(
//                equalToConstant: AppLayout.MedicineDescription.descriptionViewHeight
//            )
        ])
        NSLayoutConstraint.activate([
            stackViewHorizontal.topAnchor.constraint(
                equalTo: descriptionView.topAnchor,
                constant: AppLayout.MedicineDescription.topAnchorDescriptionView
            ),
            stackViewHorizontal.leadingAnchor.constraint(
                equalTo: descriptionView.leadingAnchor,
                constant: AppLayout.MedicineDescription.descriptionViewLeading
            ),
            stackViewHorizontal.trailingAnchor.constraint(
                equalTo: descriptionView.trailingAnchor,
                constant: AppLayout.MedicineDescription.descriptionViewtrailing
            ),
            //            stackViewHorizontal.bottomAnchor.constraint(
            //                equalTo: safeArea.bottomAnchor,
            //                constant: AppLayout.Rate.bottomStackView
            //            )
        ])
    }
    
}
