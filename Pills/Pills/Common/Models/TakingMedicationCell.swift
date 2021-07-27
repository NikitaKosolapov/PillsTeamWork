//
//  TakingMedicationCell.swift
//  Pills
//
//  Created by Rayen on 27.07.2021.
//

import UIKit

class TakingMedicationCell: UITableViewCell {
    
    let pillsName = UILabel(text: "pillsName", font: .semibold17())
    let pillsTime = UILabel(text: "pillsTime", font:  .regular17(), alignment: .right)
    let pillsAmout = UILabel(text: "pillsAmout", font:  UIFont(name: "SF Compact Display", size: 17))
    let pillsAdmissionPeriod = UILabel(text: "pillsAdmissionPeriod", font: .regular13(), alignment: .right)
    let pillsConditionTime = UILabel(text: "pillsConditionTime", font:  .regular13(), alignment: .right)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        
        let cellStackView = UIStackView(arrangedSubviews: [pillsName, pillsTime],
                                        axis: .horizontal,
                                        spacing: 10,
                                        distribution: .fillEqually)
        
        self.addSubview(cellStackView)
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cellStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            cellStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            cellStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        self.addSubview(pillsAmout)
        NSLayoutConstraint.activate([
            pillsAmout.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            pillsAmout.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            pillsAmout.widthAnchor.constraint(equalToConstant: 100),
            pillsAmout.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        let bottomCellStackView = UIStackView(arrangedSubviews: [ pillsAdmissionPeriod, pillsConditionTime], axis: .horizontal, spacing: 5, distribution: .fillProportionally)
        
        self.addSubview(bottomCellStackView)
        NSLayoutConstraint.activate([
            bottomCellStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bottomCellStackView.leadingAnchor.constraint(equalTo: pillsAmout.trailingAnchor, constant: 5),
            bottomCellStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            bottomCellStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
    }
}
