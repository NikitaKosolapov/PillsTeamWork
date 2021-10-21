//
//  SettingsViewTableCell.swift
//  Pills
//
//  Created by GrRoman on 17.08.2021.
//

import SnapKit
import UIKit

protocol SettingsViewTableCellDelegate: AnyObject {
    func setColor(backgroundColor: UIColor)
    func setName(name: String)
    func setButtonVisible(visible: Bool)
    func setSwitchVisible(visible: Bool)
}

class SettingsViewTableCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.lightGray
        view.layer.cornerRadius = AppLayout.Settings.cellCornerRadius
        return view
    }()
    
    private let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppLayout.Fonts.normalRegular
        label.numberOfLines = 0
        label.textColor = AppColors.black
        return label
    }()
    
    private let accessoryButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.tintColor = AppColors.grayWhite
        button.isHidden = false
        return button
    }()
    
    private let notificationsSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.isHidden = false
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.onTintColor = AppColors.blue
        return switcher
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        addSubviews()
        setupLayout()

        backgroundColor = AppColors.white
        self.selectionStyle = .none
        
        notificationsSwitch.addTarget(self, action: #selector(switchChange(paramTarget:)) , for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func switchChange(paramTarget: UISwitch) {
        debugPrint("Switch changed")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        selectionStyle = .none
    }
    
    private func addSubviews() {
        addSubview(backgroundViewCell)
        addSubview(accessoryButton)
        contentView.addSubview(notificationsSwitch)
        addSubview(cellTitleLabel)
    }
    
    private func setupLayout() {
        
        backgroundViewCell.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(AppLayout.Settings.cellPaddingTopAndBottom)
            $0.leading.trailing.equalToSuperview().inset(AppLayout.Settings.cellPaddingLeadingAndTrailing)
        }
        
        accessoryButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(AppLayout.Settings.accessoryButtonPaddingTrailing)
        }
        
        notificationsSwitch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(AppLayout.Settings.notificationsSwitchPaddingTrailing)
        }
        
        cellTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(backgroundViewCell.snp.leading).offset(AppLayout.Settings.titleLabelPaddingLeading)
            $0.trailing.equalTo(notificationsSwitch.snp.leading).offset(AppLayout.Settings.titleLabelPaddingTrailing)
        }
    }
    
}

// MARK: - SettingsViewTableCellDelegate

extension SettingsViewTableCell: SettingsViewTableCellDelegate {
    func setButtonVisible(visible: Bool) {
        accessoryButton.isHidden = !visible
    }
    
    func setSwitchVisible(visible: Bool) {
        notificationsSwitch.isHidden = !visible
    }
    
    func setName(name: String) {
        cellTitleLabel.text = name
    }
    
    func setColor(backgroundColor: UIColor) {
        backgroundViewCell.backgroundColor = backgroundColor
    }
}
