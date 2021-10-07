//
//  AppDelegate.swift
//  Pills
//
//  Created by aprirez on 7/12/21.
//

import UIKit
import DropDown
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let notificationService = NotificationService()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
            [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        configure()
        DropDown.startListeningToKeyboard()
        FirebaseApp.configure()
        return true
    }
    
}

extension AppDelegate {
    func configure() {
        instantiateInitialViewController()
        configureNotificationService()
    }
    
    func instantiateInitialViewController() {
        let appCoordinator = AppCoordinator(appDelegate: self)
        appCoordinator.instantiateInitialViewController()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func configureNotificationService() {
        notificationService.registerForNotifications()
        notificationService.notificationCenter.delegate = self
        addNotifications()
        
    }
    
    func addNotifications() {
        let journalEntries: [RealmMedKitEntry] = [ // MOCK data to be removed once DB and business logic are both finalised
            JournalMock.shared.entryExample1,
            JournalMock.shared.entryExample2
        ]
        journalEntries.forEach({ pill in
            pill.schedule.forEach({ date in
                let model = NotificationModel(identifier: pill.entryID,
                                              title: Text.PushNotifications.itIsTimeToTakePill,
                                              subTitile: "",
                                              body: pill.name,
                                              date: date.time,
                                              isRepeating: true)
                debugPrint("date.time:", date.time)
                notificationService.addNotificationModel(notificationModel: model) { _ in
                }
            })
        })
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
                                    @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound,.badge])
    }
    
}
