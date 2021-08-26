//
//  SettingsViewController.swift
//  Pills
//
//  Created by GrRoman on 22.07.2021.
//

import UIKit
import MessageUI
import DeviceKit

final class SettingsViewController: UITableViewController {
    
    enum SettingsSections : String {
        case about
        case writeSupport
        case notification
        case termsOfUsage
        case privacyPolicy
        case rate
        
        var rawValue: String {
            switch self {
            case .about:
                return Text.Settings.aboutApp
            case .writeSupport:
                return Text.Settings.writeSupport
            case .notification:
                return Text.Settings.notification
            case .termsOfUsage:
                return Text.Settings.termsOfUsage
            case .privacyPolicy:
                return Text.Settings.privacyPolicy
            case .rate:
                return Text.Settings.rate
            }
        }
    }
    
    let settings: [SettingsSections] = [.about, .writeSupport, .notification, .termsOfUsage, .privacyPolicy, .rate]
    
    let idSettingsCell = "idSettingsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Text.Tabs.settings
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsViewTableCell.self, forCellReuseIdentifier: idSettingsCell)
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        
    }
    
    // Return the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Return the number of rows for each section in your static table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    // Return the row for the corresponding section and row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idSettingsCell,
                                                 for: indexPath) as! SettingsViewTableCell
        let setting = settings[indexPath.row]
        
        cell.setName(name: setting.rawValue)
        
        switch setting {
        case .notification:
            cell.setButtonVisible(visible: false)
            cell.setSwitcVisible(visible: true)
        default:
            cell.setButtonVisible(visible: true)
            cell.setSwitcVisible(visible: false)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AppLayout.Settings.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SettingsViewTableCell {
            cell.setColor(backgroundColor: AppColors.SettingsColor.cellHighlight)
        }
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SettingsViewTableCell {
            cell.setColor(backgroundColor: AppColors.SettingsColor.cellUnhighlight)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let setting = settings[indexPath.row]
        
        switch setting {
        case .about:
            debugPrint("About tapped")
        case .writeSupport:
            sendEmail()
        case .notification:
            debugPrint("Notification tapped")
        case .termsOfUsage:
            openUrl(url: AppConstant.Urls.terms)
        case .privacyPolicy:
            openUrl(url: AppConstant.Urls.policy)
        case .rate:
            debugPrint("Rate tapped")
        }
    }
    
    func openUrl(url : String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
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
        let deviceModel = Device.current
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
        
        var messageText = "<p>\(Text.Feedback.hello)</p>"
        messageText += "<br>"
        messageText += "<p>\(Text.Feedback.iOSVersion) \(systemVersion)</p>"
        messageText += "<p>\(Text.Feedback.deviceModel) \(deviceModel)</p>"
        messageText += "<p>\(Text.Feedback.appVersion) \(appVersion ?? "0.0")</p>"
        
        return messageText
    }
    
}
