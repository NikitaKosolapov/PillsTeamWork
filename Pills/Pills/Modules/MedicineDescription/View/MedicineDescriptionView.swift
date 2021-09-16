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
        imageView.image = UIImage(named: "capsules")
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
        label.text = "00:00"
        return label
    }()
    
    private let pillInstructionLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.black
        label.font = AppLayout.MedicineDescription.pillInstructionFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Проглатывать, запивая водой, нельзя принимать одновременно с другими лекарствами, особенно с антибиотиком"
        return label
    }()
    
    private let acceptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.rateStyleButton(
            backgroundColor: AppColors.blue,
            text: Text.MedicineDescription.accept
        )
        button.titleLabel?.font = AppLayout.Fonts.normalSemibold
        return button
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.rateStyleButton(
            backgroundColor: AppColors.red,
            text: Text.MedicineDescription.skip
        )
        button.titleLabel?.font = AppLayout.Fonts.normalSemibold
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
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var stackViewHorizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = AppLayout.MedicineDescription.defaultStackViewSpacing
        stackView.alignment = .fill
        stackView.spacing = 13
        return stackView
    }()
    
    private lazy var mainVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 14
        return stackView
    }()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
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
    
    // MARK: - Public Methods
    
    public func set(with event: Event) {
        pillTypeImage.image = event.pill.pillType.image()
        pillNameLabel.text = event.pill.name
        timeLabel.text = dateToText(time: event.time)
        pillsQuantityLabel.text = "\(event.pill.singleDose)"
        usageLabel.text = event.pill.usageString
        pillInstructionLabel.text = event.pill.note
    }
    
    // MARK: - Private Methods
    
    private func dateToText(time: Date) -> String {
        return dateFormatter.string(from: time)
    }
    
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
        
        descriptionView.addSubview(pillImageContainer)
        descriptionView.addSubview(pillInstructionLabel)
        pillImageContainer.addSubview(pillTypeImage)
        
        stackViewNameAndTime.addArrangedSubview(pillNameLabel)
        stackViewNameAndTime.addArrangedSubview(timeLabel)
        
        stackViewQuantityAndUsage.addArrangedSubview(pillsQuantityLabel)
        stackViewQuantityAndUsage.addArrangedSubview(usageLabel)
        
        stackViewVertical.addArrangedSubview(stackViewNameAndTime)
        stackViewVertical.addArrangedSubview(stackViewQuantityAndUsage)
        
        horizontalButtonStackView.addArrangedSubview(acceptButton)
        horizontalButtonStackView.addArrangedSubview(skipButton)
        
        stackViewHorizontal.addArrangedSubview(pillImageContainer)
        stackViewHorizontal.addArrangedSubview(stackViewVertical)
        
        descriptionView.addSubview(mainVerticalStackView)
        mainVerticalStackView.addArrangedSubview(stackViewHorizontal)
        mainVerticalStackView.addArrangedSubview(pillInstructionLabel)
        mainVerticalStackView.addArrangedSubview(horizontalButtonStackView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            mainVerticalStackView.leadingAnchor.constraint(
                equalTo: descriptionView.leadingAnchor,
                constant: AppLayout.MedicineDescription.descriptionViewLeading
            ),
            mainVerticalStackView.trailingAnchor.constraint(
                equalTo: descriptionView.trailingAnchor,
                constant: AppLayout.MedicineDescription.descriptionViewTrailing
            ),
            mainVerticalStackView.topAnchor.constraint(
                equalTo: descriptionView.topAnchor,
                constant: AppLayout.MedicineDescription.descriptionViewTopAnchor
            ),
            mainVerticalStackView.bottomAnchor.constraint(
                equalTo: descriptionView.bottomAnchor,
                constant: AppLayout.MedicineDescription.descriptionViewBottomAnchor
            )
        ])
        
        NSLayoutConstraint.activate([
            pillImageContainer.widthAnchor.constraint(
                equalToConstant: AppLayout.MedicineDescription.stackViewHorizontalHeight
            ),
            pillImageContainer.heightAnchor.constraint(
                equalToConstant: AppLayout.MedicineDescription.stackViewHorizontalHeight
            )
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.widthAnchor.constraint(
                equalToConstant: AppLayout.MedicineDescription.timeLabelWidth
            )
        ])
        
        NSLayoutConstraint.activate([
            descriptionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionView.widthAnchor.constraint(
                equalToConstant: AppLayout.MedicineDescription.descriptionViewWidth
            )
        ])
        
        NSLayoutConstraint.activate([
            pillTypeImage.centerXAnchor.constraint(equalTo: pillImageContainer.centerXAnchor),
            pillTypeImage.centerYAnchor.constraint(equalTo: pillImageContainer.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            acceptButton.heightAnchor.constraint(
                equalToConstant: AppLayout.MedicineDescription.horizontalButtonStackViewHeight
            ),
            skipButton.heightAnchor.constraint(
                equalToConstant: AppLayout.MedicineDescription.horizontalButtonStackViewHeight
            )

        ])
    }
    
}
