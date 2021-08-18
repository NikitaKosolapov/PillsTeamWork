//
//  NotificationService.swift
//  Pills
//
//  Created by Andrey on 08/08/2021.
//

import UserNotifications

class NotificationService {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    var isNotificationGranted: Bool = false
    
    func registerForNotifications() {
        notificationCenter.getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization { (success) in
                    guard success else {
                        return
                    }
                    print("Request Authorization success")
                    self.isNotificationGranted = true
                }
            case .denied:
                print("Application Not Allowed to Display Notifications")
                self.isNotificationGranted = false
            default:
                break
            }
        }
    }
    
    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> Void) {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            completionHandler(success)
        }
    }
    
    private func makeContent(title: String, subtitle: String, body: String) -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.badge = 1
        
        return content
    }
    
    private func makeTrigger(interval: TimeInterval = 20) -> UNNotificationTrigger {
        return UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
    }
    
    func send(title: String, subtitle: String, content: String, interval: TimeInterval = 20) {
        if isNotificationGranted {
            let message = makeContent(title: title, subtitle: subtitle, body: content)
            let trigger = makeTrigger(interval: interval)
            
            let request = UNNotificationRequest(identifier: "alarm",
                                                content: message,
                                                trigger: trigger
            )
            
            let center = notificationCenter
            
            center.add(request) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
