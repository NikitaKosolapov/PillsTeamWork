//
//  ReviewRequest.swift
//  Pills
//
//  Created by AntonSobolev on 01.11.2021.
//

import Foundation
import StoreKit

enum RequestFrom {
    case addPill, pillsTaken
}

class ReviewRequest {
    
    private static let maximumCountOfAddedCourses = 3
    private static let maximumCountOfTakenPills = 10
    
    class func requestReview(count: Int, by action: RequestFrom) {
        
        let infoDictionaryKey = kCFBundleVersionKey as String
        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
            else { fatalError("Expected to find a bundle version in the info dictionary") }
        
        let lastVersionPromptedForReview = UserDefaults.standard
                                            .string(forKey: UserDefaultsKeys.lastVersionPromptedForReviewKey)
        
        switch action {
        case .addPill:
            if count >= maximumCountOfAddedCourses && currentVersion != lastVersionPromptedForReview {
                requestReview()
                UserDefaults.standard.set(0, forKey: UserDefaultsKeys.addNewCourseCompletedCount)
            } else {
                break
            }
        case .pillsTaken:
            if count >= maximumCountOfTakenPills && currentVersion != lastVersionPromptedForReview {
                requestReview()
                UserDefaults.standard.set(0, forKey: UserDefaultsKeys.pillCompletedCount)
            } else {
                break
            }
        }
    }
    
    class func requestReviewManually() {
        // Note: Replace the XXXXXXXXXX below with the App Store ID for app
        guard let writeReviewURL = URL(string: "https://apps.apple.com/app/idXXXXXXXXXX?action=write-review")
            else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
    
    private class func requestReview() {
        DispatchQueue.main.async {
            SKStoreReviewController.requestReview()
        }
    }
}
