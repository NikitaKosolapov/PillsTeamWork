//
//  SettingsViewController.swift
//  Pills
//
//  Created by GrRoman on 22.07.2021.
//

import UIKit
import MessageUI

final class SettingsViewController: UITableViewController {
    
    // Main section
    let languageCell: UITableViewCell = UITableViewCell()
    let notificationCell: UITableViewCell = UITableViewCell()
    let writeSupportCell: UITableViewCell = UITableViewCell()
    
    // Info section
    let termsOfUsageCell: UITableViewCell = UITableViewCell()
    let privacyPolicyCell: UITableViewCell = UITableViewCell()
    let aboutAppCell: UITableViewCell = UITableViewCell()
    
    let notificationSwitch: UISwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Text.Tabs.settings
        
        tableView.bounces = false
        
        // Main section
        languageCell.textLabel?.text = Text.Settings.language
        languageCell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        // construct UISwitch cell
        notificationCell.textLabel?.text = Text.Settings.notification
        notificationSwitch.setOn(true, animated: true)
        notificationSwitch.tag = 1
        notificationCell.accessoryView = self.notificationSwitch
        notificationSwitch.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        
        writeSupportCell.textLabel?.text = Text.Settings.writeSupport
        writeSupportCell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        // Info section
        termsOfUsageCell.textLabel?.text = Text.Settings.termsOfUsage
        termsOfUsageCell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        privacyPolicyCell.textLabel?.text = Text.Settings.privacyPolicy
        privacyPolicyCell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        aboutAppCell.textLabel?.text = Text.Settings.aboutApp
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
            case 2: return writeSupportCell
            default: fatalError("Unknown row in section 0")
            }
        } else {
            switch(indexPath.row) {
            case 0: return termsOfUsageCell
            case 1: return privacyPolicyCell
            case 2: return aboutAppCell
            default: fatalError("Unknown row in section 1")
            }
        }
        
    }
    
    // Customize the section headings for each section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0: return Text.Settings.mainSection
        case 1: return Text.Settings.infoSection
        default: fatalError("Unknown section")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath {
        case [0, 0]:
            debugPrint("Language tapped")
        case [0, 1]:
            debugPrint("Notification tapped")
        case [0, 2]:
            debugPrint("Email tapped")
            sendEmail()
        case [1, 0]:
            debugPrint("TermUse tapped")
        case [1, 1]:
            debugPrint("Policy tapped")
        case [1, 2]:
            debugPrint("About tapped")
        default:
            debugPrint("Error tapped")
        }
    }
    
    @objc func switchChanged(_ sender : UISwitch!) {

    }
    
}

// MARK: - Send mail

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([AppConstant.Emails.feedback])
            mail.setSubject(Text.Feedback.subject)
            mail.setMessageBody(createMessage(), isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
            print("Could not send email!")
        }
    }
    
    internal func mailComposeController(_ controller: MFMailComposeViewController,
                                        didFinishWith result: MFMailComposeResult,
                                        error: Error?) {
        print(error?.localizedDescription ?? "No error")
        controller.dismiss(animated: true)
    }
    
    func createMessage() -> String {
        let systemVersion = UIDevice.current.systemVersion
        let deviceModel = UIDevice.modelName
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
        
        var messageText = "<p>\(Text.Feedback.hello)</p>"
        messageText += "<br>"
        messageText += "<p>\(Text.Feedback.iOSVersion) \(systemVersion)</p>"
        messageText += "<p>\(Text.Feedback.deviceModel) \(deviceModel)</p>"
        messageText += "<p>\(Text.Feedback.appVersion) \(appVersion ?? "0.0")</p>"
        
        return messageText
    }
    
}
