//
//  SettingsViewTableCell.swift
//  Pills
//
//  Created by GrRoman on 17.08.2021.
//

import UIKit

protocol SettingsViewTableCellDelegate: AnyObject {
    func setColor(backgroundColor: UIColor)
    func setName(name: String)
    func setButtonVisible(visible: Bool)
    func setSwitcVisible(visible: Bool)
}

class SettingsViewTableCell: UITableViewCell {
    
    private let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.lightGray
        view.layer.cornerRadius = AppLayout.Settings.cellCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppLayout.Fonts.normalRegular
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AppColors.black
        return label
    }()
    
    private let accessoryButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.tintColor = AppColors.semiGrayOnly
        button.isHidden = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let notificationsSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = true
        switcher.isHidden = false
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.onTintColor = AppColors.greenBlue
        return switcher
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setConstraints()
        
        notificationsSwitch.addTarget(self, action: #selector(switchChange(paramTarget:)) , for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func switchChange(paramTarget: UISwitch) {
        debugPrint("Switch changed")
    }
    
    func setConstraints() {
        
        self.addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6)
        ])
        
        self.addSubview(accessoryButton)
        NSLayoutConstraint.activate([
            accessoryButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            accessoryButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -42)
        ])
        
        self.contentView.addSubview(notificationsSwitch)
        NSLayoutConstraint.activate([
            notificationsSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            notificationsSwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -42)
        ])
        
        self.addSubview(cellTitleLabel)
        NSLayoutConstraint.activate([
            cellTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellTitleLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 24),
            cellTitleLabel.trailingAnchor.constraint(equalTo: notificationsSwitch.leadingAnchor, constant: -10)
        ])
        
    }
    
}

// MARK: - SettingsViewTableCellDelegate

extension SettingsViewTableCell: SettingsViewTableCellDelegate {
    func setButtonVisible(visible: Bool) {
        accessoryButton.isHidden = !visible
    }
    
    func setSwitcVisible(visible: Bool) {
        notificationsSwitch.isHidden = !visible
    }
    
    func setName(name: String) {
        cellTitleLabel.text = name
    }
    
    func setColor(backgroundColor: UIColor) {
        backgroundViewCell.backgroundColor = backgroundColor
    }
}
