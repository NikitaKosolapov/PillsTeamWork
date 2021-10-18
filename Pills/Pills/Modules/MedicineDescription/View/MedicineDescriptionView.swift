//
//  MedicineDescriptionView.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 14.09.2021.
//

import SnapKit
import UIKit

protocol MedicineDescriptionViewDelegate: AnyObject {
    func acceptButtonTapped()
    func skipButtonTapped()
}

/// Class provides UI elements for MedicineDescriptionVC
final class MedicineDescriptionView: UIView {
    
    // MARK: - Public Properties
    
    public weak var medicineDescriptionDelegate: MedicineDescriptionViewDelegate?
    
    // MARK: - Private Properties
    
    private let windowView: UIView = {
        return UIView()
    }()
    
    private var pillImageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.whiteOnly
        view.layer.cornerRadius = AppLayout.MedicineDescription.pillImageContainerRadius
        return view
    }()
    
    private var pillTypeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let pillNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.black
        label.font = AppLayout.MedicineDescription.pillNameFont
        label.textAlignment = .left
        return label
    }()
    
    private let pillsQuantityLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.semiGrayFont
        label.font = AppLayout.MedicineDescription.pillsQuantityFont
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let usageLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.semiGrayFont
        label.font = AppLayout.MedicineDescription.instructionFont
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.blackOnly
        label.font = AppLayout.MedicineDescription.timeFont
        label.textAlignment = .center
        label.layer.backgroundColor = AppColors.whiteOnly.cgColor
        label.layer.cornerRadius = AppLayout.MedicineDescription.timeLabelCornerRadius
        return label
    }()
    
    private let noteLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.black
        label.font = AppLayout.MedicineDescription.pillInstructionFont
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let acceptButton: AddButton = {
        let button = AddButton()
        button.setButtonStyle(
            backgroundColor: AppColors.blue,
            text: Text.MedicineDescription.accept,
            font: AppLayout.Fonts.rateButtonSmall
        )
        button.titleLabel?.font = AppLayout.Fonts.normalSemibold
        return button
    }()
    
    private let skipButton: AddButton = {
        let button = AddButton()
        button.setButtonStyle(
            backgroundColor: AppColors.red,
            text: Text.MedicineDescription.skip,
            font: AppLayout.Fonts.rateButtonSmall
        )
        button.titleLabel?.font = AppLayout.Fonts.normalSemibold
        return button
    }()
    
    private lazy var horizontalButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [acceptButton, skipButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = AppLayout.MedicineDescription.buttonStackViewSpacing
        return stackView
    }()
    
    private lazy var stackViewNameAndTime: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pillNameLabel, timeLabel])
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = AppLayout.MedicineDescription.defaultStackViewSpacing
        return stackView
    }()
    
    private lazy var stackViewQuantityAndUsage: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pillsQuantityLabel, usageLabel])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = AppLayout.MedicineDescription.defaultStackViewSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var stackViewVertical: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewNameAndTime, stackViewQuantityAndUsage])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = AppLayout.MedicineDescription.stackViewVerticalSpacing
        return stackView
    }()
    
    private lazy var stackViewHorizontal: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pillImageContainer, stackViewVertical])
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = AppLayout.MedicineDescription.stackViewHorizontalSpacing
        return stackView
    }()
    
    private lazy var mainVerticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewHorizontal, noteLabel, horizontalButtonStackView])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = AppLayout.MedicineDescription.mainVerticalStackViewSpacing
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
        setupLayout()
        addButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addBlur(style: .light, alpha: 0.3, cornerRadius: 0, zPosition: -1)
    }
    
    // MARK: - Public Methods
    
    public func set(with event: Event) {
        pillTypeImage.image = event.pill.pillType.image()
        pillNameLabel.text = event.pill.name
        timeLabel.text = dateToText(time: event.time)
        pillsQuantityLabel.text = "\(event.pill.singleDose)"
        usageLabel.text = event.pill.usageString
        noteLabel.text = event.pill.note
    }
    
    // MARK: - Private Methods
    
    private func dateToText(time: Date) -> String {
        return dateFormatter.string(from: time)
    }
    
    private func addButtonAction() {
        [acceptButton, skipButton].forEach {
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
        backgroundColor = AppColors.semiWhiteDarkTheme
        windowView.backgroundColor = AppColors.lightBlueSapphire
        
        windowView.layer.cornerCurve = .continuous
        windowView.layer.cornerRadius = AppLayout.MedicineDescription.windowViewCornerRadius
    }
    
    private func addSubview() {
        addSubview(windowView)
        windowView.addSubview(pillImageContainer)
        windowView.addSubview(noteLabel)
        pillImageContainer.addSubview(pillTypeImage)
        windowView.addSubview(mainVerticalStackView)
    }
    
    private func setupLayout() {
        
        mainVerticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(AppLayout.MedicineDescription.windowViewLeadingAndTopPadding)
        }
        pillImageContainer.snp.makeConstraints {
            $0.size.equalTo(AppLayout.MedicineDescription.pillImageContainerWidthAndHeight)
        }
        
        timeLabel.snp.makeConstraints {
            $0.width.equalTo(AppLayout.MedicineDescription.timeLabelWidth)
        }
        
        windowView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(AppLayout.MedicineDescription.windowViewLeadingAndTopPadding)
        }
        
        pillTypeImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        acceptButton.snp.makeConstraints {
            $0.height.equalTo(AppLayout.MedicineDescription.buttonStackViewHeight)
        }
        
        skipButton.snp.makeConstraints {
            $0.height.equalTo(AppLayout.MedicineDescription.buttonStackViewHeight)
        }
    }
    
}
