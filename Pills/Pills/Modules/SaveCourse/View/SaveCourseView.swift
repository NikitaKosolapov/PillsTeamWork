//
//  SaveCourseView.swift
//  Pills
//
//  Created by NIKOLAI BORISOV on 28.10.2021.
//

import UIKit

protocol SaveCourseViewDelegate: AnyObject {
    func okButtonTapped()
}

final class SaveCourseView: UIView {
    
    // MARK: - Public Properties
    
    public weak var saveCourseDelegate: SaveCourseViewDelegate?
    
    // MARK: - Private Properties
    
    private let windowView: UIView = {
        return UIView()
    }()
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.black
        label.font = AppLayout.Fonts.bigSemibold
        label.textAlignment = .center
        label.text = "Сохранить"
        return label
    }()
    
    private let subitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.black
        label.font = AppLayout.Fonts.smallRegular
        label.textAlignment = .center
        label.text = "Курс успешно сохранен"
        return label
    }()
    
    private let okButton: AddButton = {
        let button = AddButton()
        button.setButtonStyle(
            backgroundColor: AppColors.blue,
            text: Text.SaveCourse.ok,
            font: AppLayout.Fonts.normalSemibold
        )
        button.titleLabel?.font = AppLayout.Fonts.normalSemibold
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainTitleLabel, subitleLabel])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = AppLayout.MedicineDescription.stackViewVerticalSpacing
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStackView, okButton])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = AppLayout.MedicineDescription.mainVerticalStackViewSpacing
        return stackView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubview()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addBlur(style: .light, alpha: 0.3, cornerRadius: 0, zPosition: -1)
    }
    
    // MARK: - Private Methods
    
    @objc private func buttonAction(sender: UIButton) {
    }
    
    private func setupView() {
        backgroundColor = AppColors.semiWhiteDarkTheme
        windowView.backgroundColor = AppColors.lightBlueSapphire
        
        windowView.layer.cornerCurve = .continuous
        windowView.layer.cornerRadius = AppLayout.MedicineDescription.windowViewCornerRadius
    }
    
    private func addSubview() {
        addSubview(windowView)
        windowView.addSubview(okButton)
        windowView.addSubview(labelStackView)
    }
    
    private func setupLayout() {
        
        windowView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(AppLayout.MedicineDescription.windowViewLeadingAndTopPadding)
            $0.height.equalTo(181)
        }

        labelStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(33)
            $0.leading.equalToSuperview().inset(32)
        }
        
        okButton.snp.makeConstraints {
            $0.width.equalTo(122)
            $0.height.equalTo(45)
            $0.bottom.equalToSuperview().inset(26)
            $0.leading.equalToSuperview().inset(83)
        }
    }
    
}
