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
    
    private func createNotificationContent(title: String, body: String, identifier: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.userInfo = ["PillIdentifier": identifier]
        
        return content
    }
    
//    private func makeTrigger(interval: TimeInterval = 20) -> UNNotificationTrigger {
//        return UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
//    }
    
    private func createNotificationTrigger(date: Date, isNeedRepeat: Bool = true) -> UNCalendarNotificationTrigger {
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        let componentsForTime = Calendar.current.dateComponents([.hour, .minute], from: date)
        dateComponents.hour = componentsForTime.hour  // 14:00 hours
        dateComponents.minute = componentsForTime.minute
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: isNeedRepeat)
        
        return trigger
    }
    
    private func createAndRegisterNotificationRequest(with identifier: String,
                                                      content: UNMutableNotificationContent,
                                                      trigger: UNCalendarNotificationTrigger? = nil,
                                                      completion: @escaping (Error?) -> Void) {
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        notificationCenter.add(request, withCompletionHandler: completion)
    }
    
    func addNotificationModel(notificationModel: NotificationModel,
                              completion: @escaping (Error?) -> Void) {
        let content = createNotificationContent(title: notificationModel.title,
                                                body: notificationModel.body,
                                                identifier: notificationModel.identifier)
        let trigger = createNotificationTrigger(date: notificationModel.date)
        self.createAndRegisterNotificationRequest(with: notificationModel.identifier,
                                                  content: content,
                                                  trigger: trigger,
                                                  completion: completion)
        
    }
    
//    func send(title: String, subtitle: String, content: String, interval: TimeInterval = 20) {
//        if isNotificationGranted {
//            let message = makeContent(title: title, subtitle: subtitle, body: content)
//            let trigger = makeTrigger(interval: interval)
//
//            let request = UNNotificationRequest(identifier: "alarm",
//                                                content: message,
//                                                trigger: trigger
//            )
//
//            let center = notificationCenter
//
//            center.add(request) { error in
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
}
