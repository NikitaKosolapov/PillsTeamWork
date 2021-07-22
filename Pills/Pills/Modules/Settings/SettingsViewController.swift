//
//  SettingsViewController.swift
//  Pills
//
//  Created by GrRoman on 22.07.2021.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    // Main section
    let languageCell: UITableViewCell = UITableViewCell()
    let notificationCell: UITableViewCell = UITableViewCell()
    let         writeSupportCell: UITableViewCell = UITableViewCell()
    
    // Info section
    let         termsOfUsageCell: UITableViewCell = UITableViewCell()
    let privacyPolicyCell: UITableViewCell = UITableViewCell()
    let aboutAppCell: UITableViewCell = UITableViewCell()
    
    let notificationSwitch: UISwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "settings".localized()
        
        // Main section
        languageCell.textLabel?.text = "language".localized()
        languageCell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        // construct UISwitch cell
        notificationCell.textLabel?.text = "notification".localized()
        notificationSwitch.setOn(true, animated: true)
        notificationSwitch.tag = 1
        notificationCell.accessoryView = self.notificationSwitch
        notificationSwitch.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        
        writeSupportCell.textLabel?.text = "writeSupport".localized()
        writeSupportCell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        // Info section
        termsOfUsageCell.textLabel?.text = "termsOfUsage".localized()
        termsOfUsageCell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        privacyPolicyCell.textLabel?.text = "privacyPolicy".localized()
        privacyPolicyCell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        aboutAppCell.textLabel?.text = "aboutApp".localized()
        aboutAppCell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
    }
    
    // Return the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Return the number of rows for each section in your static table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 3
        case 1: return 3
        default: fatalError("Unknown number of sections")
        }
    }
    
    // Return the row for the corresponding section and row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            switch(indexPath.row) {
            case 0: return languageCell
            case 1: return notificationCell
            case 2: return         writeSupportCell
            default: fatalError("Unknown row in section 0")
            }
        } else {
            switch(indexPath.row) {
            case 0: return         termsOfUsageCell
            case 1: return privacyPolicyCell
            case 2: return aboutAppCell
            default: fatalError("Unknown row in section 1")
            }
        }
        
    }
    
    // Customize the section headings for each section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0: return "mainSection".localized()
        case 1: return "infoSection".localized()
        default: fatalError("Unknown section")
        }
    }
    
    @objc func switchChanged(_ sender : UISwitch!) {
//        print("Switch changed \(sender.tag)")
//        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
}
